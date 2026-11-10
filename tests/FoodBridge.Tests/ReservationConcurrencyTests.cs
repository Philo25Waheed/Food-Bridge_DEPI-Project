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

public class ReservationConcurrencyTests
{
    private readonly Mock<INotificationService> _mockNotification = new();

    [Fact]
    public async Task RequestReservation_WhenListingIsAvailable_CreatesPendingReservation()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new ReservationService(db, _mockNotification.Object);

        var charity = new ApplicationUser
        {
            Id = "charity-1",
            Email = "charity1@test.com",
            OrganizationName = "Test Charity",
            UserType = UserType.Charity,
            Status = UserStatus.Active
        };
        var provider = new ApplicationUser
        {
            Id = "provider-1",
            Email = "provider1@test.com",
            OrganizationName = "Test Restaurant",
            UserType = UserType.FoodProvider,
            Status = UserStatus.Active
        };
        var listing = new FoodListing
        {
            Id = 1,
            ProviderId = "provider-1",
            FoodName = "Fresh Pasta",
            Quantity = 20,
            UnitOfMeasurement = "portions",
            PickupDeadline = DateTime.UtcNow.AddDays(1),
            Status = FoodListingStatus.Available
        };

        db.Users.AddRange(charity, provider);
        db.FoodListings.Add(listing);
        await db.SaveChangesAsync();

        var result = await service.RequestReservationAsync("charity-1", 1);

        Assert.True(result.Succeeded);
        Assert.Equal(ReservationStatus.Pending, result.Data!.Status);
        Assert.Equal(1, result.Data.FoodListingId);
    }

    [Fact]
    public async Task AcceptReservation_SetsListingToReserved_AndRejectsOtherPendingRequests()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new ReservationService(db, _mockNotification.Object);

        var provider = new ApplicationUser { Id = "provider-1", OrganizationName = "Provider", UserType = UserType.FoodProvider };
        var charity1 = new ApplicationUser { Id = "charity-1", OrganizationName = "Charity 1", UserType = UserType.Charity };
        var charity2 = new ApplicationUser { Id = "charity-2", OrganizationName = "Charity 2", UserType = UserType.Charity };

        var listing = new FoodListing
        {
            Id = 10,
            ProviderId = "provider-1",
            FoodName = "Soup",
            PickupDeadline = DateTime.UtcNow.AddHours(5),
            Status = FoodListingStatus.Available
        };

        var res1 = new Reservation { Id = 101, FoodListingId = 10, CharityId = "charity-1", Status = ReservationStatus.Pending };
        var res2 = new Reservation { Id = 102, FoodListingId = 10, CharityId = "charity-2", Status = ReservationStatus.Pending };

        db.Users.AddRange(provider, charity1, charity2);
        db.FoodListings.Add(listing);
        db.Reservations.AddRange(res1, res2);
        await db.SaveChangesAsync();

        var acceptDto = new AcceptReservationDto
        {
            PickupDateTime = DateTime.UtcNow.AddHours(2),
            ConfirmedLocation = "Kitchen Door"
        };

        var result = await service.AcceptReservationAsync("provider-1", 101, acceptDto);

        Assert.True(result.Succeeded);
        Assert.Equal(ReservationStatus.Accepted, result.Data!.Status);

        var updatedListing = await db.FoodListings.FindAsync(10);
        Assert.Equal(FoodListingStatus.Reserved, updatedListing!.Status);

        var otherRes = await db.Reservations.FindAsync(102);
        Assert.Equal(ReservationStatus.Rejected, otherRes!.Status);
    }

    [Fact]
    public async Task CancelReservation_WhenAccepted_RevertsListingStatusToAvailable()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new ReservationService(db, _mockNotification.Object);

        var provider = new ApplicationUser { Id = "provider-1", OrganizationName = "Provider" };
        var charity = new ApplicationUser { Id = "charity-1", OrganizationName = "Charity" };

        var listing = new FoodListing
        {
            Id = 20,
            ProviderId = "provider-1",
            FoodName = "Casserole",
            PickupDeadline = DateTime.UtcNow.AddHours(5),
            Status = FoodListingStatus.Reserved
        };

        var reservation = new Reservation
        {
            Id = 201,
            FoodListingId = 20,
            CharityId = "charity-1",
            Status = ReservationStatus.Accepted
        };

        db.Users.AddRange(provider, charity);
        db.FoodListings.Add(listing);
        db.Reservations.Add(reservation);
        await db.SaveChangesAsync();

        var cancelDto = new CancelReservationDto { Reason = "Emergency shelter closure" };
        var result = await service.CancelReservationAsync("charity-1", 201, cancelDto);

        Assert.True(result.Succeeded);
        Assert.Equal(ReservationStatus.Cancelled, result.Data!.Status);

        var updatedListing = await db.FoodListings.FindAsync(20);
        Assert.Equal(FoodListingStatus.Available, updatedListing!.Status);
    }

    [Fact]
    public async Task MarkCompleted_SetsBothReservationAndListingToCompleted()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new ReservationService(db, _mockNotification.Object);

        var provider = new ApplicationUser { Id = "provider-1", OrganizationName = "Provider" };
        var charity = new ApplicationUser { Id = "charity-1", OrganizationName = "Charity" };

        var listing = new FoodListing
        {
            Id = 30,
            ProviderId = "provider-1",
            FoodName = "Sandwiches",
            PickupDeadline = DateTime.UtcNow.AddHours(5),
            Status = FoodListingStatus.Reserved
        };

        var reservation = new Reservation
        {
            Id = 301,
            FoodListingId = 30,
            CharityId = "charity-1",
            Status = ReservationStatus.ReadyForPickup
        };

        db.Users.AddRange(provider, charity);
        db.FoodListings.Add(listing);
        db.Reservations.Add(reservation);
        await db.SaveChangesAsync();

        var result = await service.MarkCompletedAsync("charity-1", reservation.Id);

        Assert.True(result.Succeeded, result.Error ?? "Error was null");
        Assert.Equal(ReservationStatus.Completed, result.Data!.Status);

        var updatedListing = await db.FoodListings.FindAsync(30);
        Assert.Equal(FoodListingStatus.Completed, updatedListing!.Status);
    }

    [Fact]
    public async Task CancelReservation_WhenPickupWithinTwoHours_ReturnsFailureCutoffWindow()
    {
        var db = TestDbContextFactory.Create(Guid.NewGuid().ToString());
        var service = new ReservationService(db, _mockNotification.Object);

        var charity = new ApplicationUser { Id = "charity-cutoff", FullName = "Charity", UserType = UserType.Charity, Status = UserStatus.Active };
        var provider = new ApplicationUser { Id = "provider-cutoff", FullName = "Provider", UserType = UserType.FoodProvider, Status = UserStatus.Active };
        var listing = new FoodListing
        {
            Id = 50,
            ProviderId = "provider-cutoff",
            FoodName = "Hot Meals",
            Quantity = 10,
            PickupDeadline = DateTime.UtcNow.AddHours(5),
            Status = FoodListingStatus.Reserved
        };
        var reservation = new Reservation
        {
            Id = 50,
            FoodListingId = 50,
            CharityId = "charity-cutoff",
            Status = ReservationStatus.Accepted,
            PickupDateTime = DateTime.UtcNow.AddMinutes(45)
        };

        db.Users.AddRange(charity, provider);
        db.FoodListings.Add(listing);
        db.Reservations.Add(reservation);
        await db.SaveChangesAsync();

        var cancelDto = new CancelReservationDto { Reason = "Traffic delay" };
        var result = await service.CancelReservationAsync("charity-cutoff", 50, cancelDto);

        Assert.False(result.Succeeded);
        Assert.Contains("less than 2 hours", result.Error);
    }
}