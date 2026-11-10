using System.Collections.Generic;
using System.Security.Claims;
using FoodBridge.Domain.Entities;

namespace FoodBridge.Application.Common.Interfaces;

public interface IJwtTokenGenerator
{
    string GenerateToken(ApplicationUser user, IList<string> roles);
}