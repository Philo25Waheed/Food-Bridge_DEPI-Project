using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Moq;
using Xunit;
using FoodBridge.Application.DTOs;
using FoodBridge.Domain.Entities;
using FoodBridge.Domain.Enums;
using FoodBridge.Infrastructure.Data;
using FoodBridge.Infrastructure.Hubs;
using FoodBridge.Infrastructure.Services;
using FoodBridge.Tests.TestHelpers;

namespace FoodBridge.Tests;

public class MaintenanceServiceTests
{
    private readonly Mock<IHubContext<NotificationHub>> _mockHubContext = new();
    private readonly Mock<ILogger<MaintenanceService>> _mockLogger = new();
    private readonly Mock<IHubClients> _mockClients = new();
    private readonly Mock<IClientProxy> _mockClientProxy = new();

    public MaintenanceServiceTests()
    {
        _mockClients.Setup(c => c.All).Returns(_mockClientProxy.Object);
        _mockHubContext.Setup(h => h.Clients).Returns(_mockClients.Object);
    }

    [Fact]
    public async Task ToggleMaintenanceMode_EnablesAndDisablesMaintenance_PersistsAndBroadcasts()
    {
        var dbName = Guid.NewGuid().ToString();
        var db = TestDbContextFactory.Create(dbName);

        var admin = new ApplicationUser
        {
            Id = "admin-test-1",
            FullName = "Lead Administrator",
            Email = "admin@foodbridge.com",
            UserType = UserType.Administrator
        };
        db.Users.Add(admin);
        await db.SaveChangesAsync();

        var serviceProviderMock = new Mock<IServiceProvider>();
        var scopeMock = new Mock<IServiceScope>();
        var scopeFactoryMock = new Mock<IServiceScopeFactory>();

        serviceProviderMock.Setup(sp => sp.GetService(typeof(FoodBridgeDbContext)))
            .Returns(() => TestDbContextFactory.Create(dbName));

        scopeMock.Setup(s => s.ServiceProvider).Returns(serviceProviderMock.Object);
        scopeFactoryMock.Setup(f => f.CreateScope()).Returns(scopeMock.Object);

        var service = new MaintenanceService(scopeFactoryMock.Object, _mockHubContext.Object, _mockLogger.Object);

        Assert.False(service.IsActive);

        var enableResult = await service.ToggleMaintenanceModeAsync("admin-test-1", new ToggleMaintenanceModeDto
        {
            Enable = true,
            Reason = "Database migration in progress",
            ReasonAr = "تحديث قاعدة البيانات قيد التنفيذ",
            EstimatedDuration = "20 minutes"
        });

        Assert.True(enableResult.Succeeded);
        Assert.True(service.IsActive);
        Assert.Equal("Database migration in progress", service.GetCurrentStatus().Reason);
        Assert.Equal("تحديث قاعدة البيانات قيد التنفيذ", service.GetCurrentStatus().ReasonAr);

        var checkDb = TestDbContextFactory.Create(dbName);
        var setting = await checkDb.SystemSettings.FirstOrDefaultAsync(s => s.Key == "MaintenanceMode");
        Assert.NotNull(setting);
        Assert.Contains("Database migration in progress", setting!.Value);

        var auditLog = await checkDb.AuditLogs.FirstOrDefaultAsync(a => a.Action == "EnableMaintenanceMode");
        Assert.NotNull(auditLog);
        Assert.Equal("admin-test-1", auditLog!.AdminId);

        var disableResult = await service.ToggleMaintenanceModeAsync("admin-test-1", new ToggleMaintenanceModeDto
        {
            Enable = false
        });

        Assert.True(disableResult.Succeeded);
        Assert.False(service.IsActive);
    }
}
