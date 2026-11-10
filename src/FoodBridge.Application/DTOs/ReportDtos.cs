using System;
using System.Collections.Generic;

namespace FoodBridge.Application.DTOs;

public class ProviderStatsDto
{
    public int TotalListed { get; set; }
    public int TotalCompleted { get; set; }
    public int ActiveListings { get; set; }
    public int ExpiredListings { get; set; }
    public int CancelledListings { get; set; }
    public decimal TotalRedistributedQuantity { get; set; }
    public double AverageRating { get; set; }
    public int TotalReviews { get; set; }
}

public class CharityStatsDto
{
    public int TotalReceived { get; set; }
    public int ActiveReservations { get; set; }
    public int CancelledReservations { get; set; }
    public decimal TotalQuantityReceived { get; set; }
    public int TotalReviewsGiven { get; set; }
}

public class PlatformWideStatsDto
{
    public decimal TotalFoodRedistributedQuantity { get; set; }
    public int TotalCompletedDonations { get; set; }
    public int TotalActiveListings { get; set; }
    public int TotalRegisteredProviders { get; set; }
    public int TotalRegisteredCharities { get; set; }
    public int TotalVerifiedOrganizations { get; set; }
    public Dictionary<string, decimal> RedistributionByCategory { get; set; } = new();
    public List<MonthlyImpactStatDto> MonthlyTrends { get; set; } = new();
}

public class MonthlyImpactStatDto
{
    public string MonthName { get; set; } = string.Empty;
    public int Year { get; set; }
    public int CompletedDonations { get; set; }
    public decimal RedistributedQuantity { get; set; }
}

public class DonationHistoryFilterDto
{
    public DateTime? FromDate { get; set; }
    public DateTime? ToDate { get; set; }
    public string? Status { get; set; }
    public string? SearchTerm { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}