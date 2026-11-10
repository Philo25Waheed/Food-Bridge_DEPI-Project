using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Interfaces;
using FoodBridge.Infrastructure.Services;

namespace FoodBridge.Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly IAuthService _authService;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMaintenanceService _maintenanceService;

    public AuthController(IAuthService authService, ICurrentUserService currentUserService, IMaintenanceService maintenanceService)
    {
        _authService = authService;
        _currentUserService = currentUserService;
        _maintenanceService = maintenanceService;
    }

    [HttpPost("register-provider")]
    public async Task<IActionResult> RegisterProvider([FromBody] RegisterProviderDto dto)
    {
        var result = await _authService.RegisterProviderAsync(dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { errors = result.Errors, message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("register-charity")]
    public async Task<IActionResult> RegisterCharity([FromBody] RegisterCharityDto dto)
    {
        var result = await _authService.RegisterCharityAsync(dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { errors = result.Errors, message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginDto dto)
    {
        var result = await _authService.LoginAsync(dto);
        if (!result.Succeeded)
        {
            if (result.Error != null && result.Error.StartsWith("SUSPENDED||"))
            {
                var parts = result.Error.Split("||");
                var reason = parts.Length > 1 ? parts[1] : "تم تعليق الحساب لمخالفة معايير وسياسات المنصة.";
                var supportEmail = parts.Length > 2 ? parts[2] : "ahlawy.ahmed25@gmail.com";
                var fullName = parts.Length > 3 ? parts[3] : "";
                var organizationName = parts.Length > 4 ? parts[4] : "";
                var suspendedAt = parts.Length > 5 ? parts[5] : "";

                return StatusCode(StatusCodes.Status403Forbidden, new
                {
                    isSuspended = true,
                    title = "تم تعليق الحساب",
                    titleEn = "Account Suspended",
                    reason = reason,
                    supportEmail = supportEmail,
                    fullName = fullName,
                    organizationName = organizationName,
                    email = dto.Email,
                    suspendedAt = suspendedAt,
                    message = $"تم تعليق حسابك. السبب: {reason}. للتواصل مع الدعم الفني: {supportEmail}"
                });
            }

            return Unauthorized(new { message = result.Error });
        }

        if (_maintenanceService.IsActive && result.Data?.Role != "Admin")
        {
            return StatusCode(StatusCodes.Status503ServiceUnavailable, new
            {
                title = "النظام قيد التطوير والتحديثات",
                titleEn = "System Under Development & Upgrades",
                message = "النظام قيد التطوير والتحديثات حالياً. تسجيل الدخول متاح لمسؤولي النظام فقط.",
                messageEn = "The platform is currently under development and scheduled upgrades. Access is restricted to Administrators only."
            });
        }
        return Ok(result.Data);
    }

    [HttpPost("verify-email")]
    public async Task<IActionResult> VerifyEmail([FromBody] VerifyEmailDto dto)
    {
        var result = await _authService.VerifyEmailAsync(dto.UserId, dto.Token);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = result.Data });
    }

    [HttpPost("resend-verification")]
    public async Task<IActionResult> ResendVerification([FromBody] ForgotPasswordDto dto)
    {
        var result = await _authService.ResendVerificationEmailAsync(dto.Email);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = result.Data });
    }

    [HttpPost("forgot-password")]
    public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordDto dto)
    {
        var result = await _authService.ForgotPasswordAsync(dto.Email);
        return Ok(new { message = result.Data });
    }

    [HttpPost("reset-password")]
    public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordDto dto)
    {
        var result = await _authService.ResetPasswordAsync(dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(new { message = result.Data });
    }

    [HttpGet("profile")]
    [Authorize]
    public async Task<IActionResult> GetProfile()
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var result = await _authService.GetProfileAsync(userId);
        if (!result.Succeeded)
        {
            return NotFound(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpPut("profile")]
    [Authorize]
    public async Task<IActionResult> UpdateProfile([FromBody] UpdateProfileDto dto)
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var result = await _authService.UpdateProfileAsync(userId, dto);
        if (!result.Succeeded)
        {
            return BadRequest(new { message = result.Error });
        }
        return Ok(result.Data);
    }

    [HttpGet("recent-emails")]
    public IActionResult GetRecentEmails()
    {
        return Ok(EmailSenderService.RecentEmails);
    }
}
