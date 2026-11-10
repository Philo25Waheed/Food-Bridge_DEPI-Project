using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Web.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ReservationsController : ControllerBase
{
    private readonly IReservationService _reservationService;
    private readonly ICurrentUserService _currentUserService;

    public ReservationsController(
        IReservationService reservationService,
        ICurrentUserService currentUserService)
    {
        _reservationService = reservationService;
        _currentUserService = currentUserService;
    }

    [HttpPost("request")]
    [Authorize(Roles = "Charity")]
    public async Task<IActionResult> RequestReservation([FromBody] CreateReservationRequestDto dto)
    {
        var charityId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(charityId)) return Unauthorized();

        var result = await _reservationService.RequestReservationAsync(charityId, dto.FoodListingId);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Data!.Id }, result.Data);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var currentUserId = _currentUserService.UserId ?? string.Empty;
        var result = await _reservationService.GetReservationByIdAsync(id, currentUserId);
        if (!result.Succeeded)
        {
            return NotFound(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpGet("provider/incoming")]
    [Authorize(Roles = "Provider,Admin")]
    public async Task<IActionResult> GetProviderIncoming([FromQuery] string? status = null)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var list = await _reservationService.GetIncomingRequestsForProviderAsync(providerId, status);
        return Ok(list);
    }

    [HttpGet("charity/my-reservations")]
    [Authorize(Roles = "Charity,Admin")]
    public async Task<IActionResult> GetCharityReservations([FromQuery] string? status = null)
    {
        var charityId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(charityId)) return Unauthorized();

        var list = await _reservationService.GetCharityReservationsAsync(charityId, status);
        return Ok(list);
    }

    [HttpPost("{id}/accept")]
    [Authorize(Roles = "Provider")]
    public async Task<IActionResult> Accept(int id, [FromBody] AcceptReservationDto dto)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var result = await _reservationService.AcceptReservationAsync(providerId, id, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("{id}/reject")]
    [Authorize(Roles = "Provider")]
    public async Task<IActionResult> Reject(int id, [FromBody] RejectReservationDto dto)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var result = await _reservationService.RejectReservationAsync(providerId, id, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("{id}/ready-for-pickup")]
    [Authorize(Roles = "Provider")]
    public async Task<IActionResult> MarkReadyForPickup(int id)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var result = await _reservationService.MarkReadyForPickupAsync(providerId, id);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("{id}/complete")]
    [Authorize(Roles = "Charity")]
    public async Task<IActionResult> MarkCompleted(int id)
    {
        var charityId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(charityId)) return Unauthorized();

        var result = await _reservationService.MarkCompletedAsync(charityId, id);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("{id}/cancel")]
    [Authorize(Roles = "Charity")]
    public async Task<IActionResult> Cancel(int id, [FromBody] CancelReservationDto dto)
    {
        var charityId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(charityId)) return Unauthorized();

        var result = await _reservationService.CancelReservationAsync(charityId, id, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("{id}/report-problem")]
    [Authorize(Roles = "Charity")]
    public async Task<IActionResult> ReportProblem(int id, [FromBody] ReportProblemDto dto)
    {
        var charityId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(charityId)) return Unauthorized();

        var result = await _reservationService.ReportPickupProblemAsync(charityId, id, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }
}