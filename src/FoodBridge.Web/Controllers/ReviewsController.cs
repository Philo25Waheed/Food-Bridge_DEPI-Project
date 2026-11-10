using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReviewsController : ControllerBase
{
    private readonly IReviewService _reviewService;
    private readonly ICurrentUserService _currentUserService;

    public ReviewsController(
        IReviewService reviewService,
        ICurrentUserService currentUserService)
    {
        _reviewService = reviewService;
        _currentUserService = currentUserService;
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> SubmitReview([FromBody] CreateReviewDto dto)
    {
        var reviewerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(reviewerId)) return Unauthorized();

        var result = await _reviewService.SubmitReviewAsync(reviewerId, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }

        return Ok(result.Data);
    }

    [HttpGet("provider/{providerId}")]
    public async Task<IActionResult> GetProviderReviews(string providerId)
    {
        var result = await _reviewService.GetProviderReviewsAsync(providerId);
        if (!result.Succeeded)
        {
            return NotFound(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpGet("reservation/{reservationId}")]
    [Authorize]
    public async Task<IActionResult> GetReservationReviews(int reservationId)
    {
        var list = await _reviewService.GetReviewsForReservationAsync(reservationId);
        return Ok(list);
    }

    [HttpPost("{id}/report")]
    [Authorize]
    public async Task<IActionResult> ReportReview(int id, [FromBody] ModerationActionDto dto)
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var result = await _reviewService.ReportReviewAsync(userId, id, dto.Reason);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }

        return Ok(new { message = "Review reported for administrator moderation." });
    }
}