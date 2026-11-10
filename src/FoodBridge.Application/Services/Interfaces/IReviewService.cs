using System.Collections.Generic;
using System.Threading.Tasks;
using FoodBridge.Application.Common;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Services.Interfaces;

public interface IReviewService
{
    Task<Result<ReviewDto>> SubmitReviewAsync(string reviewerId, CreateReviewDto dto);
    Task<Result<ProviderReviewsSummaryDto>> GetProviderReviewsAsync(string providerId);
    Task<List<ReviewDto>> GetReviewsForReservationAsync(int reservationId);
    Task<Result> ReportReviewAsync(string reportingUserId, int reviewId, string reason);
}