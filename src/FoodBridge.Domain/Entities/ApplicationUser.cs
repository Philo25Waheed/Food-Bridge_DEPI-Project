using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Domain.Entities;

public class ApplicationUser : IdentityUser
{
    public string FullName { get; set; } = string.Empty;
    public string OrganizationName { get; set; } = string.Empty;
    public string OrganizationAddress { get; set; } = string.Empty;
    public UserType UserType { get; set; }
    public string SpecificType { get; set; } = string.Empty;
    public string? TargetCommunityDescription { get; set; }
    public bool IsVerified { get; set; } = false;
    public UserStatus Status { get; set; } = UserStatus.Active;
    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;

    public virtual ICollection<FoodListing> FoodListings { get; set; } = new List<FoodListing>();
    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
    public virtual ICollection<Review> ReviewsGiven { get; set; } = new List<Review>();
    public virtual ICollection<Review> ReviewsReceived { get; set; } = new List<Review>();
    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();
    public virtual ICollection<AuditLog> AuditLogs { get; set; } = new List<AuditLog>();
}