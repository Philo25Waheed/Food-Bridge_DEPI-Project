using System.Collections.Generic;
using System.Threading.Tasks;
using FoodBridge.Application.Common;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Services.Interfaces;

public interface IAdminService
{
    Task<AdminDashboardStatsDto> GetDashboardStatsAsync();
    Task<List<AdminUserListItemDto>> GetUsersAsync(AdminUserFilterDto filter);
    Task<Result> VerifyOrganizationAsync(string adminId, string targetUserId, bool isApproved);
    Task<Result> SetUserStatusAsync(string adminId, string targetUserId, bool suspend, string? reason = null);
    Task<List<FoodListingDto>> GetReportedListingsAsync();
    Task<List<ReviewDto>> GetReportedReviewsAsync();
    Task<List<ReservationDto>> GetProblemReportsAsync();
    Task<Result> RemoveListingAsync(string adminId, int listingId, string reason);
    Task<Result> RemoveReviewAsync(string adminId, int reviewId, string reason);
    Task<Result> ResolveProblemReportAsync(string adminId, int reservationId, string notes);
    Task<List<FoodListingDto>> GetExpiredListingsAsync();
    Task<Result> HandleExpiredListingActionAsync(string adminId, int listingId, ExpiredListingActionDto dto);
    Task<Result<AdminUserListItemDto>> CreateAdminAsync(string adminId, CreateAdminDto dto);
    Task<List<AuditLogDto>> GetAuditLogsAsync(int take = 100);
}
