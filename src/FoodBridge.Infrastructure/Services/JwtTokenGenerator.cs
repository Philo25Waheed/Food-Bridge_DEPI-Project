using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Domain.Entities;

namespace FoodBridge.Infrastructure.Services;

public class JwtTokenGenerator : IJwtTokenGenerator
{
    private readonly IConfiguration _configuration;

    public JwtTokenGenerator(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public string GenerateToken(ApplicationUser user, IList<string> roles)
    {
        var secret = _configuration["JwtSettings:Secret"] ?? "FoodBridgeSuperSecretKeyForJwtTokenGeneration2026!";
        var issuer = _configuration["JwtSettings:Issuer"] ?? "FoodBridge";
        var audience = _configuration["JwtSettings:Audience"] ?? "FoodBridgeApp";
        var expiryDays = double.TryParse(_configuration["JwtSettings:ExpiryDays"], out var exp) ? exp : 7;

        var claims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.Sub, user.Id),
            new(JwtRegisteredClaimNames.Email, user.Email ?? string.Empty),
            new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new("userId", user.Id),
            new("fullName", user.FullName),
            new("organizationName", user.OrganizationName),
            new("userType", user.UserType.ToString()),
            new("isVerified", user.IsVerified ? "true" : "false"),
            new("status", user.Status.ToString())
        };

        foreach (var role in roles)
        {
            claims.Add(new Claim(ClaimTypes.Role, role));
        }

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var token = new JwtSecurityToken(
            issuer: issuer,
            audience: audience,
            claims: claims,
            expires: DateTime.UtcNow.AddDays(expiryDays),
            signingCredentials: creds
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}