using System;
using System.Threading.Tasks;
using Moq;
using Xunit;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.Services.Implementations;
using FoodBridge.Domain.Entities;
using FoodBridge.Domain.Enums;
using FoodBridge.Tests.TestHelpers;

namespace FoodBridge.Tests;

public class FoodListingExpirationTests
{
    private readonly Mock<IFileStorageService> _mockFileStorage = new();
    private readonly Mock<INotificationService> _mockNotification = new();

    [Fact]
    public async Task ProcessExpiredListingsAsync_MarksOverdueListingsAsExpired()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new FoodListingService(db, _mockFileStorage.Object, _mockNotification.Object);

        var pastDeadline = DateTime.UtcNow.AddHours(-1);
        var futureDeadline = DateTime.UtcNow.AddHours(5);

        var listing1 = new FoodListing
        {
            Id = 1,
            ProviderId = "p1",
            FoodName = "Expired Bread",
            PickupDeadline = pastDeadline,
            Status = FoodListingStatus.Available
        };

        var listing2 = new FoodListing
        {
            Id = 2,
            ProviderId = "p1",
            FoodName = "Fresh Fruit",
            PickupDeadline = futureDeadline,
            Status = FoodListingStatus.Available
        };

        var listing3 = new FoodListing
        {
            Id = 3,
            ProviderId = "p1",
            FoodName = "Completed Rice",
            PickupDeadline = pastDeadline,
            Status = FoodListingStatus.Completed
        };

        db.FoodListings.AddRange(listing1, listing2, listing3);
        await db.SaveChangesAsync();

        var expiredCount = await service.ProcessExpiredListingsAsync();

        Assert.Equal(1, expiredCount);

        var updated1 = await db.FoodListings.FindAsync(1);
        var updated2 = await db.FoodListings.FindAsync(2);
        var updated3 = await db.FoodListings.FindAsync(3);

        Assert.Equal(FoodListingStatus.Expired, updated1!.Status);
        Assert.Equal(FoodListingStatus.Available, updated2!.Status);
        Assert.Equal(FoodListingStatus.Completed, updated3!.Status);
    }

    [Fact]
    public async Task CreateListingAsync_WhenQuantityBelowMinimumKg_ReturnsFailure()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new FoodListingService(db, _mockFileStorage.Object, _mockNotification.Object);

        var provider = new ApplicationUser { Id = "p-min", FullName = "Provider", UserType = UserType.FoodProvider, Status = UserStatus.Active };
        db.Users.Add(provider);
        await db.SaveChangesAsync();

        var dto = new FoodBridge.Application.DTOs.CreateFoodListingDto
        {
            FoodName = "Small Flour",
            Description = "Leftover flour",
            FoodCategory = FoodCategory.BakeryAndPastry,
            Quantity = 0.5m,
            UnitOfMeasurement = "kg",
            PreparationDate = DateTime.UtcNow.AddHours(-1),
            PickupDeadline = DateTime.UtcNow.AddHours(4),
            PickupAddress = "123 Cairo St",
            StorageConditions = "Room Temp",
            Allergens = "Gluten"
        };

        var result = await service.CreateListingAsync("p-min", dto);

        Assert.False(result.Succeeded);
        Assert.Contains("Minimum donation quantity", result.Error);
    }
}