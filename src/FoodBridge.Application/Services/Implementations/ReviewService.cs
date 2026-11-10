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

public class ReviewService : IReviewService
{
    private readonly IApplicationDbContext _context;
    private readonly INotificationService _notificationService;

    public ReviewService(
        IApplicationDbContext context,
        INotificationService notificationService)
    {
        _context = context;
        _notificationService = notificationService;
    }

    public async Task<Result<ReviewDto>> SubmitReviewAsync(string reviewerId, CreateReviewDto dto)
    {
        if (dto.Rating < 1 || dto.Rating > 5)
        {
            return Result<ReviewDto>.Failure("Rating must be between 1 and 5.");
        }

        var reservation = await _context.Reservations
            .Include(r => r.FoodListing)
            .FirstOrDefaultAsync(r => r.Id == dto.ReservationId);

        if (reservation == null)
        {
            return Result<ReviewDto>.Failure("Reservation not found.");
        }

        if (reservation.Status != ReservationStatus.Completed)
        {
            return Result<ReviewDto>.Failure("Reviews can only be submitted for completed donations.");
        }

        string revieweeId;
        if (reservation.CharityId == reviewerId)
        {
            revieweeId = reservation.FoodListing?.ProviderId ?? string.Empty;
        }
        else if (reservation.FoodListing?.ProviderId == reviewerId)
        {
            revieweeId = reservation.CharityId;
        }
        else
        {
            return Result<ReviewDto>.Failure("Unauthorized. You are not a party to this reservation.");
        }

        if (string.IsNullOrEmpty(revieweeId))
        {
            return Result<ReviewDto>.Failure("Invalid review recipient.");
        }

        var alreadyReviewed = await _context.Reviews
            .AnyAsync(r => r.ReservationId == dto.ReservationId && r.ReviewerId == reviewerId);

        if (alreadyReviewed)
        {
            return Result<ReviewDto>.Failure("You have already submitted a review for this completed donation.");
        }

        var reviewer = await _context.Users.FindAsync(reviewerId);

        var review = new Review
        {
            ReservationId = dto.ReservationId,
            ReviewerId = reviewerId,
            RevieweeId = revieweeId,
            Rating = dto.Rating,
            Comment = dto.Comment?.Trim(),
            CreatedAt = DateTimeOffset.UtcNow
        };

        _context.Reviews.Add(review);
        await _context.SaveChangesAsync();

        await _notificationService.SendNotificationAsync(
            revieweeId,
            "New Review Received",
            $"{reviewer?.OrganizationName ?? "A partner"} rated you {dto.Rating} stars.",
            $"reservation:{reservation.Id}");

        var reviewee = await _context.Users.FindAsync(revieweeId);

        var reviewDto = new ReviewDto
        {
            Id = review.Id,
            ReservationId = review.ReservationId,
            ReviewerId = review.ReviewerId,
            ReviewerName = reviewer?.FullName ?? "Unknown",
            ReviewerOrganization = reviewer?.OrganizationName ?? "Unknown",
            ReviewerRole = reviewer?.UserType.ToString() ?? "User",
            RevieweeId = review.RevieweeId,
            RevieweeName = reviewee?.FullName ?? "Unknown",
            RevieweeOrganization = reviewee?.OrganizationName ?? "Unknown",
            Rating = review.Rating,
            Comment = review.Comment,
            IsReported = review.IsReported,
            CreatedAt = review.CreatedAt
        };

        return Result<ReviewDto>.Success(reviewDto);
    }

    public async Task<Result<ProviderReviewsSummaryDto>> GetProviderReviewsAsync(string providerId)
    {
        var provider = await _context.Users
            .FirstOrDefaultAsync(u => u.Id == providerId);

        if (provider == null)
        {
            return Result<ProviderReviewsSummaryDto>.Failure("Provider not found.");
        }

        var reviews = await _context.Reviews
            .Include(r => r.Reviewer)
            .Include(r => r.Reviewee)
            .Where(r => r.RevieweeId == providerId && !r.IsReported)
            .OrderByDescending(r => r.CreatedAt)
            .ToListAsync();

        double avgRating = reviews.Any() ? Math.Round(reviews.Average(r => r.Rating), 1) : 0;

        var dtos = reviews.Select(r => new ReviewDto
        {
            Id = r.Id,
            ReservationId = r.ReservationId,
            ReviewerId = r.ReviewerId,
            ReviewerName = r.Reviewer?.FullName ?? "Unknown",
            ReviewerOrganization = r.Reviewer?.OrganizationName ?? "Unknown",
            ReviewerRole = r.Reviewer?.UserType.ToString() ?? "Charity",
            RevieweeId = r.RevieweeId,
            RevieweeName = r.Reviewee?.FullName ?? "Unknown",
            RevieweeOrganization = r.Reviewee?.OrganizationName ?? "Unknown",
            Rating = r.Rating,
            Comment = r.Comment,
            IsReported = r.IsReported,
            CreatedAt = r.CreatedAt
        }).ToList();

        return Result<ProviderReviewsSummaryDto>.Success(new ProviderReviewsSummaryDto
        {
            ProviderId = provider.Id,
            ProviderName = provider.FullName,
            OrganizationName = provider.OrganizationName,
            AverageRating = avgRating,
            TotalReviews = dtos.Count,
            Reviews = dtos
        });
    }

    public async Task<List<ReviewDto>> GetReviewsForReservationAsync(int reservationId)
    {
        var reviews = await _context.Reviews
            .Include(r => r.Reviewer)
            .Include(r => r.Reviewee)
            .Where(r => r.ReservationId == reservationId)
            .ToListAsync();

        return reviews.Select(r => new ReviewDto
        {
            Id = r.Id,
            ReservationId = r.ReservationId,
            ReviewerId = r.ReviewerId,
            ReviewerName = r.Reviewer?.FullName ?? "Unknown",
            ReviewerOrganization = r.Reviewer?.OrganizationName ?? "Unknown",
            ReviewerRole = r.Reviewer?.UserType.ToString() ?? "User",
            RevieweeId = r.RevieweeId,
            RevieweeName = r.Reviewee?.FullName ?? "Unknown",
            RevieweeOrganization = r.Reviewee?.OrganizationName ?? "Unknown",
            Rating = r.Rating,
            Comment = r.Comment,
            IsReported = r.IsReported,
            ReportReason = r.ReportReason,
            CreatedAt = r.CreatedAt
        }).ToList();
    }

    public async Task<Result> ReportReviewAsync(string reportingUserId, int reviewId, string reason)
    {
        var review = await _context.Reviews.FindAsync(reviewId);
        if (review == null)
        {
            return Result.Failure("Review not found.");
        }

        review.IsReported = true;
        review.ReportReason = reason;

        await _context.SaveChangesAsync();

        return Result.Success();
    }
}