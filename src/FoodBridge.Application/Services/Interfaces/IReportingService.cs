using System.Collections.Generic;
using System.Threading.Tasks;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Services.Interfaces;

public interface IReportingService
{
    Task<ProviderStatsDto> GetProviderStatsAsync(string providerId);
    Task<CharityStatsDto> GetCharityStatsAsync(string charityId);
    Task<PlatformWideStatsDto> GetPlatformStatsAsync();
    Task<List<FoodListingDto>> FilterProviderDonationHistoryAsync(string providerId, DonationHistoryFilterDto filter);
    Task<List<ReservationDto>> FilterCharityDonationHistoryAsync(string charityId, DonationHistoryFilterDto filter);
}