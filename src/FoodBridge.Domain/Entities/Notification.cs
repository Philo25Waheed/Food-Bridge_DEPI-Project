using System;

namespace FoodBridge.Domain.Entities;

public class Notification
{
    public int Id { get; set; }

    public string UserId { get; set; } = string.Empty;
    public virtual ApplicationUser? User { get; set; }

    public string Title { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public bool IsRead { get; set; } = false;
    public string? RelatedEntityId { get; set; }

    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
}