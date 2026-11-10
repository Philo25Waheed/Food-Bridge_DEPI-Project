using System;
using System.ComponentModel.DataAnnotations;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Application.DTOs;

public class CreateFoodListingDto
{
    [Required, StringLength(150)]
    public string FoodName { get; set; } = string.Empty;

    [Required, StringLength(1000)]
    public string Description { get; set; } = string.Empty;

    [Required]
    public FoodCategory FoodCategory { get; set; }

    [Required, Range(0.1, 100000)]
    public decimal Quantity { get; set; }

    [Required, StringLength(50)]
    public string UnitOfMeasurement { get; set; } = "portions";

    [Required]
    public DateTime PreparationDate { get; set; }

    [Required]
    public DateTime PickupDeadline { get; set; }

    [Required, StringLength(250)]
    public string PickupAddress { get; set; } = string.Empty;

    [Required, StringLength(200)]
    public string StorageConditions { get; set; } = "Room Temperature";

    [Required, StringLength(250)]
    public string Allergens { get; set; } = "None";
}

public class UpdateFoodListingDto : CreateFoodListingDto
{
    public byte[]? RowVersion { get; set; }
}

public class FoodListingDto
{
    public int Id { get; set; }
    public string ProviderId { get; set; } = string.Empty;
    public string ProviderName { get; set; } = string.Empty;
    public string ProviderOrganization { get; set; } = string.Empty;
    public string ProviderType { get; set; } = string.Empty;
    public double ProviderAverageRating { get; set; }
    public int ProviderReviewsCount { get; set; }

    public string FoodName { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public FoodCategory FoodCategory { get; set; }
    public string FoodCategoryName => FoodCategory.ToString();
    public decimal Quantity { get; set; }
    public string UnitOfMeasurement { get; set; } = string.Empty;

    public DateTime PreparationDate { get; set; }
    public DateTime PickupDeadline { get; set; }
    public string PickupAddress { get; set; } = string.Empty;

    public string StorageConditions { get; set; } = string.Empty;
    public string Allergens { get; set; } = string.Empty;
    public string? ImageUrl { get; set; }
    public FoodListingStatus Status { get; set; }
    public string StatusName => Status.ToString();

    public bool IsReported { get; set; }
    public string? ReportReason { get; set; }

    public byte[]? RowVersion { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}

public class FoodListingFilterDto
{
    public FoodCategory? Category { get; set; }
    public string? ProviderType { get; set; }
    public DateTime? AvailabilityDate { get; set; }
    public string? SearchTerm { get; set; }
    public string? SortBy { get; set; } = "newest";
    public bool OnlyAvailable { get; set; } = true;
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}

public class PagedResult<T>
{
    public List<T> Items { get; set; } = new();
    public int TotalCount { get; set; }
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public int TotalPages => (int)Math.Ceiling((double)TotalCount / (PageSize > 0 ? PageSize : 1));
}