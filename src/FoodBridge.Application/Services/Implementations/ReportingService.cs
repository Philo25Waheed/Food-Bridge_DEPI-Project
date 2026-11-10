using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Application.Services.Implementations;

public class ReportingService : IReportingService
{
    private readonly IApplicationDbContext _context;

    public ReportingService(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<ProviderStatsDto> GetProviderStatsAsync(string providerId)
    {
        var totalListed = await _context.FoodListings.CountAsync(l => l.ProviderId == providerId);
        var totalCompleted = await _context.FoodListings.CountAsync(l => l.ProviderId == providerId && l.Status == FoodListingStatus.Completed);
        var activeListings = await _context.FoodListings.CountAsync(l => l.ProviderId == providerId && (l.Status == FoodListingStatus.Available || l.Status == FoodListingStatus.Reserved));
        var expiredListings = await _context.FoodListings.CountAsync(l => l.ProviderId == providerId && l.Status == FoodListingStatus.Expired);
        var cancelledListings = await _context.FoodListings.CountAsync(l => l.ProviderId == providerId && (l.Status == FoodListingStatus.Cancelled || l.Status == FoodListingStatus.Unavailable));

        var redistributedQuantity = await _context.FoodListings
            .Where(l => l.ProviderId == providerId && l.Status == FoodListingStatus.Completed)
            .SumAsync(l => (decimal?)l.Quantity) ?? 0m;

        var reviews = await _context.Reviews
            .Where(r => r.RevieweeId == providerId && !r.IsReported)
            .ToListAsync();

        double avgRating = reviews.Any() ? Math.Round(reviews.Average(r => r.Rating), 1) : 0;

        return new ProviderStatsDto
        {
            TotalListed = totalListed,
            TotalCompleted = totalCompleted,
            ActiveListings = activeListings,
            ExpiredListings = expiredListings,
            CancelledListings = cancelledListings,
            TotalRedistributedQuantity = redistributedQuantity,
            AverageRating = avgRating,
            TotalReviews = reviews.Count
        };
    }

    public async Task<CharityStatsDto> GetCharityStatsAsync(string charityId)
    {
        var totalReceived = await _context.Reservations
            .CountAsync(r => r.CharityId == charityId && r.Status == ReservationStatus.Completed);

        var activeReservations = await _context.Reservations
            .CountAsync(r => r.CharityId == charityId && (r.Status == ReservationStatus.Accepted || r.Status == ReservationStatus.ReadyForPickup || r.Status == ReservationStatus.Pending));

        var cancelledReservations = await _context.Reservations
            .CountAsync(r => r.CharityId == charityId && (r.Status == ReservationStatus.Cancelled || r.Status == ReservationStatus.Rejected));

        var totalQuantity = await _context.Reservations
            .Include(r => r.FoodListing)
            .Where(r => r.CharityId == charityId && r.Status == ReservationStatus.Completed && r.FoodListing != null)
            .SumAsync(r => (decimal?)r.FoodListing!.Quantity) ?? 0m;

        var totalReviews = await _context.Reviews
            .CountAsync(r => r.ReviewerId == charityId);

        return new CharityStatsDto
        {
            TotalReceived = totalReceived,
            ActiveReservations = activeReservations,
            CancelledReservations = cancelledReservations,
            TotalQuantityReceived = totalQuantity,
            TotalReviewsGiven = totalReviews
        };
    }

    public async Task<PlatformWideStatsDto> GetPlatformStatsAsync()
    {
        var completedListings = await _context.FoodListings
            .Where(l => l.Status == FoodListingStatus.Completed)
            .ToListAsync();

        var totalRedistributed = completedListings.Sum(l => l.Quantity);
        var totalCompleted = completedListings.Count;

        var activeListings = await _context.FoodListings
            .CountAsync(l => l.Status == FoodListingStatus.Available || l.Status == FoodListingStatus.Reserved);

        var totalProviders = await _context.Users
            .CountAsync(u => u.UserType == UserType.FoodProvider);

        var totalCharities = await _context.Users
            .CountAsync(u => u.UserType == UserType.Charity);

        var totalVerified = await _context.Users
            .CountAsync(u => u.IsVerified);

        var categoryBreakdown = completedListings
            .GroupBy(l => l.FoodCategory.ToString())
            .ToDictionary(g => g.Key, g => g.Sum(x => x.Quantity));

        var sixMonthsAgo = DateTimeOffset.UtcNow.AddMonths(-6);
        var monthly = completedListings
            .Where(l => l.CreatedAt >= sixMonthsAgo)
            .GroupBy(l => new { l.CreatedAt.Year, l.CreatedAt.Month })
            .OrderBy(g => g.Key.Year).ThenBy(g => g.Key.Month)
            .Select(g => new MonthlyImpactStatDto
            {
                Year = g.Key.Year,
                MonthName = new DateTime(g.Key.Year, g.Key.Month, 1).ToString("MMM yyyy"),
                CompletedDonations = g.Count(),
                RedistributedQuantity = g.Sum(x => x.Quantity)
            })
            .ToList();

        return new PlatformWideStatsDto
        {
            TotalFoodRedistributedQuantity = totalRedistributed,
            TotalCompletedDonations = totalCompleted,
            TotalActiveListings = activeListings,
            TotalRegisteredProviders = totalProviders,
            TotalRegisteredCharities = totalCharities,
            TotalVerifiedOrganizations = totalVerified,
            RedistributionByCategory = categoryBreakdown,
            MonthlyTrends = monthly
        };
    }

    public async Task<List<FoodListingDto>> FilterProviderDonationHistoryAsync(string providerId, DonationHistoryFilterDto filter)
    {
        var query = _context.FoodListings
            .Include(l => l.Provider)
            .Where(l => l.ProviderId == providerId)
            .AsNoTracking()
            .AsQueryable();

        if (filter.FromDate.HasValue)
        {
            query = query.Where(l => l.PreparationDate >= filter.FromDate.Value);
        }

        if (filter.ToDate.HasValue)
        {
            var endOfDay = filter.ToDate.Value.Date.AddDays(1);
            query = query.Where(l => l.PreparationDate < endOfDay);
        }

        if (!string.IsNullOrWhiteSpace(filter.Status) && Enum.TryParse<FoodListingStatus>(filter.Status, true, out var parsedStatus))
        {
            query = query.Where(l => l.Status == parsedStatus);
        }

        if (!string.IsNullOrWhiteSpace(filter.SearchTerm))
        {
            var term = filter.SearchTerm.Trim().ToLower();
            query = query.Where(l => l.FoodName.ToLower().Contains(term) || l.Description.ToLower().Contains(term));
        }

        var list = await query
            .OrderByDescending(l => l.CreatedAt)
            .Skip((filter.PageNumber - 1) * filter.PageSize)
            .Take(filter.PageSize)
            .ToListAsync();

        return list.Select(l => new FoodListingDto
        {
            Id = l.Id,
            ProviderId = l.ProviderId,
            ProviderName = l.Provider?.FullName ?? "Unknown",
            ProviderOrganization = l.Provider?.OrganizationName ?? "Unknown",
            ProviderType = l.Provider?.SpecificType ?? "Provider",
            FoodName = l.FoodName,
            Description = l.Description,
            FoodCategory = l.FoodCategory,
            Quantity = l.Quantity,
            UnitOfMeasurement = l.UnitOfMeasurement,
            PreparationDate = l.PreparationDate,
            PickupDeadline = l.PickupDeadline,
            PickupAddress = l.PickupAddress,
            StorageConditions = l.StorageConditions,
            Allergens = l.Allergens,
            ImageUrl = l.ImageUrl,
            Status = l.Status,
            CreatedAt = l.CreatedAt
        }).ToList();
    }

    public async Task<List<ReservationDto>> FilterCharityDonationHistoryAsync(string charityId, DonationHistoryFilterDto filter)
    {
        var query = _context.Reservations
            .Include(r => r.FoodListing)
            .ThenInclude(l => l!.Provider)
            .Include(r => r.Charity)
            .Where(r => r.CharityId == charityId)
            .AsNoTracking()
            .AsQueryable();

        if (filter.FromDate.HasValue)
        {
            var from = new DateTimeOffset(filter.FromDate.Value);
            query = query.Where(r => r.RequestDate >= from);
        }

        if (filter.ToDate.HasValue)
        {
            var to = new DateTimeOffset(filter.ToDate.Value.Date.AddDays(1));
            query = query.Where(r => r.RequestDate < to);
        }

        if (!string.IsNullOrWhiteSpace(filter.Status) && Enum.TryParse<ReservationStatus>(filter.Status, true, out var parsedStatus))
        {
            query = query.Where(r => r.Status == parsedStatus);
        }

        if (!string.IsNullOrWhiteSpace(filter.SearchTerm))
        {
            var term = filter.SearchTerm.Trim().ToLower();
            query = query.Where(r => r.FoodListing != null && (r.FoodListing.FoodName.ToLower().Contains(term) || r.FoodListing.Description.ToLower().Contains(term)));
        }

        var list = await query
            .OrderByDescending(r => r.RequestDate)
            .Skip((filter.PageNumber - 1) * filter.PageSize)
            .Take(filter.PageSize)
            .ToListAsync();

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

            ProviderId = r.FoodListing?.ProviderId ?? string.Empty,
            ProviderName = r.FoodListing?.Provider?.FullName ?? "Unknown",
            ProviderOrganization = r.FoodListing?.Provider?.OrganizationName ?? "Unknown",

            RequestDate = r.RequestDate,
            PickupDateTime = r.PickupDateTime,
            ConfirmedLocation = r.ConfirmedLocation,
            Status = r.Status,
            CancellationReason = r.CancellationReason,
            ProblemDescription = r.ProblemDescription,
            CompletedAt = r.CompletedAt
        }).ToList();
    }
}