using System;
using System.Threading.Tasks;
using Xunit;
using FoodBridge.Application.Services.Implementations;
using FoodBridge.Domain.Entities;
using FoodBridge.Domain.Enums;
using FoodBridge.Tests.TestHelpers;

namespace FoodBridge.Tests;

public class ReportingStatisticsTests
{
    [Fact]
    public async Task GetPlatformStats_CalculatesRedistributedQuantityUsingCompletedDonationsOnly()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var reportingService = new ReportingService(db);

        db.FoodListings.Add(new FoodListing
        {
            Id = 1,
            ProviderId = "p1",
            FoodName = "Completed Rice",
            FoodCategory = FoodCategory.CookedMeals,
            Quantity = 50,
            Status = FoodListingStatus.Completed
        });

        db.FoodListings.Add(new FoodListing
        {
            Id = 2,
            ProviderId = "p2",
            FoodName = "Completed Bread",
            FoodCategory = FoodCategory.BakeryAndPastry,
            Quantity = 30,
            Status = FoodListingStatus.Completed
        });

        db.FoodListings.Add(new FoodListing
        {
            Id = 3,
            ProviderId = "p1",
            FoodName = "Expired Soup",
            FoodCategory = FoodCategory.CookedMeals,
            Quantity = 40,
            Status = FoodListingStatus.Expired
        });

        db.FoodListings.Add(new FoodListing
        {
            Id = 4,
            ProviderId = "p1",
            FoodName = "Cancelled Meat",
            FoodCategory = FoodCategory.MeatAndPoultry,
            Quantity = 25,
            Status = FoodListingStatus.Cancelled
        });

        db.FoodListings.Add(new FoodListing
        {
            Id = 5,
            ProviderId = "p2",
            FoodName = "Available Fruit",
            FoodCategory = FoodCategory.FreshProduce,
            Quantity = 15,
            Status = FoodListingStatus.Available
        });

        await db.SaveChangesAsync();

        var stats = await reportingService.GetPlatformStatsAsync();

        Assert.Equal(80m, stats.TotalFoodRedistributedQuantity);
        Assert.Equal(2, stats.TotalCompletedDonations);
        Assert.Equal(1, stats.TotalActiveListings);
    }
}