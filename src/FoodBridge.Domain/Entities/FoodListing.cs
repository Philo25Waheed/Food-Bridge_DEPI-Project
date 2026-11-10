using System;
using System.Collections.Generic;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Domain.Entities;

public class FoodListing
{
    public int Id { get; set; }

    public string ProviderId { get; set; } = string.Empty;
    public virtual ApplicationUser? Provider { get; set; }

    public string FoodName { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public FoodCategory FoodCategory { get; set; }
    public decimal Quantity { get; set; }
    public string UnitOfMeasurement { get; set; } = "portions";

    public DateTime PreparationDate { get; set; }
    public DateTime PickupDeadline { get; set; }
    public string PickupAddress { get; set; } = string.Empty;

    public string StorageConditions { get; set; } = string.Empty;
    public string Allergens { get; set; } = "None";

    public string? ImageUrl { get; set; }
    public FoodListingStatus Status { get; set; } = FoodListingStatus.Available;

    public bool IsReported { get; set; } = false;
    public string? ReportReason { get; set; }

    public byte[]? RowVersion { get; set; }

    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset? UpdatedAt { get; set; }

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}