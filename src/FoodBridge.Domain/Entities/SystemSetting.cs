using System;

namespace FoodBridge.Domain.Entities;

public class SystemSetting
{
    public string Key { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
    public DateTimeOffset UpdatedAt { get; set; } = DateTimeOffset.UtcNow;
    public string? UpdatedBy { get; set; }
}
