using System;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using FoodBridge.Application.Common;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;
using FoodBridge.Domain.Entities;
using FoodBridge.Infrastructure.Data;
using FoodBridge.Infrastructure.Hubs;

namespace FoodBridge.Infrastructure.Services;

public class MaintenanceService : IMaintenanceService
{
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly IHubContext<NotificationHub> _hubContext;
    private readonly ILogger<MaintenanceService> _logger;
    private readonly object _lock = new();

    private MaintenanceModeStatusDto _currentStatus = new()
    {
        IsMaintenanceActive = false,
        Reason = string.Empty,
        ReasonAr = string.Empty
    };

    public MaintenanceService(
        IServiceScopeFactory scopeFactory,
        IHubContext<NotificationHub> hubContext,
        ILogger<MaintenanceService> logger)
    {
        _scopeFactory = scopeFactory;
        _hubContext = hubContext;
        _logger = logger;
    }

    public bool IsActive
    {
        get
        {
            lock (_lock)
            {
                return _currentStatus.IsMaintenanceActive;
            }
        }
    }

    public MaintenanceModeStatusDto GetCurrentStatus()
    {
        lock (_lock)
        {
            return new MaintenanceModeStatusDto
            {
                IsMaintenanceActive = _currentStatus.IsMaintenanceActive,
                Reason = _currentStatus.Reason,
                ReasonAr = _currentStatus.ReasonAr,
                EstimatedDuration = _currentStatus.EstimatedDuration,
                ActivatedAt = _currentStatus.ActivatedAt,
                ActivatedByAdminName = _currentStatus.ActivatedByAdminName
            };
        }
    }

    public async Task InitializeAsync()
    {
        try
        {
            using var scope = _scopeFactory.CreateScope();
            var context = scope.ServiceProvider.GetRequiredService<FoodBridgeDbContext>();

            var setting = await context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "MaintenanceMode");
            if (setting != null && !string.IsNullOrWhiteSpace(setting.Value))
            {
                var loaded = JsonSerializer.Deserialize<MaintenanceModeStatusDto>(setting.Value);
                if (loaded != null)
                {
                    lock (_lock)
                    {
                        _currentStatus = loaded;
                    }
                    _logger.LogInformation("Loaded Maintenance Mode status: Active = {IsActive}", loaded.IsMaintenanceActive);
                }
            }
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to initialize maintenance mode status from database.");
        }
    }

    public async Task<Result<MaintenanceModeStatusDto>> ToggleMaintenanceModeAsync(string adminId, ToggleMaintenanceModeDto dto)
    {
        using var scope = _scopeFactory.CreateScope();
        var context = scope.ServiceProvider.GetRequiredService<FoodBridgeDbContext>();

        var admin = await context.Users.FirstOrDefaultAsync(u => u.Id == adminId);
        if (admin == null)
        {
            return Result<MaintenanceModeStatusDto>.Failure("Administrator user not found.");
        }

        var adminName = admin.FullName ?? admin.Email ?? "Administrator";
        var defaultReasonEn = "Scheduled platform maintenance and database optimization in progress.";
        var defaultReasonAr = "تجري حالياً أعمال صيانة وتحديثات مجدولة لقاعدة البيانات والبنية التحتية للمنصة.";

        MaintenanceModeStatusDto newStatus;
        lock (_lock)
        {
            newStatus = new MaintenanceModeStatusDto
            {
                IsMaintenanceActive = dto.Enable,
                Reason = !string.IsNullOrWhiteSpace(dto.Reason) ? dto.Reason : (dto.Enable ? defaultReasonEn : string.Empty),
                ReasonAr = !string.IsNullOrWhiteSpace(dto.ReasonAr) ? dto.ReasonAr : (dto.Enable ? defaultReasonAr : string.Empty),
                EstimatedDuration = dto.Enable ? dto.EstimatedDuration ?? "30-45 minutes" : null,
                ActivatedAt = dto.Enable ? DateTimeOffset.UtcNow : null,
                ActivatedByAdminName = dto.Enable ? adminName : null
            };
            _currentStatus = newStatus;
        }

        try
        {
            var setting = await context.SystemSettings.FirstOrDefaultAsync(s => s.Key == "MaintenanceMode");
            var jsonValue = JsonSerializer.Serialize(newStatus);

            if (setting == null)
            {
                setting = new SystemSetting
                {
                    Key = "MaintenanceMode",
                    Value = jsonValue,
                    UpdatedAt = DateTimeOffset.UtcNow,
                    UpdatedBy = adminName
                };
                context.SystemSettings.Add(setting);
            }
            else
            {
                setting.Value = jsonValue;
                setting.UpdatedAt = DateTimeOffset.UtcNow;
                setting.UpdatedBy = adminName;
            }

            var auditLog = new AuditLog
            {
                AdminId = adminId,
                Action = dto.Enable ? "EnableMaintenanceMode" : "DisableMaintenanceMode",
                TargetEntity = "System",
                TargetId = "MaintenanceMode",
                Details = dto.Enable
                    ? $"Platform locked for maintenance by {adminName}. Reason: {newStatus.Reason}. Duration: {newStatus.EstimatedDuration}."
                    : $"Platform returned to live operation by {adminName}.",
                Timestamp = DateTimeOffset.UtcNow
            };
            context.AuditLogs.Add(auditLog);

            await context.SaveChangesAsync();

            await _hubContext.Clients.All.SendAsync("MaintenanceModeChanged", newStatus);

            _logger.LogWarning("Maintenance Mode toggled to {Status} by admin {Admin}", newStatus.IsMaintenanceActive, adminName);
            return Result<MaintenanceModeStatusDto>.Success(newStatus);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to persist maintenance mode change to database.");
            return Result<MaintenanceModeStatusDto>.Failure("Failed to persist maintenance mode change: " + ex.Message);
        }
    }
}
