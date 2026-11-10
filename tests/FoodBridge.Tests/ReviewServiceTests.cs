using System;
using System.Threading.Tasks;
using Moq;
using Xunit;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Application.Services.Implementations;
using FoodBridge.Domain.Entities;
using FoodBridge.Domain.Enums;
using FoodBridge.Tests.TestHelpers;

namespace FoodBridge.Tests;

public class ReviewServiceTests
{
    private readonly Mock<INotificationService> _mockNotification = new();

    [Fact]
    public async Task SubmitReview_WhenReservationNotCompleted_ReturnsFailure()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new ReviewService(db, _mockNotification.Object);

        var reservation = new Reservation
        {
            Id = 1,
            CharityId = "c1",
            Status = ReservationStatus.Accepted,
            FoodListing = new FoodListing { Id = 1, ProviderId = "p1" }
        };
        db.Reservations.Add(reservation);
        await db.SaveChangesAsync();

        var dto = new CreateReviewDto { ReservationId = 1, Rating = 5, Comment = "Good" };
        var result = await service.SubmitReviewAsync("c1", dto);

        Assert.False(result.Succeeded);
        Assert.Contains("completed", result.Error, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task SubmitReview_WhenCompleted_SucceedsAndDisallowsDuplicate()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new ReviewService(db, _mockNotification.Object);

        var charity = new ApplicationUser { Id = "c1", FullName = "Charity User", OrganizationName = "Charity Org" };
        var provider = new ApplicationUser { Id = "p1", FullName = "Provider User", OrganizationName = "Provider Org" };

        var reservation = new Reservation
        {
            Id = 2,
            CharityId = "c1",
            Status = ReservationStatus.Completed,
            FoodListing = new FoodListing { Id = 2, ProviderId = "p1" }
        };

        db.Users.AddRange(charity, provider);
        db.Reservations.Add(reservation);
        await db.SaveChangesAsync();

        var dto = new CreateReviewDto { ReservationId = 2, Rating = 5, Comment = "Excellent distribution!" };
        var firstResult = await service.SubmitReviewAsync("c1", dto);

        Assert.True(firstResult.Succeeded);
        Assert.Equal(5, firstResult.Data!.Rating);

        var secondResult = await service.SubmitReviewAsync("c1", dto);

        Assert.False(secondResult.Succeeded);
        Assert.Contains("already submitted", secondResult.Error, StringComparison.OrdinalIgnoreCase);
    }
}