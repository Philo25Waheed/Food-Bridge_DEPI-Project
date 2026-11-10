using System;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Implementations;
using FoodBridge.Domain.Entities;
using FoodBridge.Domain.Enums;
using FoodBridge.Tests.TestHelpers;

namespace FoodBridge.Tests;

public class AdminModerationTests
{
    private readonly Mock<INotificationService> _mockNotification = new();

    [Fact]
    public async Task VerifyOrganizationAsync_UpdatesStatusAndCreatesAuditLog()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var adminService = new AdminService(db, _mockNotification.Object);

        var admin = new ApplicationUser { Id = "admin-1", FullName = "Admin", UserType = UserType.Administrator };
        var provider = new ApplicationUser
        {
            Id = "provider-unverified",
            FullName = "New Provider",
            OrganizationName = "Local Bakery",
            UserType = UserType.FoodProvider,
            IsVerified = false
        };

        db.Users.AddRange(admin, provider);
        await db.SaveChangesAsync();

        var result = await adminService.VerifyOrganizationAsync("admin-1", "provider-unverified", isApproved: true);

        Assert.True(result.Succeeded);

        var updatedProvider = await db.Users.FindAsync("provider-unverified");
        Assert.True(updatedProvider!.IsVerified);

        var audit = await db.AuditLogs.FirstOrDefaultAsync(a => a.TargetId == "provider-unverified");
        Assert.NotNull(audit);
        Assert.Equal("ApproveVerification", audit!.Action);
        Assert.Equal("admin-1", audit.AdminId);
    }

    [Fact]
    public async Task SetUserStatusAsync_WhenSuspending_SetsStatusSuspendedAndAuditLogs()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var adminService = new AdminService(db, _mockNotification.Object);

        var admin = new ApplicationUser { Id = "admin-1", FullName = "Admin" };
        var charity = new ApplicationUser { Id = "charity-violator", FullName = "Charity Violator", Status = UserStatus.Active };

        db.Users.AddRange(admin, charity);
        await db.SaveChangesAsync();

        var result = await adminService.SetUserStatusAsync("admin-1", "charity-violator", suspend: true);

        Assert.True(result.Succeeded);

        var updatedCharity = await db.Users.FindAsync("charity-violator");
        Assert.Equal(UserStatus.Suspended, updatedCharity!.Status);

        var audit = await db.AuditLogs.FirstOrDefaultAsync(a => a.TargetId == "charity-violator" && a.Action == "SuspendUser");
        Assert.NotNull(audit);
    }

    [Fact]
    public async Task SetUserStatusAsync_WhenAdminSuspendsSelf_ReturnsFailureSecurityRule()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var adminService = new AdminService(db, _mockNotification.Object);

        var admin = new ApplicationUser { Id = "admin-1", FullName = "Admin", UserType = UserType.Administrator };
        db.Users.Add(admin);
        await db.SaveChangesAsync();

        var result = await adminService.SetUserStatusAsync("admin-1", "admin-1", suspend: true);

        Assert.False(result.Succeeded);
        Assert.Contains("cannot suspend their own account", result.Error);
    }

    [Fact]
    public async Task GetExpiredListingsAsync_And_DashboardStats_CalculatesWastedSurplusAccurately()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var adminService = new AdminService(db, _mockNotification.Object);

        var provider = new ApplicationUser { Id = "prov-waste", FullName = "Chef Mark", OrganizationName = "Bistro", UserType = UserType.FoodProvider };
        var listing1 = new FoodListing
        {
            Id = 101,
            ProviderId = "prov-waste",
            FoodName = "Overripe Bananas",
            Quantity = 15m,
            UnitOfMeasurement = "kg",
            Status = FoodListingStatus.Expired,
            PickupDeadline = DateTime.UtcNow.AddHours(-3)
        };
        var listing2 = new FoodListing
        {
            Id = 102,
            ProviderId = "prov-waste",
            FoodName = "Unsold Sandwiches",
            Quantity = 20m,
            UnitOfMeasurement = "portions",
            Status = FoodListingStatus.Expired,
            PickupDeadline = DateTime.UtcNow.AddHours(-1)
        };
        var listing3 = new FoodListing
        {
            Id = 103,
            ProviderId = "prov-waste",
            FoodName = "Fresh Apples",
            Quantity = 50m,
            UnitOfMeasurement = "kg",
            Status = FoodListingStatus.Available,
            PickupDeadline = DateTime.UtcNow.AddHours(5)
        };

        db.Users.Add(provider);
        db.FoodListings.AddRange(listing1, listing2, listing3);
        await db.SaveChangesAsync();

        var expiredListings = await adminService.GetExpiredListingsAsync();
        Assert.Equal(2, expiredListings.Count);

        var stats = await adminService.GetDashboardStatsAsync();
        Assert.Equal(2, stats.ExpiredDonationsCount);
        Assert.Equal(35m, stats.TotalWastedQuantity);
    }

    [Fact]
    public async Task HandleExpiredListingActionAsync_WarnProvider_SendsAdvisoryAndCreatesAudit()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var adminService = new AdminService(db, _mockNotification.Object);

        var provider = new ApplicationUser { Id = "prov-warn", FullName = "Baker Sam", OrganizationName = "Sam Bakery", UserType = UserType.FoodProvider };
        var listing = new FoodListing
        {
            Id = 201,
            ProviderId = "prov-warn",
            FoodName = "Pastries",
            Quantity = 10m,
            UnitOfMeasurement = "boxes",
            Status = FoodListingStatus.Expired
        };

        db.Users.Add(provider);
        db.FoodListings.Add(listing);
        await db.SaveChangesAsync();

        var actionDto = new ExpiredListingActionDto
        {
            ActionType = "WarnProvider",
            Notes = "Please reduce quantities or post listings sooner."
        };

        var result = await adminService.HandleExpiredListingActionAsync("admin-1", 201, actionDto);

        Assert.True(result.Succeeded);

        var audit = await db.AuditLogs.FirstOrDefaultAsync(a => a.TargetId == "201" && a.Action == "WarnProviderFoodWaste");
        Assert.NotNull(audit);
        Assert.Contains("Official advisory sent", audit!.Details);
    }

    [Fact]
    public async Task HandleExpiredListingActionAsync_SuspendProvider_SuspendsUserAccount()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var adminService = new AdminService(db, _mockNotification.Object);

        var provider = new ApplicationUser { Id = "prov-suspend", FullName = "Chronic Waster", Status = UserStatus.Active, UserType = UserType.FoodProvider };
        var listing = new FoodListing
        {
            Id = 301,
            ProviderId = "prov-suspend",
            FoodName = "Bulk Meat",
            Quantity = 40m,
            UnitOfMeasurement = "kg",
            Status = FoodListingStatus.Expired
        };

        db.Users.Add(provider);
        db.FoodListings.Add(listing);
        await db.SaveChangesAsync();

        var actionDto = new ExpiredListingActionDto
        {
            ActionType = "SuspendProvider",
            Notes = "Repeated waste non-compliance."
        };

        var result = await adminService.HandleExpiredListingActionAsync("admin-1", 301, actionDto);

        Assert.True(result.Succeeded);

        var updatedProvider = await db.Users.FindAsync("prov-suspend");
        Assert.Equal(UserStatus.Suspended, updatedProvider!.Status);

        var audit = await db.AuditLogs.FirstOrDefaultAsync(a => a.TargetId == "prov-suspend" && a.Action == "SuspendProviderWasteViolation");
        Assert.NotNull(audit);
    }

    [Fact]
    public async Task GetAuditLogsAsync_EnrichesTargetNameAndAdminDetails()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var adminService = new AdminService(db, _mockNotification.Object);

        var admin = new ApplicationUser
        {
            Id = "admin-audit-1",
            FullName = "Eng. Abdallah",
            Email = "abdallah@foodbridge.org",
            SpecificType = "Operations Admin",
            UserType = UserType.Administrator
        };
        var targetUser = new ApplicationUser
        {
            Id = "user-audit-target",
            FullName = "Ahmed Target",
            OrganizationName = "Cairo Bakery",
            Email = "target@bakery.com",
            UserType = UserType.FoodProvider
        };
        var foodListing = new FoodListing
        {
            Id = 555,
            FoodName = "Fresh Sandwiches",
            ProviderId = "user-audit-target",
            Quantity = 15m,
            UnitOfMeasurement = "meals"
        };

        db.Users.AddRange(admin, targetUser);
        db.FoodListings.Add(foodListing);

        db.AuditLogs.AddRange(
            new AuditLog
            {
                Id = 1,
                AdminId = "admin-audit-1",
                Action = "SuspendUser",
                TargetEntity = "ApplicationUser",
                TargetId = "user-audit-target",
                Details = "User 'Ahmed Target' (Cairo Bakery) was suspended. Reason: Expired food dispatch.",
                Timestamp = DateTimeOffset.UtcNow
            },
            new AuditLog
            {
                Id = 2,
                AdminId = "admin-audit-1",
                Action = "RemoveListing",
                TargetEntity = "FoodListing",
                TargetId = "555",
                Details = "Listing 'Fresh Sandwiches' removed. Reason: Incorrect packaging.",
                Timestamp = DateTimeOffset.UtcNow.AddMinutes(1)
            },
            new AuditLog
            {
                Id = 3,
                AdminId = "user-audit-target",
                Action = "AutoSecuritySuspension",
                TargetEntity = "ApplicationUser",
                TargetId = "user-audit-target",
                Details = "Account 'target@bakery.com' was automatically suspended after 10 failed login attempts.",
                Timestamp = DateTimeOffset.UtcNow.AddMinutes(2)
            }
        );
        await db.SaveChangesAsync();

        var logs = await adminService.GetAuditLogsAsync();

        Assert.Equal(3, logs.Count);

        // Auto security log
        var securityLog = logs.First(l => l.Action == "AutoSecuritySuspension");
        Assert.Contains("Security Bot", securityLog.AdminName);
        Assert.Equal("security-bot@foodbridge.system", securityLog.AdminEmail);
        Assert.Equal("Ahmed Target (Cairo Bakery)", securityLog.TargetName);
        Assert.Contains("Food Provider", securityLog.TargetType);

        // Listing removal log
        var listingLog = logs.First(l => l.Action == "RemoveListing");
        Assert.Equal("Eng. Abdallah", listingLog.AdminName);
        Assert.Equal("abdallah@foodbridge.org", listingLog.AdminEmail);
        Assert.Contains("Fresh Sandwiches", listingLog.TargetName);

        // User suspension log
        var userLog = logs.First(l => l.Action == "SuspendUser");
        Assert.Equal("Ahmed Target (Cairo Bakery)", userLog.TargetName);
    }
}
