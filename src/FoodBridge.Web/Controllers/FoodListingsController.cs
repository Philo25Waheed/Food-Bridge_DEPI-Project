using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class FoodListingsController : ControllerBase
{
    private readonly IFoodListingService _listingService;
    private readonly ICurrentUserService _currentUserService;

    public FoodListingsController(
        IFoodListingService listingService,
        ICurrentUserService currentUserService)
    {
        _listingService = listingService;
        _currentUserService = currentUserService;
    }

    [HttpGet]
    [Authorize]
    public async Task<IActionResult> Discover([FromQuery] FoodListingFilterDto filter)
    {
        var result = await _listingService.DiscoverListingsAsync(filter);
        return Ok(result);
    }

    [HttpGet("{id}")]
    [Authorize]
    public async Task<IActionResult> GetById(int id)
    {
        var result = await _listingService.GetListingByIdAsync(id);
        if (!result.Succeeded)
        {
            return NotFound(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpGet("provider/my-listings")]
    [Authorize(Roles = "Provider,Admin")]
    public async Task<IActionResult> GetProviderListings([FromQuery] string? status = null)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var listings = await _listingService.GetProviderListingsAsync(providerId, status);
        return Ok(listings);
    }

    [HttpPost]
    [Authorize(Roles = "Provider")]
    [Consumes("multipart/form-data")]
    public async Task<IActionResult> CreateListingWithImage([FromForm] CreateFoodListingDto dto, IFormFile? image)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        Stream? stream = null;
        string? fileName = null;
        string? contentType = null;

        if (image != null && image.Length > 0)
        {
            stream = image.OpenReadStream();
            fileName = image.FileName;
            contentType = image.ContentType;
        }

        var result = await _listingService.CreateListingAsync(providerId, dto, stream, fileName, contentType);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error, errors = result.Errors });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Data!.Id }, result.Data);
    }

    [HttpPost("json")]
    [Authorize(Roles = "Provider")]
    public async Task<IActionResult> CreateListingJson([FromBody] CreateFoodListingDto dto)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var result = await _listingService.CreateListingAsync(providerId, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error, errors = result.Errors });
        }

        return CreatedAtAction(nameof(GetById), new { id = result.Data!.Id }, result.Data);
    }

    [HttpPut("{id}")]
    [Authorize(Roles = "Provider")]
    public async Task<IActionResult> UpdateListing(int id, [FromBody] UpdateFoodListingDto dto)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var result = await _listingService.UpdateListingAsync(providerId, id, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }

        return Ok(result.Data);
    }

    [HttpPatch("{id}/unavailable")]
    [Authorize(Roles = "Provider,Admin")]
    public async Task<IActionResult> MarkUnavailable(int id)
    {
        var providerId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(providerId)) return Unauthorized();

        var result = await _listingService.MarkAsUnavailableAsync(providerId, id);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }

        return Ok(new { message = "Listing marked as unavailable." });
    }

    [HttpPost("{id}/report")]
    [Authorize]
    public async Task<IActionResult> ReportListing(int id, [FromBody] ModerationActionDto dto)
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var result = await _listingService.ReportListingAsync(userId, id, dto.Reason);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }

        return Ok(new { message = "Listing reported to platform administrators for review." });
    }
}