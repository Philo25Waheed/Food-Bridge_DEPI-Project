using System;

namespace FoodBridge.Domain.Entities;

public class Review
{
    public int Id { get; set; }

    public int ReservationId { get; set; }
    public virtual Reservation? Reservation { get; set; }

    public string ReviewerId { get; set; } = string.Empty;
    public virtual ApplicationUser? Reviewer { get; set; }

    public string RevieweeId { get; set; } = string.Empty;
    public virtual ApplicationUser? Reviewee { get; set; }

    public int Rating { get; set; }
    public string? Comment { get; set; }

    public bool IsReported { get; set; } = false;
    public string? ReportReason { get; set; }

    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
}