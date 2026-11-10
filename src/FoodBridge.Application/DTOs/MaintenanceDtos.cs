using System;

namespace FoodBridge.Application.DTOs;

public class MaintenanceModeStatusDto
{
    public bool IsMaintenanceActive { get; set; }
    public string Reason { get; set; } = string.Empty;
    public string ReasonAr { get; set; } = string.Empty;
    public string? EstimatedDuration { get; set; }
    public DateTimeOffset? ActivatedAt { get; set; }
    public string? ActivatedByAdminName { get; set; }
}

public class ToggleMaintenanceModeDto
{
    public bool Enable { get; set; }
    public string? Reason { get; set; }
    public string? ReasonAr { get; set; }
    public string? EstimatedDuration { get; set; }
}
