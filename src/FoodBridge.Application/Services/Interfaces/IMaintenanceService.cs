using System.Threading.Tasks;
using FoodBridge.Application.Common;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Services.Interfaces;

public interface IMaintenanceService
{
    bool IsActive { get; }
    MaintenanceModeStatusDto GetCurrentStatus();
    Task InitializeAsync();
    Task<Result<MaintenanceModeStatusDto>> ToggleMaintenanceModeAsync(string adminId, ToggleMaintenanceModeDto dto);
}
