using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using FoodBridge.Application.Common;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;
using FoodBridge.Domain.Entities;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Application.Services.Implementations;

public class ReservationService : IReservationService
{
    private readonly IApplicationDbContext _context;
    private readonly INotificationService _notificationService;

    public ReservationService(
        IApplicationDbContext context,
        INotificationService notificationService)
    {
        _context = context;
        _notificationService = notificationService;
    }

    public async Task<Result<ReservationDto>> RequestReservationAsync(string charityId, int foodListingId)
    {
        var charity = await _context.Users.FindAsync(charityId);
        if (charity == null)
        {
            return Result<ReservationDto>.Failure("Charity user not found.");
        }

        if (charity.Status == UserStatus.Suspended)
        {
            return Result<ReservationDto>.Failure("Charity account is suspended.");
        }

        var listing = await _context.FoodListings
            .Include(l => l.Provider)
            .FirstOrDefaultAsync(l => l.Id == foodListingId);

        if (listing == null)
        {
            return Result<ReservationDto>.Failure("Food listing not found.");
        }

        if (listing.ProviderId == charityId)
        {
            return Result<ReservationDto>.Failure("Invalid operation: Providers cannot claim or reserve their own food donations.");
        }

        if (listing.Status != FoodListingStatus.Available)
        {
            return Result<ReservationDto>.Failure($"This donation is currently not available for reservation (Status: {listing.Status}).");
        }

        if (listing.PickupDeadline < DateTime.UtcNow)
        {
            listing.Status = FoodListingStatus.Expired;
            await _context.SaveChangesAsync();
            return Result<ReservationDto>.Failure("This donation listing has expired.");
        }

        var existingRequest = await _context.Reservations
            .AnyAsync(r => r.FoodListingId == foodListingId 
                           && r.CharityId == charityId 
                           && r.Status != ReservationStatus.Rejected 
                           && r.Status != ReservationStatus.Cancelled);

        if (existingRequest)
        {
            return Result<ReservationDto>.Failure("You already have an active reservation or pending request for this listing.");
        }

        var reservation = new Reservation
        {
            FoodListingId = foodListingId,
            CharityId = charityId,
            RequestDate = DateTimeOffset.UtcNow,
            Status = ReservationStatus.Pending
        };

        _context.Reservations.Add(reservation);

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<ReservationDto>.Failure("A conflict occurred while creating the reservation. Please try again.");
        }

        await _notificationService.SendNotificationAsync(
            listing.ProviderId,
            "New Reservation Request",
            $"{charity.OrganizationName} requested reservation for '{listing.FoodName}'.",
            $"reservation:{reservation.Id}");

        return await GetReservationByIdAsync(reservation.Id, charityId);
    }

    public async Task<Result<ReservationDto>> AcceptReservationAsync(string providerId, int reservationId, AcceptReservationDto dto)
    {
        var reservation = await _context.Reservations
            .Include(r => r.FoodListing)
            .ThenInclude(l => l!.Provider)
            .Include(r => r.Charity)
            .FirstOrDefaultAsync(r => r.Id == reservationId);

        if (reservation == null)
        {
            return Result<ReservationDto>.Failure("Reservation not found.");
        }

        if (reservation.FoodListing?.ProviderId != providerId)
        {
            return Result<ReservationDto>.Failure("Unauthorized to manage this reservation.");
        }

        if (reservation.Status != ReservationStatus.Pending)
        {
            return Result<ReservationDto>.Failure($"Cannot accept reservation in status {reservation.Status}.");
        }

        if (dto.PickupDateTime > reservation.FoodListing.PickupDeadline)
        {
            return Result<ReservationDto>.Failure("Confirmed pickup time cannot exceed the listing's pickup deadline.");
        }

        if (reservation.FoodListing.Status != FoodListingStatus.Available)
        {
            return Result<ReservationDto>.Failure("The food listing is no longer available.");
        }

        reservation.Status = ReservationStatus.Accepted;
        reservation.PickupDateTime = dto.PickupDateTime;
        reservation.ConfirmedLocation = dto.ConfirmedLocation;

        reservation.FoodListing.Status = FoodListingStatus.Reserved;
        reservation.FoodListing.UpdatedAt = DateTimeOffset.UtcNow;

        var otherPending = await _context.Reservations
            .Where(r => r.FoodListingId == reservation.FoodListingId && r.Id != reservation.Id && r.Status == ReservationStatus.Pending)
            .ToListAsync();

        foreach (var other in otherPending)
        {
            other.Status = ReservationStatus.Rejected;
            other.CancellationReason = "Listing claimed by another accepted charity.";
            await _notificationService.SendNotificationAsync(
                other.CharityId,
                "Reservation Request Declined",
                $"Your request for '{reservation.FoodListing.FoodName}' was declined as another reservation was accepted.",
                $"reservation:{other.Id}");
        }

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<ReservationDto>.Failure("Concurrency conflict: The food listing was modified by another operation.");
        }

        await _notificationService.SendNotificationAsync(
            reservation.CharityId,
            "Reservation Accepted!",
            $"Your reservation for '{reservation.FoodListing.FoodName}' has been accepted. Pickup confirmed for {dto.PickupDateTime:g} at {dto.ConfirmedLocation}.",
            $"reservation:{reservation.Id}");

        return await GetReservationByIdAsync(reservation.Id, providerId);
    }

    public async Task<Result<ReservationDto>> RejectReservationAsync(string providerId, int reservationId, RejectReservationDto dto)
    {
        var reservation = await _context.Reservations
            .Include(r => r.FoodListing)
            .FirstOrDefaultAsync(r => r.Id == reservationId);

        if (reservation == null)
        {
            return Result<ReservationDto>.Failure("Reservation not found.");
        }

        if (reservation.FoodListing?.ProviderId != providerId)
        {
            return Result<ReservationDto>.Failure("Unauthorized to manage this reservation.");
        }

        if (reservation.Status != ReservationStatus.Pending)
        {
            return Result<ReservationDto>.Failure($"Cannot reject reservation in status {reservation.Status}.");
        }

        reservation.Status = ReservationStatus.Rejected;
        reservation.CancellationReason = dto.Reason;

        await _context.SaveChangesAsync();

        await _notificationService.SendNotificationAsync(
            reservation.CharityId,
            "Reservation Request Declined",
            $"Your reservation request for '{reservation.FoodListing.FoodName}' was declined: {dto.Reason}",
            $"reservation:{reservation.Id}");

        return await GetReservationByIdAsync(reservation.Id, providerId);
    }

    public async Task<Result<ReservationDto>> MarkReadyForPickupAsync(string providerId, int reservationId)
    {
        var reservation = await _context.Reservations
            .Include(r => r.FoodListing)
            .FirstOrDefaultAsync(r => r.Id == reservationId);

        if (reservation == null)
        {
            return Result<ReservationDto>.Failure("Reservation not found.");
        }

        if (reservation.FoodListing?.ProviderId != providerId)
        {
            return Result<ReservationDto>.Failure("Unauthorized to manage this reservation.");
        }

        if (reservation.Status != ReservationStatus.Accepted)
        {
            return Result<ReservationDto>.Failure("Reservation must be in Accepted status to mark as Ready for Pickup.");
        }

        reservation.Status = ReservationStatus.ReadyForPickup;
        await _context.SaveChangesAsync();

        await _notificationService.SendNotificationAsync(
            reservation.CharityId,
            "Food Ready For Pickup!",
            $"'{reservation.FoodListing.FoodName}' is packaged and ready for collection at {reservation.ConfirmedLocation ?? reservation.FoodListing.PickupAddress}.",
            $"reservation:{reservation.Id}");

        return await GetReservationByIdAsync(reservation.Id, providerId);
    }

    public async Task<Result<ReservationDto>> MarkCompletedAsync(string charityId, int reservationId)
    {
        var reservation = await _context.Reservations
            .Include(r => r.FoodListing)
            .ThenInclude(l => l!.Provider)
            .Include(r => r.Charity)
            .FirstOrDefaultAsync(r => r.Id == reservationId);

        if (reservation == null)
        {
            return Result<ReservationDto>.Failure("Reservation not found.");
        }

        if (reservation.CharityId != charityId)
        {
            return Result<ReservationDto>.Failure("Unauthorized. Only the reserving Charity can mark completion.");
        }

        if (reservation.Status != ReservationStatus.Accepted && reservation.Status != ReservationStatus.ReadyForPickup)
        {
            return Result<ReservationDto>.Failure($"Cannot complete reservation with current status {reservation.Status}.");
        }

        reservation.Status = ReservationStatus.Completed;
        reservation.CompletedAt = DateTimeOffset.UtcNow;

        if (reservation.FoodListing != null)
        {
            reservation.FoodListing.Status = FoodListingStatus.Completed;
            reservation.FoodListing.UpdatedAt = DateTimeOffset.UtcNow;
        }

        await _context.SaveChangesAsync();

        if (reservation.FoodListing != null)
        {
            await _notificationService.SendNotificationAsync(
                reservation.FoodListing.ProviderId,
                "Donation Completed!",
                $"{reservation.Charity?.OrganizationName} has confirmed pickup of '{reservation.FoodListing.FoodName}'. Please leave a review!",
                $"reservation:{reservation.Id}");
        }

        return await GetReservationByIdAsync(reservation.Id, charityId);
    }

    public async Task<Result<ReservationDto>> CancelReservationAsync(string charityId, int reservationId, CancelReservationDto dto)
    {
        var reservation = await _context.Reservations
            .Include(r => r.FoodListing)
            .Include(r => r.Charity)
            .FirstOrDefaultAsync(r => r.Id == reservationId);

        if (reservation == null)
        {
            return Result<ReservationDto>.Failure("Reservation not found.");
        }

        if (reservation.CharityId != charityId)
        {
            return Result<ReservationDto>.Failure("Unauthorized. Only the reserving Charity can cancel this reservation.");
        }

        if (reservation.Status == ReservationStatus.Completed)
        {
            return Result<ReservationDto>.Failure("Cannot cancel an already completed reservation.");
        }

        if (reservation.FoodListing != null && DateTime.UtcNow > reservation.FoodListing.PickupDeadline)
        {
            return Result<ReservationDto>.Failure("Cannot cancel reservation after the agreed pickup deadline has passed.");
        }

        var wasAccepted = reservation.Status == ReservationStatus.Accepted || reservation.Status == ReservationStatus.ReadyForPickup;

        if (wasAccepted && reservation.PickupDateTime.HasValue)
        {
            var timeUntilPickup = reservation.PickupDateTime.Value - DateTime.UtcNow;
            if (timeUntilPickup <= TimeSpan.FromHours(2) && timeUntilPickup > TimeSpan.Zero)
            {
                return Result<ReservationDto>.Failure("Cancellation rejected: The scheduled pickup is in less than 2 hours. The courier/transport team is already en route or preparing. Please contact the partner directly or file a problem report if urgent.");
            }
        }

        reservation.Status = ReservationStatus.Cancelled;
        reservation.CancellationReason = dto.Reason;

        if (wasAccepted && reservation.FoodListing != null)
        {
            reservation.FoodListing.Status = FoodListingStatus.Available;
            reservation.FoodListing.UpdatedAt = DateTimeOffset.UtcNow;
        }

        await _context.SaveChangesAsync();

        if (reservation.FoodListing != null)
        {
            await _notificationService.SendNotificationAsync(
                reservation.FoodListing.ProviderId,
                "Reservation Cancelled",
                $"{reservation.Charity?.OrganizationName} cancelled the reservation for '{reservation.FoodListing.FoodName}'. Reason: {dto.Reason}. The listing is now Available again.",
                $"listing:{reservation.FoodListingId}");
        }

        return await GetReservationByIdAsync(reservation.Id, charityId);
    }

    public async Task<Result<ReservationDto>> ReportPickupProblemAsync(string charityId, int reservationId, ReportProblemDto dto)
    {
        var reservation = await _context.Reservations
            .Include(r => r.FoodListing)
            .Include(r => r.Charity)
            .FirstOrDefaultAsync(r => r.Id == reservationId);

        if (reservation == null)
        {
            return Result<ReservationDto>.Failure("Reservation not found.");
        }

        if (reservation.CharityId != charityId)
        {
            return Result<ReservationDto>.Failure("Unauthorized to report problem on this reservation.");
        }

        reservation.Status = ReservationStatus.ProblemReported;
        reservation.ProblemDescription = dto.ProblemDescription;

        await _context.SaveChangesAsync();

        if (reservation.FoodListing != null)
        {
            await _notificationService.SendNotificationAsync(
                reservation.FoodListing.ProviderId,
                "Pickup Problem Reported",
                $"A problem was reported by {reservation.Charity?.OrganizationName} regarding '{reservation.FoodListing.FoodName}': {dto.ProblemDescription}",
                $"reservation:{reservation.Id}");
        }

        return await GetReservationByIdAsync(reservation.Id, charityId);
    }

    public async Task<Result<ReservationDto>> GetReservationByIdAsync(int reservationId, string currentUserId)
    {
        var r = await _context.Reservations
            .Include(r => r.FoodListing)
            .ThenInclude(l => l!.Provider)
            .Include(r => r.Charity)
            .Include(r => r.Reviews)
            .FirstOrDefaultAsync(r => r.Id == reservationId);

        if (r == null)
        {
            return Result<ReservationDto>.Failure("Reservation not found.");
        }

        var dto = new ReservationDto
        {
            Id = r.Id,
            FoodListingId = r.FoodListingId,
            FoodName = r.FoodListing?.FoodName ?? "Unknown",
            Quantity = r.FoodListing?.Quantity ?? 0,
            UnitOfMeasurement = r.FoodListing?.UnitOfMeasurement ?? string.Empty,
            FoodCategory = r.FoodListing?.FoodCategory.ToString() ?? "Other",
            ListingImageUrl = r.FoodListing?.ImageUrl,
            PickupDeadline = r.FoodListing?.PickupDeadline ?? DateTime.MinValue,

            CharityId = r.CharityId,
            CharityName = r.Charity?.FullName ?? "Unknown",
            CharityOrganization = r.Charity?.OrganizationName ?? "Unknown",
            CharityEmail = r.Charity?.Email ?? string.Empty,
            CharityPhone = r.Charity?.PhoneNumber ?? string.Empty,
            CharityTargetCommunity = r.Charity?.TargetCommunityDescription ?? string.Empty,

            ProviderId = r.FoodListing?.ProviderId ?? string.Empty,
            ProviderName = r.FoodListing?.Provider?.FullName ?? "Unknown",
            ProviderOrganization = r.FoodListing?.Provider?.OrganizationName ?? "Unknown",
            ProviderEmail = r.FoodListing?.Provider?.Email ?? string.Empty,
            ProviderPhone = r.FoodListing?.Provider?.PhoneNumber ?? string.Empty,

            RequestDate = r.RequestDate,
            PickupDateTime = r.PickupDateTime,
            ConfirmedLocation = r.ConfirmedLocation,
            Status = r.Status,
            CancellationReason = r.CancellationReason,
            ProblemDescription = r.ProblemDescription,
            CompletedAt = r.CompletedAt,
            HasCharityReviewed = r.Reviews.Any(rv => rv.ReviewerId == r.CharityId),
            HasProviderReviewed = r.Reviews.Any(rv => rv.ReviewerId == r.FoodListing?.ProviderId),
            RowVersion = r.RowVersion
        };

        return Result<ReservationDto>.Success(dto);
    }

    public async Task<List<ReservationDto>> GetIncomingRequestsForProviderAsync(string providerId, string? statusFilter = null)
    {
        var query = _context.Reservations
            .Include(r => r.FoodListing)
            .ThenInclude(l => l!.Provider)
            .Include(r => r.Charity)
            .Include(r => r.Reviews)
            .Where(r => r.FoodListing != null && r.FoodListing.ProviderId == providerId)
            .OrderByDescending(r => r.RequestDate)
            .AsNoTracking();

        if (!string.IsNullOrWhiteSpace(statusFilter) && Enum.TryParse<ReservationStatus>(statusFilter, true, out var parsedStatus))
        {
            query = query.Where(r => r.Status == parsedStatus);
        }

        var list = await query.ToListAsync();

        return list.Select(r => new ReservationDto
        {
            Id = r.Id,
            FoodListingId = r.FoodListingId,
            FoodName = r.FoodListing?.FoodName ?? "Unknown",
            Quantity = r.FoodListing?.Quantity ?? 0,
            UnitOfMeasurement = r.FoodListing?.UnitOfMeasurement ?? string.Empty,
            FoodCategory = r.FoodListing?.FoodCategory.ToString() ?? "Other",
            ListingImageUrl = r.FoodListing?.ImageUrl,
            PickupDeadline = r.FoodListing?.PickupDeadline ?? DateTime.MinValue,

            CharityId = r.CharityId,
            CharityName = r.Charity?.FullName ?? "Unknown",
            CharityOrganization = r.Charity?.OrganizationName ?? "Unknown",
            CharityEmail = r.Charity?.Email ?? string.Empty,
            CharityPhone = r.Charity?.PhoneNumber ?? string.Empty,
            CharityTargetCommunity = r.Charity?.TargetCommunityDescription ?? string.Empty,

            ProviderId = r.FoodListing?.ProviderId ?? string.Empty,
            ProviderName = r.FoodListing?.Provider?.FullName ?? "Unknown",
            ProviderOrganization = r.FoodListing?.Provider?.OrganizationName ?? "Unknown",
            ProviderEmail = r.FoodListing?.Provider?.Email ?? string.Empty,
            ProviderPhone = r.FoodListing?.Provider?.PhoneNumber ?? string.Empty,

            RequestDate = r.RequestDate,
            PickupDateTime = r.PickupDateTime,
            ConfirmedLocation = r.ConfirmedLocation,
            Status = r.Status,
            CancellationReason = r.CancellationReason,
            ProblemDescription = r.ProblemDescription,
            CompletedAt = r.CompletedAt,
            HasCharityReviewed = r.Reviews.Any(rv => rv.ReviewerId == r.CharityId),
            HasProviderReviewed = r.Reviews.Any(rv => rv.ReviewerId == r.FoodListing?.ProviderId),
            RowVersion = r.RowVersion
        }).ToList();
    }

    public async Task<List<ReservationDto>> GetCharityReservationsAsync(string charityId, string? statusFilter = null)
    {
        var query = _context.Reservations
            .Include(r => r.FoodListing)
            .ThenInclude(l => l!.Provider)
            .Include(r => r.Charity)
            .Include(r => r.Reviews)
            .Where(r => r.CharityId == charityId)
            .OrderByDescending(r => r.RequestDate)
            .AsNoTracking();

        if (!string.IsNullOrWhiteSpace(statusFilter) && Enum.TryParse<ReservationStatus>(statusFilter, true, out var parsedStatus))
        {
            query = query.Where(r => r.Status == parsedStatus);
        }

        var list = await query.ToListAsync();

        return list.Select(r => new ReservationDto
        {
            Id = r.Id,
            FoodListingId = r.FoodListingId,
            FoodName = r.FoodListing?.FoodName ?? "Unknown",
            Quantity = r.FoodListing?.Quantity ?? 0,
            UnitOfMeasurement = r.FoodListing?.UnitOfMeasurement ?? string.Empty,
            FoodCategory = r.FoodListing?.FoodCategory.ToString() ?? "Other",
            ListingImageUrl = r.FoodListing?.ImageUrl,
            PickupDeadline = r.FoodListing?.PickupDeadline ?? DateTime.MinValue,

            CharityId = r.CharityId,
            CharityName = r.Charity?.FullName ?? "Unknown",
            CharityOrganization = r.Charity?.OrganizationName ?? "Unknown",
            CharityEmail = r.Charity?.Email ?? string.Empty,
            CharityPhone = r.Charity?.PhoneNumber ?? string.Empty,
            CharityTargetCommunity = r.Charity?.TargetCommunityDescription ?? string.Empty,

            ProviderId = r.FoodListing?.ProviderId ?? string.Empty,
            ProviderName = r.FoodListing?.Provider?.FullName ?? "Unknown",
            ProviderOrganization = r.FoodListing?.Provider?.OrganizationName ?? "Unknown",
            ProviderEmail = r.FoodListing?.Provider?.Email ?? string.Empty,
            ProviderPhone = r.FoodListing?.Provider?.PhoneNumber ?? string.Empty,

            RequestDate = r.RequestDate,
            PickupDateTime = r.PickupDateTime,
            ConfirmedLocation = r.ConfirmedLocation,
            Status = r.Status,
            CancellationReason = r.CancellationReason,
            ProblemDescription = r.ProblemDescription,
            CompletedAt = r.CompletedAt,
            HasCharityReviewed = r.Reviews.Any(rv => rv.ReviewerId == r.CharityId),
            HasProviderReviewed = r.Reviews.Any(rv => rv.ReviewerId == r.FoodListing?.ProviderId),
            RowVersion = r.RowVersion
        }).ToList();
    }

    public async Task<int> ProcessUpcomingPickupRemindersAsync()
    {
        var now = DateTime.UtcNow;
        var upcomingWindow = now.AddHours(2);

        var upcoming = await _context.Reservations
            .Include(r => r.FoodListing)
            .Where(r => (r.Status == ReservationStatus.Accepted || r.Status == ReservationStatus.ReadyForPickup)
                        && r.PickupDateTime.HasValue
                        && r.PickupDateTime.Value > now
                        && r.PickupDateTime.Value <= upcomingWindow)
            .ToListAsync();

        int notifiedCount = 0;
        foreach (var r in upcoming)
        {
            await _notificationService.SendNotificationAsync(
                r.CharityId,
                "Upcoming Food Pickup Reminder",
                $"Reminder: Your pickup for '{r.FoodListing?.FoodName}' is scheduled within the next 2 hours ({r.PickupDateTime:t}).",
                $"reservation:{r.Id}");

            if (r.FoodListing != null)
            {
                await _notificationService.SendNotificationAsync(
                    r.FoodListing.ProviderId,
                    "Upcoming Food Pickup Reminder",
                    $"Reminder: Charity pickup for '{r.FoodListing.FoodName}' is scheduled within the next 2 hours ({r.PickupDateTime:t}).",
                    $"reservation:{r.Id}");
            }
            notifiedCount++;
        }

        return notifiedCount;
    }
}