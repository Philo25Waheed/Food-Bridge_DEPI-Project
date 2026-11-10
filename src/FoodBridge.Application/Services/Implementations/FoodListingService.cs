using System;
using System.Collections.Generic;
using System.IO;
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

public class FoodListingService : IFoodListingService
{
    private readonly IApplicationDbContext _context;
    private readonly IFileStorageService _fileStorage;
    private readonly INotificationService _notificationService;

    public FoodListingService(
        IApplicationDbContext context,
        IFileStorageService fileStorage,
        INotificationService notificationService)
    {
        _context = context;
        _fileStorage = fileStorage;
        _notificationService = notificationService;
    }

    public async Task<Result<FoodListingDto>> CreateListingAsync(
        string providerId,
        CreateFoodListingDto dto,
        Stream? imageStream = null,
        string? imageFileName = null,
        string? contentType = null)
    {
        var provider = await _context.Users.FindAsync(providerId);
        if (provider == null)
        {
            return Result<FoodListingDto>.Failure("Provider account not found.");
        }

        if (provider.Status == UserStatus.Suspended)
        {
            return Result<FoodListingDto>.Failure("Provider account is suspended.");
        }

        if (dto.Quantity <= 0)
        {
            return Result<FoodListingDto>.Failure("Donation quantity must be greater than zero.");
        }

        var unitLower = (dto.UnitOfMeasurement ?? "").Trim().ToLower();
        if (unitLower.Contains("kg") || unitLower.Contains("كيلو") || unitLower.Contains("kilo"))
        {
            if (dto.Quantity < 1m)
            {
                return Result<FoodListingDto>.Failure("Minimum donation quantity for items measured in Kilograms (kg) is 1 kg to ensure practical logistics for charity collection.");
            }
        }
        else if (unitLower.Contains("liter") || unitLower.Contains("litre") || unitLower.Contains("لتر") || unitLower == "l")
        {
            if (dto.Quantity < 1m)
            {
                return Result<FoodListingDto>.Failure("Minimum donation quantity for items measured in Liters (L) is 1 Liter to ensure practical distribution for charities.");
            }
        }

        if (dto.PickupDeadline <= DateTime.UtcNow)
        {
            return Result<FoodListingDto>.Failure("Pickup deadline must be set to a future date and time.");
        }

        if (dto.PickupDeadline <= dto.PreparationDate)
        {
            return Result<FoodListingDto>.Failure("Pickup deadline must be after the preparation/availability date.");
        }

        string? imageUrl = null;
        if (imageStream != null && !string.IsNullOrWhiteSpace(imageFileName))
        {
            imageUrl = await _fileStorage.SaveFileAsync(imageStream, imageFileName, contentType ?? "image/jpeg");
        }

        var listing = new FoodListing
        {
            ProviderId = providerId,
            FoodName = dto.FoodName,
            Description = dto.Description,
            FoodCategory = dto.FoodCategory,
            Quantity = dto.Quantity,
            UnitOfMeasurement = dto.UnitOfMeasurement ?? "kg",
            PreparationDate = dto.PreparationDate,
            PickupDeadline = dto.PickupDeadline,
            PickupAddress = dto.PickupAddress,
            StorageConditions = dto.StorageConditions,
            Allergens = dto.Allergens,
            ImageUrl = imageUrl,
            Status = FoodListingStatus.Available,
            CreatedAt = DateTimeOffset.UtcNow
        };

        _context.FoodListings.Add(listing);
        await _context.SaveChangesAsync();

        return await GetListingByIdAsync(listing.Id);
    }

    public async Task<Result<FoodListingDto>> UpdateListingAsync(
        string providerId,
        int listingId,
        UpdateFoodListingDto dto,
        Stream? imageStream = null,
        string? imageFileName = null,
        string? contentType = null)
    {
        var listing = await _context.FoodListings
            .Include(l => l.Provider)
            .FirstOrDefaultAsync(l => l.Id == listingId);

        if (listing == null)
        {
            return Result<FoodListingDto>.Failure("Listing not found.");
        }

        if (listing.ProviderId != providerId)
        {
            return Result<FoodListingDto>.Failure("Unauthorized to modify this listing.");
        }

        if (listing.Status != FoodListingStatus.Available)
        {
            return Result<FoodListingDto>.Failure($"Cannot edit listing while its status is {listing.Status}. Only Available listings can be edited.");
        }

        if (dto.Quantity <= 0)
        {
            return Result<FoodListingDto>.Failure("Donation quantity must be greater than zero.");
        }

        var updateUnitLower = (dto.UnitOfMeasurement ?? "").Trim().ToLower();
        if (updateUnitLower.Contains("kg") || updateUnitLower.Contains("كيلو") || updateUnitLower.Contains("kilo"))
        {
            if (dto.Quantity < 1m)
            {
                return Result<FoodListingDto>.Failure("Minimum donation quantity for items measured in Kilograms (kg) is 1 kg to ensure practical logistics for charity collection.");
            }
        }
        else if (updateUnitLower.Contains("liter") || updateUnitLower.Contains("litre") || updateUnitLower.Contains("لتر") || updateUnitLower == "l")
        {
            if (dto.Quantity < 1m)
            {
                return Result<FoodListingDto>.Failure("Minimum donation quantity for items measured in Liters (L) is 1 Liter to ensure practical distribution for charities.");
            }
        }

        if (dto.PickupDeadline <= dto.PreparationDate)
        {
            return Result<FoodListingDto>.Failure("Pickup deadline must be after the preparation date.");
        }

        if (imageStream != null && !string.IsNullOrWhiteSpace(imageFileName))
        {
            if (!string.IsNullOrEmpty(listing.ImageUrl))
            {
                await _fileStorage.DeleteFileAsync(listing.ImageUrl);
            }
            listing.ImageUrl = await _fileStorage.SaveFileAsync(imageStream, imageFileName, contentType ?? "image/jpeg");
        }

        listing.FoodName = dto.FoodName;
        listing.Description = dto.Description;
        listing.FoodCategory = dto.FoodCategory;
        listing.Quantity = dto.Quantity;
        if (!string.IsNullOrWhiteSpace(dto.UnitOfMeasurement))
        {
            listing.UnitOfMeasurement = dto.UnitOfMeasurement;
        }
        listing.PreparationDate = dto.PreparationDate;
        listing.PickupDeadline = dto.PickupDeadline;
        listing.PickupAddress = dto.PickupAddress;
        listing.StorageConditions = dto.StorageConditions;
        listing.Allergens = dto.Allergens;
        listing.UpdatedAt = DateTimeOffset.UtcNow;

        if (dto.RowVersion != null)
        {
            _context.FoodListings.Entry(listing).Property(p => p.RowVersion).OriginalValue = dto.RowVersion;
        }

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<FoodListingDto>.Failure("This listing was modified or claimed by another process. Please refresh.");
        }

        return await GetListingByIdAsync(listing.Id);
    }

    public async Task<Result<FoodListingDto>> GetListingByIdAsync(int listingId)
    {
        var listing = await _context.FoodListings
            .Include(l => l.Provider)
            .ThenInclude(p => p!.ReviewsReceived)
            .FirstOrDefaultAsync(l => l.Id == listingId);

        if (listing == null)
        {
            return Result<FoodListingDto>.Failure("Food listing not found.");
        }

        double providerAvgRating = 0;
        int providerReviewCount = 0;
        if (listing.Provider?.ReviewsReceived != null && listing.Provider.ReviewsReceived.Any(r => !r.IsReported))
        {
            var validReviews = listing.Provider.ReviewsReceived.Where(r => !r.IsReported).ToList();
            providerAvgRating = Math.Round(validReviews.Average(r => r.Rating), 1);
            providerReviewCount = validReviews.Count;
        }

        var dto = new FoodListingDto
        {
            Id = listing.Id,
            ProviderId = listing.ProviderId,
            ProviderName = listing.Provider?.FullName ?? "Unknown",
            ProviderOrganization = listing.Provider?.OrganizationName ?? "Unknown",
            ProviderType = listing.Provider?.SpecificType ?? "Provider",
            ProviderAverageRating = providerAvgRating,
            ProviderReviewsCount = providerReviewCount,
            FoodName = listing.FoodName,
            Description = listing.Description,
            FoodCategory = listing.FoodCategory,
            Quantity = listing.Quantity,
            UnitOfMeasurement = listing.UnitOfMeasurement,
            PreparationDate = listing.PreparationDate,
            PickupDeadline = listing.PickupDeadline,
            PickupAddress = listing.PickupAddress,
            StorageConditions = listing.StorageConditions,
            Allergens = listing.Allergens,
            ImageUrl = listing.ImageUrl,
            Status = listing.Status,
            IsReported = listing.IsReported,
            ReportReason = listing.ReportReason,
            RowVersion = listing.RowVersion,
            CreatedAt = listing.CreatedAt
        };

        return Result<FoodListingDto>.Success(dto);
    }

    public async Task<PagedResult<FoodListingDto>> DiscoverListingsAsync(FoodListingFilterDto filter)
    {
        var query = _context.FoodListings
            .Include(l => l.Provider)
            .ThenInclude(p => p!.ReviewsReceived)
            .AsNoTracking()
            .AsQueryable();

        if (filter.OnlyAvailable)
        {
            query = query.Where(l => l.Status == FoodListingStatus.Available);
        }

        if (filter.Category.HasValue)
        {
            query = query.Where(l => l.FoodCategory == filter.Category.Value);
        }

        if (!string.IsNullOrWhiteSpace(filter.ProviderType))
        {
            var pt = filter.ProviderType.Trim().ToLower();
            query = query.Where(l => l.Provider != null && l.Provider.SpecificType.ToLower().Contains(pt));
        }

        if (filter.AvailabilityDate.HasValue)
        {
            var date = filter.AvailabilityDate.Value.Date;
            var nextDate = date.AddDays(1);
            query = query.Where(l => l.PreparationDate >= date && l.PreparationDate < nextDate);
        }

        if (!string.IsNullOrWhiteSpace(filter.SearchTerm))
        {
            var term = filter.SearchTerm.Trim().ToLower();
            query = query.Where(l => l.FoodName.ToLower().Contains(term) 
                || l.Description.ToLower().Contains(term)
                || l.PickupAddress.ToLower().Contains(term)
                || (l.Provider != null && l.Provider.OrganizationName.ToLower().Contains(term)));
        }

        query = (filter.SortBy?.ToLower()) switch
        {
            "deadline" => query.OrderBy(l => l.PickupDeadline),
            "quantity" => query.OrderByDescending(l => l.Quantity),
            _ => query.OrderByDescending(l => l.CreatedAt)
        };

        var totalCount = await query.CountAsync();
        var pagedItems = await query
            .Skip((filter.PageNumber - 1) * filter.PageSize)
            .Take(filter.PageSize)
            .ToListAsync();

        var dtos = pagedItems.Select(l =>
        {
            double avgRating = 0;
            int revCount = 0;
            if (l.Provider?.ReviewsReceived != null && l.Provider.ReviewsReceived.Any(r => !r.IsReported))
            {
                var validReviews = l.Provider.ReviewsReceived.Where(r => !r.IsReported).ToList();
                avgRating = Math.Round(validReviews.Average(r => r.Rating), 1);
                revCount = validReviews.Count;
            }

            return new FoodListingDto
            {
                Id = l.Id,
                ProviderId = l.ProviderId,
                ProviderName = l.Provider?.FullName ?? "Unknown",
                ProviderOrganization = l.Provider?.OrganizationName ?? "Unknown",
                ProviderType = l.Provider?.SpecificType ?? "Provider",
                ProviderAverageRating = avgRating,
                ProviderReviewsCount = revCount,
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
                IsReported = l.IsReported,
                RowVersion = l.RowVersion,
                CreatedAt = l.CreatedAt
            };
        }).ToList();

        return new PagedResult<FoodListingDto>
        {
            Items = dtos,
            TotalCount = totalCount,
            PageNumber = filter.PageNumber,
            PageSize = filter.PageSize
        };
    }

    public async Task<List<FoodListingDto>> GetProviderListingsAsync(string providerId, string? statusFilter = null)
    {
        var query = _context.FoodListings
            .Include(l => l.Provider)
            .ThenInclude(p => p!.ReviewsReceived)
            .Where(l => l.ProviderId == providerId)
            .OrderByDescending(l => l.CreatedAt)
            .AsNoTracking();

        if (!string.IsNullOrWhiteSpace(statusFilter) && Enum.TryParse<FoodListingStatus>(statusFilter, true, out var parsedStatus))
        {
            query = query.Where(l => l.Status == parsedStatus);
        }

        var listings = await query.ToListAsync();

        return listings.Select(l => new FoodListingDto
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
            IsReported = l.IsReported,
            RowVersion = l.RowVersion,
            CreatedAt = l.CreatedAt
        }).ToList();
    }

    public async Task<Result> MarkAsUnavailableAsync(string providerId, int listingId)
    {
        var listing = await _context.FoodListings.FirstOrDefaultAsync(l => l.Id == listingId);
        if (listing == null)
        {
            return Result.Failure("Listing not found.");
        }

        if (listing.ProviderId != providerId)
        {
            return Result.Failure("Unauthorized to modify this listing.");
        }

        if (listing.Status == FoodListingStatus.Completed)
        {
            return Result.Failure("Cannot mark a completed donation as unavailable.");
        }

        listing.Status = FoodListingStatus.Unavailable;
        listing.UpdatedAt = DateTimeOffset.UtcNow;
        await _context.SaveChangesAsync();

        return Result.Success();
    }

    public async Task<Result> ReportListingAsync(string reportingUserId, int listingId, string reason)
    {
        var listing = await _context.FoodListings.FindAsync(listingId);
        if (listing == null)
        {
            return Result.Failure("Listing not found.");
        }

        listing.IsReported = true;
        listing.ReportReason = reason;
        await _context.SaveChangesAsync();

        return Result.Success();
    }

    public async Task<int> ProcessExpiredListingsAsync()
    {
        var now = DateTime.UtcNow;
        var expiredListings = await _context.FoodListings
            .Where(l => (l.Status == FoodListingStatus.Available || l.Status == FoodListingStatus.Reserved) 
                        && l.PickupDeadline < now)
            .ToListAsync();

        if (!expiredListings.Any()) return 0;

        foreach (var listing in expiredListings)
        {
            listing.Status = FoodListingStatus.Expired;
            listing.UpdatedAt = DateTimeOffset.UtcNow;

            await _notificationService.SendNotificationAsync(
                listing.ProviderId,
                "Listing Expired",
                $"Your food listing '{listing.FoodName}' has expired as the pickup deadline passed.",
                $"listing:{listing.Id}");
        }

        await _context.SaveChangesAsync();
        return expiredListings.Count;
    }
}