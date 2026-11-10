using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using FoodBridge.Application.Common;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Services.Interfaces;

public interface IFoodListingService
{
    Task<Result<FoodListingDto>> CreateListingAsync(string providerId, CreateFoodListingDto dto, Stream? imageStream = null, string? imageFileName = null, string? contentType = null);
    Task<Result<FoodListingDto>> UpdateListingAsync(string providerId, int listingId, UpdateFoodListingDto dto, Stream? imageStream = null, string? imageFileName = null, string? contentType = null);
    Task<Result<FoodListingDto>> GetListingByIdAsync(int listingId);
    Task<PagedResult<FoodListingDto>> DiscoverListingsAsync(FoodListingFilterDto filter);
    Task<List<FoodListingDto>> GetProviderListingsAsync(string providerId, string? statusFilter = null);
    Task<Result> MarkAsUnavailableAsync(string providerId, int listingId);
    Task<Result> ReportListingAsync(string reportingUserId, int listingId, string reason);
    Task<int> ProcessExpiredListingsAsync();
}