using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using FoodBridge.Domain.Entities;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Infrastructure.Data;

public static class DbInitializer
{
    public static async Task SeedAsync(
        FoodBridgeDbContext context,
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager)
    {
        await context.Database.EnsureCreatedAsync();

        if (context.Database.IsSqlServer())
        {
            await context.Database.ExecuteSqlRawAsync(@"
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SystemSettings')
                BEGIN
                    CREATE TABLE [SystemSettings] (
                        [Key] NVARCHAR(100) NOT NULL PRIMARY KEY,
                        [Value] NVARCHAR(MAX) NOT NULL,
                        [UpdatedAt] DATETIMEOFFSET NOT NULL,
                        [UpdatedBy] NVARCHAR(200) NULL
                    );
                END
            ");
        }

        string[] roles = { "Admin", "Provider", "Charity" };
        foreach (var role in roles)
        {
            if (!await roleManager.RoleExistsAsync(role))
            {
                await roleManager.CreateAsync(new IdentityRole(role));
            }
        }

        var adminEmail = "admin@foodbridge.com";
        var adminUser = await userManager.FindByEmailAsync(adminEmail);
        if (adminUser == null)
        {
            adminUser = new ApplicationUser
            {
                UserName = adminEmail,
                Email = adminEmail,
                EmailConfirmed = true,
                FullName = "Platform Administrator",
                OrganizationName = "FoodBridge Platform Ops",
                OrganizationAddress = "100 Innovation Way, Smart Village, Cairo",
                UserType = UserType.Administrator,
                SpecificType = "Platform Ops",
                IsVerified = true,
                Status = UserStatus.Active,
                CreatedAt = DateTimeOffset.UtcNow.AddMonths(-3)
            };
            await userManager.CreateAsync(adminUser, "Admin@123456");
            await userManager.AddToRoleAsync(adminUser, "Admin");

            context.AuditLogs.Add(new AuditLog
            {
                AdminId = adminUser.Id,
                Action = "SystemProvisioning",
                TargetEntity = "System",
                TargetId = "0",
                Details = "FoodBridge platform database initialized and default administrative account provisioned.",
                Timestamp = DateTimeOffset.UtcNow.AddMonths(-3)
            });
        }

        var provider1Email = "chef.mario@bellaitalia.com";
        var provider1 = await userManager.FindByEmailAsync(provider1Email);
        if (provider1 == null)
        {
            provider1 = new ApplicationUser
            {
                UserName = provider1Email,
                Email = provider1Email,
                EmailConfirmed = true,
                FullName = "Chef Mario Rossi",
                OrganizationName = "Bella Italia Ristorante",
                OrganizationAddress = "42 Nile Corniche, Zamalek, Cairo",
                PhoneNumber = "+20 100 123 4567",
                UserType = UserType.FoodProvider,
                SpecificType = "Restaurant",
                IsVerified = true,
                Status = UserStatus.Active,
                CreatedAt = DateTimeOffset.UtcNow.AddMonths(-2)
            };
            await userManager.CreateAsync(provider1, "Provider@123");
            await userManager.AddToRoleAsync(provider1, "Provider");
        }

        var provider2Email = "sarah@lebreadcraft.com";
        var provider2 = await userManager.FindByEmailAsync(provider2Email);
        if (provider2 == null)
        {
            provider2 = new ApplicationUser
            {
                UserName = provider2Email,
                Email = provider2Email,
                EmailConfirmed = true,
                FullName = "Sarah Jenkins",
                OrganizationName = "Artisan Bread & Pastry Co.",
                OrganizationAddress = "15 El-Horreya St, Heliopolis, Cairo",
                PhoneNumber = "+20 100 765 4321",
                UserType = UserType.FoodProvider,
                SpecificType = "Bakery",
                IsVerified = true,
                Status = UserStatus.Active,
                CreatedAt = DateTimeOffset.UtcNow.AddMonths(-1)
            };
            await userManager.CreateAsync(provider2, "Provider@123");
            await userManager.AddToRoleAsync(provider2, "Provider");
        }

        var provider3Email = "banquets@grandpalace.com";
        var provider3 = await userManager.FindByEmailAsync(provider3Email);
        if (provider3 == null)
        {
            provider3 = new ApplicationUser
            {
                UserName = provider3Email,
                Email = provider3Email,
                EmailConfirmed = true,
                FullName = "Karim Mansour",
                OrganizationName = "Grand Palace Hotel & Banquets",
                OrganizationAddress = "88 Tahrir Square, Cairo",
                PhoneNumber = "+20 102 555 1234",
                UserType = UserType.FoodProvider,
                SpecificType = "Hotel",
                IsVerified = false,
                Status = UserStatus.Active,
                CreatedAt = DateTimeOffset.UtcNow.AddDays(-3)
            };
            await userManager.CreateAsync(provider3, "Provider@123");
            await userManager.AddToRoleAsync(provider3, "Provider");
        }

        var charity1Email = "coordinator@hopefoodbank.org";
        var charity1 = await userManager.FindByEmailAsync(charity1Email);
        if (charity1 == null)
        {
            charity1 = new ApplicationUser
            {
                UserName = charity1Email,
                Email = charity1Email,
                EmailConfirmed = true,
                FullName = "Laila El-Sayed",
                OrganizationName = "Hope Community Food Bank",
                OrganizationAddress = "22 Al-Gomhoria St, Downtown Cairo",
                PhoneNumber = "+20 111 888 9999",
                UserType = UserType.Charity,
                SpecificType = "Food Bank",
                TargetCommunityDescription = "Serving 250+ underprivileged families, low-income daily wage workers, and elderly residents in Old Cairo.",
                IsVerified = true,
                Status = UserStatus.Active,
                CreatedAt = DateTimeOffset.UtcNow.AddMonths(-2)
            };
            await userManager.CreateAsync(charity1, "Charity@123");
            await userManager.AddToRoleAsync(charity1, "Charity");
        }

        var charity2Email = "shelter@stjude-care.org";
        var charity2 = await userManager.FindByEmailAsync(charity2Email);
        if (charity2 == null)
        {
            charity2 = new ApplicationUser
            {
                UserName = charity2Email,
                Email = charity2Email,
                EmailConfirmed = true,
                FullName = "Father Thomas Hanna",
                OrganizationName = "St. Jude Family Shelter",
                OrganizationAddress = "12 Shoubra St, Cairo",
                PhoneNumber = "+20 122 333 4444",
                UserType = UserType.Charity,
                SpecificType = "Shelter",
                TargetCommunityDescription = "Providing emergency housing, daily hot meals, and infant care for homeless families and vulnerable mothers.",
                IsVerified = true,
                Status = UserStatus.Active,
                CreatedAt = DateTimeOffset.UtcNow.AddMonths(-1)
            };
            await userManager.CreateAsync(charity2, "Charity@123");
            await userManager.AddToRoleAsync(charity2, "Charity");
        }

        var charity3Email = "youth@alnoor-foundation.org";
        var charity3 = await userManager.FindByEmailAsync(charity3Email);
        if (charity3 == null)
        {
            charity3 = new ApplicationUser
            {
                UserName = charity3Email,
                Email = charity3Email,
                EmailConfirmed = true,
                FullName = "Tarek Nabil",
                OrganizationName = "Al-Noor Refugee Relief",
                OrganizationAddress = "5 Nasr City, Zone 6, Cairo",
                PhoneNumber = "+20 114 999 0000",
                UserType = UserType.Charity,
                SpecificType = "Community Center",
                TargetCommunityDescription = "Distributing meal packages and dietary aid to displaced families and international students.",
                IsVerified = false,
                Status = UserStatus.Active,
                CreatedAt = DateTimeOffset.UtcNow.AddDays(-2)
            };
            await userManager.CreateAsync(charity3, "Charity@123");
            await userManager.AddToRoleAsync(charity3, "Charity");
        }

        await context.SaveChangesAsync();

        if (!context.FoodListings.Any())
        {
            var now = DateTime.UtcNow;

            var listing1 = new FoodListing
            {
                ProviderId = provider1.Id,
                FoodName = "Fresh Mediterranean Lasagna & Penne Trays",
                Description = "Prepared with Italian beef ragÃ¹, bÃ©chamel, and mozzarella. Freshly cooked at noon in individual catering trays, ready for immediate distribution.",
                FoodCategory = FoodCategory.CookedMeals,
                Quantity = 35,
                UnitOfMeasurement = "portions",
                PreparationDate = now.AddHours(-2),
                PickupDeadline = now.AddHours(10),
                PickupAddress = "42 Nile Corniche, Zamalek, Cairo (Kitchen entrance rear alley)",
                StorageConditions = "Refrigerated (0-4°C) or Keep Warm (>63°C)",
                Allergens = "Gluten, Dairy, Celery",
                ImageUrl = "https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=800&auto=format&fit=crop&q=80",
                Status = FoodListingStatus.Available,
                CreatedAt = DateTimeOffset.UtcNow.AddHours(-2)
            };

            var listing2 = new FoodListing
            {
                ProviderId = provider2.Id,
                FoodName = "Assorted Artisan Sourdough & French Croissants",
                Description = "Daily surplus batch of whole-wheat sourdough loaves, ciabatta, and buttery golden croissants. Baked this morning at 6:00 AM.",
                FoodCategory = FoodCategory.BakeryAndPastry,
                Quantity = 55,
                UnitOfMeasurement = "items",
                PreparationDate = now.AddHours(-6),
                PickupDeadline = now.AddHours(14),
                PickupAddress = "15 El-Horreya St, Heliopolis, Cairo",
                StorageConditions = "Dry & Room Temperature (20-22°C)",
                Allergens = "Gluten, Dairy, Eggs",
                ImageUrl = "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&auto=format&fit=crop&q=80",
                Status = FoodListingStatus.Available,
                CreatedAt = DateTimeOffset.UtcNow.AddHours(-5)
            };

            var listing3 = new FoodListing
            {
                ProviderId = provider1.Id,
                FoodName = "Crispy Garden Salad Bowls & Olive Oil Dressing",
                Description = "Fresh romaine lettuce, cherry tomatoes, cucumbers, black olives, and feta cheese with balsamic dressing on the side.",
                FoodCategory = FoodCategory.FreshProduce,
                Quantity = 25,
                UnitOfMeasurement = "boxes",
                PreparationDate = now.AddHours(-3),
                PickupDeadline = now.AddHours(8),
                PickupAddress = "42 Nile Corniche, Zamalek, Cairo",
                StorageConditions = "Refrigerated (0-4°C)",
                Allergens = "Dairy",
                ImageUrl = "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80",
                Status = FoodListingStatus.Available,
                CreatedAt = DateTimeOffset.UtcNow.AddHours(-3)
            };

            var listing4 = new FoodListing
            {
                ProviderId = provider2.Id,
                FoodName = "Natural Greek Yogurt & Farmer White Cheese",
                Description = "Unopened wholesale cartons of high-protein plain Greek yogurt and unsalted farmer white cheese, optimal for shelters.",
                FoodCategory = FoodCategory.DairyAndEggs,
                Quantity = 40,
                UnitOfMeasurement = "kg",
                PreparationDate = now.AddDays(-1),
                PickupDeadline = now.AddDays(2),
                PickupAddress = "15 El-Horreya St, Heliopolis, Cairo",
                StorageConditions = "Refrigerated (0-4°C)",
                Allergens = "Dairy",
                ImageUrl = "https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800&auto=format&fit=crop&q=80",
                Status = FoodListingStatus.Available,
                CreatedAt = DateTimeOffset.UtcNow.AddHours(-12)
            };

            var listing5 = new FoodListing
            {
                ProviderId = provider1.Id,
                FoodName = "Catering Roast Chicken with Oriental Spiced Rice",
                Description = "Surplus executive banquet buffet: tender roasted whole chickens, seasoned saffron rice, and roasted mixed vegetables.",
                FoodCategory = FoodCategory.CookedMeals,
                Quantity = 60,
                UnitOfMeasurement = "portions",
                PreparationDate = now.AddDays(-5),
                PickupDeadline = now.AddDays(-4),
                PickupAddress = "42 Nile Corniche, Zamalek, Cairo",
                StorageConditions = "Refrigerated (0-4°C)",
                Allergens = "Nuts (Pine nuts in rice garnish)",
                ImageUrl = "https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=800&auto=format&fit=crop&q=80",
                Status = FoodListingStatus.Completed,
                CreatedAt = DateTimeOffset.UtcNow.AddDays(-5)
            };

            context.FoodListings.AddRange(listing1, listing2, listing3, listing4, listing5);
            await context.SaveChangesAsync();

            var completedReservation = new Reservation
            {
                FoodListingId = listing5.Id,
                CharityId = charity1.Id,
                RequestDate = DateTimeOffset.UtcNow.AddDays(-5),
                PickupDateTime = now.AddDays(-4).AddHours(-2),
                ConfirmedLocation = "42 Nile Corniche, Zamalek, Cairo (Loading dock B)",
                Status = ReservationStatus.Completed,
                CompletedAt = DateTimeOffset.UtcNow.AddDays(-4)
            };

            var pendingReservation = new Reservation
            {
                FoodListingId = listing1.Id,
                CharityId = charity2.Id,
                RequestDate = DateTimeOffset.UtcNow.AddMinutes(-30),
                Status = ReservationStatus.Pending
            };

            context.Reservations.AddRange(completedReservation, pendingReservation);
            await context.SaveChangesAsync();

            var reviewFromCharity = new Review
            {
                ReservationId = completedReservation.Id,
                ReviewerId = charity1.Id,
                RevieweeId = provider1.Id,
                Rating = 5,
                Comment = "Exceptional food quality and packaging! The chicken was piping hot and cleanly packed in deep thermal containers. Helped us feed over 50 residents today. Thank you Mario!",
                CreatedAt = DateTimeOffset.UtcNow.AddDays(-4).AddHours(2)
            };

            var reviewFromProvider = new Review
            {
                ReservationId = completedReservation.Id,
                ReviewerId = provider1.Id,
                RevieweeId = charity1.Id,
                Rating = 5,
                Comment = "Hope Food Bank arrived exactly on time with a refrigerated van and sanitary handling gear. Fantastic communication and great partners!",
                CreatedAt = DateTimeOffset.UtcNow.AddDays(-4).AddHours(3)
            };

            context.Reviews.AddRange(reviewFromCharity, reviewFromProvider);

            context.Notifications.AddRange(
                new Notification
                {
                    UserId = provider1.Id,
                    Title = "New Reservation Request",
                    Message = "St. Jude Family Shelter submitted a reservation request for 'Fresh Mediterranean Lasagna & Penne Trays'.",
                    RelatedEntityId = $"reservation:{pendingReservation.Id}",
                    IsRead = false,
                    CreatedAt = DateTimeOffset.UtcNow.AddMinutes(-30)
                },
                new Notification
                {
                    UserId = charity1.Id,
                    Title = "Donation Completed",
                    Message = "Your reservation for 'Catering Roast Chicken with Oriental Spiced Rice' was confirmed completed. Thank you for your partnership!",
                    RelatedEntityId = $"reservation:{completedReservation.Id}",
                    IsRead = true,
                    CreatedAt = DateTimeOffset.UtcNow.AddDays(-4)
                },
                new Notification
                {
                    UserId = adminUser.Id,
                    Title = "New Organizations Awaiting Verification",
                    Message = "Grand Palace Hotel and Al-Noor Refugee Relief have submitted registration credentials for review.",
                    RelatedEntityId = "admin:verifications",
                    IsRead = false,
                    CreatedAt = DateTimeOffset.UtcNow.AddDays(-1)
                }
            );

            await context.SaveChangesAsync();
        }
    }
}