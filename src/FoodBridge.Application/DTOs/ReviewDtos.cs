using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace FoodBridge.Application.DTOs;

public class CreateReviewDto
{
    [Required]
    public int ReservationId { get; set; }

    [Required, Range(1, 5)]
    public int Rating { get; set; }

    [StringLength(1000)]
    public string? Comment { get; set; }
}

public class ReviewDto
{
    public int Id { get; set; }
    public int ReservationId { get; set; }

    public string ReviewerId { get; set; } = string.Empty;
    public string ReviewerName { get; set; } = string.Empty;
    public string ReviewerOrganization { get; set; } = string.Empty;
    public string ReviewerRole { get; set; } = string.Empty;

    public string RevieweeId { get; set; } = string.Empty;
    public string RevieweeName { get; set; } = string.Empty;
    public string RevieweeOrganization { get; set; } = string.Empty;

    public int Rating { get; set; }
    public string? Comment { get; set; }
    public bool IsReported { get; set; }
    public string? ReportReason { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}

public class ReportReviewDto
{
    [Required, StringLength(500)]
    public string Reason { get; set; } = string.Empty;
}

public class ProviderReviewsSummaryDto
{
    public string ProviderId { get; set; } = string.Empty;
    public string ProviderName { get; set; } = string.Empty;
    public string OrganizationName { get; set; } = string.Empty;
    public double AverageRating { get; set; }
    public int TotalReviews { get; set; }
    public List<ReviewDto> Reviews { get; set; } = new();
}