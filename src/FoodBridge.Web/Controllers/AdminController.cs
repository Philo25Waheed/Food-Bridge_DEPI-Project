using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Web.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly IAdminService _adminService;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMaintenanceService _maintenanceService;

    public AdminController(
        IAdminService adminService,
        ICurrentUserService currentUserService,
        IMaintenanceService maintenanceService)
    {
        _adminService = adminService;
        _currentUserService = currentUserService;
        _maintenanceService = maintenanceService;
    }

    [HttpGet("dashboard")]
    public async Task<IActionResult> GetDashboard()
    {
        var stats = await _adminService.GetDashboardStatsAsync();
        return Ok(stats);
    }

    [HttpGet("users")]
    public async Task<IActionResult> GetUsers([FromQuery] AdminUserFilterDto filter)
    {
        var users = await _adminService.GetUsersAsync(filter);
        return Ok(users);
    }

    [HttpPost("create-admin")]
    public async Task<IActionResult> CreateAdmin([FromBody] CreateAdminDto dto)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _adminService.CreateAdminAsync(adminId, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("users/{id}/verify")]
    public async Task<IActionResult> VerifyUser(string id, [FromQuery] bool approve = true)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _adminService.VerifyOrganizationAsync(adminId, id, approve);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = approve ? "Organization verified successfully." : "Verification rejected/revoked." });
    }

    [HttpPost("users/{id}/status")]
    public async Task<IActionResult> SetUserStatus(string id, [FromQuery] bool suspend = true, [FromQuery] string? reason = null)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _adminService.SetUserStatusAsync(adminId, id, suspend, reason);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = suspend ? "User account suspended." : "User account reactivated." });
    }

    [HttpGet("reported-listings")]
    public async Task<IActionResult> GetReportedListings()
    {
        var listings = await _adminService.GetReportedListingsAsync();
        return Ok(listings);
    }

    [HttpGet("reported-reviews")]
    public async Task<IActionResult> GetReportedReviews()
    {
        var reviews = await _adminService.GetReportedReviewsAsync();
        return Ok(reviews);
    }

    [HttpGet("problem-reports")]
    public async Task<IActionResult> GetProblemReports()
    {
        var problems = await _adminService.GetProblemReportsAsync();
        return Ok(problems);
    }

    [HttpGet("expired-listings")]
    public async Task<IActionResult> GetExpiredListings()
    {
        var listings = await _adminService.GetExpiredListingsAsync();
        return Ok(listings);
    }

    [HttpPost("listings/{id}/waste-action")]
    public async Task<IActionResult> HandleWasteAction(int id, [FromBody] ExpiredListingActionDto dto)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _adminService.HandleExpiredListingActionAsync(adminId, id, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = "Administrative action applied and audit log created." });
    }

    [HttpPost("listings/{id}/remove")]
    public async Task<IActionResult> RemoveListing(int id, [FromBody] ModerationActionDto dto)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _adminService.RemoveListingAsync(adminId, id, dto.Reason);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = "Listing removed and audit log updated." });
    }

    [HttpPost("reviews/{id}/remove")]
    public async Task<IActionResult> RemoveReview(int id, [FromBody] ModerationActionDto dto)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _adminService.RemoveReviewAsync(adminId, id, dto.Reason);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = "Review deleted and audit log updated." });
    }

    [HttpPost("problems/{id}/resolve")]
    public async Task<IActionResult> ResolveProblem(int id, [FromBody] ModerationActionDto dto)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _adminService.ResolveProblemReportAsync(adminId, id, dto.Reason);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = "Problem report marked as resolved." });
    }

    [HttpGet("audit-logs")]
    public async Task<IActionResult> GetAuditLogs([FromQuery] int take = 100)
    {
        var logs = await _adminService.GetAuditLogsAsync(take);
        return Ok(logs);
    }

    [HttpGet("maintenance/status")]
    [AllowAnonymous]
    public IActionResult GetMaintenanceStatus()
    {
        var status = _maintenanceService.GetCurrentStatus();
        return Ok(status);
    }

    [HttpPost("maintenance/toggle")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> ToggleMaintenance([FromBody] ToggleMaintenanceModeDto dto)
    {
        var adminId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(adminId)) return Unauthorized();

        var result = await _maintenanceService.ToggleMaintenanceModeAsync(adminId, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }
}
