using System.Threading.Tasks;
using FoodBridge.Application.Common;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Services.Interfaces;

public interface IAuthService
{
    Task<Result<AuthResponseDto>> RegisterProviderAsync(RegisterProviderDto dto);
    Task<Result<AuthResponseDto>> RegisterCharityAsync(RegisterCharityDto dto);
    Task<Result<AuthResponseDto>> LoginAsync(LoginDto dto);
    Task<Result<string>> VerifyEmailAsync(string userId, string token);
    Task<Result<string>> ForgotPasswordAsync(string email);
    Task<Result<string>> ResetPasswordAsync(ResetPasswordDto dto);
    Task<Result<UserProfileDto>> GetProfileAsync(string userId);
    Task<Result<UserProfileDto>> UpdateProfileAsync(string userId, UpdateProfileDto dto);
    Task<Result<string>> ResendVerificationEmailAsync(string email);
}