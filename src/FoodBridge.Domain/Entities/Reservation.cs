using System;
using System.Collections.Generic;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Domain.Entities;

public class Reservation
{
    public int Id { get; set; }

    public int FoodListingId { get; set; }
    public virtual FoodListing? FoodListing { get; set; }

    public string CharityId { get; set; } = string.Empty;
    public virtual ApplicationUser? Charity { get; set; }

    public DateTimeOffset RequestDate { get; set; } = DateTimeOffset.UtcNow;
    
    public DateTime? PickupDateTime { get; set; }
    public string? ConfirmedLocation { get; set; }

    public ReservationStatus Status { get; set; } = ReservationStatus.Pending;

    public string? CancellationReason { get; set; }
    public string? ProblemDescription { get; set; }
    public DateTimeOffset? CompletedAt { get; set; }

    public byte[]? RowVersion { get; set; }

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
}