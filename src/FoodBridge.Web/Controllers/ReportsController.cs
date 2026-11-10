using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReportsController : ControllerBase
{
    private readonly IReportingService _reportingService;
    private readonly ICurrentUserService _currentUserService;

    public ReportsController(
        IReportingService reportingService,
        ICurrentUserService currentUserService)
    {
        _reportingService = reportingService;
        _currentUserService = currentUserService;
    }

    [HttpGet("platform")]
    public async Task<IActionResult> GetPlatformStats()
    {
        var stats = await _reportingService.GetPlatformStatsAsync();
        return Ok(stats);
    }

    [HttpGet("provider")]
    [Authorize(Roles = "Provider,Admin")]
    public async Task<IActionResult> GetProviderStats([FromQuery] string? providerId = null)
    {
        var targetId = !string.IsNullOrEmpty(providerId) ? providerId : _currentUserService.UserId;
        if (string.IsNullOrEmpty(targetId)) return Unauthorized();

        var stats = await _reportingService.GetProviderStatsAsync(targetId);
        return Ok(stats);
    }

    [HttpGet("charity")]
    [Authorize(Roles = "Charity,Admin")]
    public async Task<IActionResult> GetCharityStats([FromQuery] string? charityId = null)
    {
        var targetId = !string.IsNullOrEmpty(charityId) ? charityId : _currentUserService.UserId;
        if (string.IsNullOrEmpty(targetId)) return Unauthorized();

        var stats = await _reportingService.GetCharityStatsAsync(targetId);
        return Ok(stats);
    }

    [HttpPost("provider/history")]
    [Authorize(Roles = "Provider,Admin")]
    public async Task<IActionResult> FilterProviderHistory([FromBody] DonationHistoryFilterDto filter, [FromQuery] string? providerId = null)
    {
        var targetId = !string.IsNullOrEmpty(providerId) ? providerId : _currentUserService.UserId;
        if (string.IsNullOrEmpty(targetId)) return Unauthorized();

        var history = await _reportingService.FilterProviderDonationHistoryAsync(targetId, filter);
        return Ok(history);
    }

    [HttpPost("charity/history")]
    [Authorize(Roles = "Charity,Admin")]
    public async Task<IActionResult> FilterCharityHistory([FromBody] DonationHistoryFilterDto filter, [FromQuery] string? charityId = null)
    {
        var targetId = !string.IsNullOrEmpty(charityId) ? charityId : _currentUserService.UserId;
        if (string.IsNullOrEmpty(targetId)) return Unauthorized();

        var history = await _reportingService.FilterCharityDonationHistoryAsync(targetId, filter);
        return Ok(history);
    }
}