using System;

namespace FoodBridge.Domain.Entities;

public class AuditLog
{
    public int Id { get; set; }

    public string AdminId { get; set; } = string.Empty;
    public virtual ApplicationUser? Admin { get; set; }

    public string Action { get; set; } = string.Empty;
    public string TargetEntity { get; set; } = string.Empty;
    public string TargetId { get; set; } = string.Empty;
    public string Details { get; set; } = string.Empty;
    public DateTimeOffset Timestamp { get; set; } = DateTimeOffset.UtcNow;
}