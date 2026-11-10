using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using FoodBridge.Application.Common.Interfaces;

namespace FoodBridge.Web.Services;

public class CurrentUserService : ICurrentUserService
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public CurrentUserService(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public string? UserId => _httpContextAccessor.HttpContext?.User?.FindFirstValue(ClaimTypes.NameIdentifier)
                             ?? _httpContextAccessor.HttpContext?.User?.FindFirst("userId")?.Value;

    public string? Email => _httpContextAccessor.HttpContext?.User?.FindFirstValue(ClaimTypes.Email);

    public string? Role => _httpContextAccessor.HttpContext?.User?.FindFirstValue(ClaimTypes.Role)
                           ?? _httpContextAccessor.HttpContext?.User?.FindFirstValue("role");

    public bool IsAuthenticated => _httpContextAccessor.HttpContext?.User?.Identity?.IsAuthenticated ?? false;
}