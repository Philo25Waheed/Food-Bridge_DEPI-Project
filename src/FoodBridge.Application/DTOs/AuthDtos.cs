using System;
using System.ComponentModel.DataAnnotations;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Application.DTOs;

public class RegisterProviderDto
{
    [Required]
    public string FullName { get; set; } = string.Empty;

    [Required, EmailAddress]
    public string Email { get; set; } = string.Empty;

    [Required, MinLength(6)]
    public string Password { get; set; } = string.Empty;

    [Required]
    public string OrganizationName { get; set; } = string.Empty;

    [Required]
    public string OrganizationAddress { get; set; } = string.Empty;

    [Required]
    public string SpecificType { get; set; } = "Restaurant";
}

public class RegisterCharityDto
{
    [Required]
    public string FullName { get; set; } = string.Empty;

    [Required, EmailAddress]
    public string Email { get; set; } = string.Empty;

    [Required, MinLength(6)]
    public string Password { get; set; } = string.Empty;

    [Required]
    public string OrganizationName { get; set; } = string.Empty;

    [Required]
    public string OrganizationAddress { get; set; } = string.Empty;

    [Required]
    public string SpecificType { get; set; } = "Food Bank";

    [Required]
    public string TargetCommunityDescription { get; set; } = string.Empty;
}

public class LoginDto
{
    [Required, EmailAddress]
    public string Email { get; set; } = string.Empty;

    [Required]
    public string Password { get; set; } = string.Empty;
}

public class AuthResponseDto
{
    public string Token { get; set; } = string.Empty;
    public string UserId { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
    public string OrganizationName { get; set; } = string.Empty;
    public bool IsVerified { get; set; }
    public string? SpecificType { get; set; }
}

public class VerifyEmailDto
{
    [Required]
    public string UserId { get; set; } = string.Empty;

    [Required]
    public string Token { get; set; } = string.Empty;
}

public class ForgotPasswordDto
{
    [Required, EmailAddress]
    public string Email { get; set; } = string.Empty;
}

public class ResetPasswordDto
{
    [Required, EmailAddress]
    public string Email { get; set; } = string.Empty;

    [Required]
    public string Token { get; set; } = string.Empty;

    [Required, MinLength(6)]
    public string NewPassword { get; set; } = string.Empty;
}

public class UserProfileDto
{
    public string UserId { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string OrganizationName { get; set; } = string.Empty;
    public string OrganizationAddress { get; set; } = string.Empty;
    public UserType UserType { get; set; }
    public string SpecificType { get; set; } = string.Empty;
    public string? TargetCommunityDescription { get; set; }
    public bool IsVerified { get; set; }
    public UserStatus Status { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
    public double AverageRating { get; set; }
    public int TotalReviewsCount { get; set; }
}

public class UpdateProfileDto
{
    [Required]
    public string FullName { get; set; } = string.Empty;

    [Required]
    public string OrganizationName { get; set; } = string.Empty;

    [Required]
    public string OrganizationAddress { get; set; } = string.Empty;

    public string SpecificType { get; set; } = string.Empty;

    public string? TargetCommunityDescription { get; set; }
}