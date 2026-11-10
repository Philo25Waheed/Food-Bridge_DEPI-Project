using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Domain.Entities;

namespace FoodBridge.Infrastructure.Data;

public class FoodBridgeDbContext : IdentityDbContext<ApplicationUser, IdentityRole, string>, IApplicationDbContext
{
    public FoodBridgeDbContext(DbContextOptions<FoodBridgeDbContext> options) : base(options)
    {
    }

    public DbSet<FoodListing> FoodListings => Set<FoodListing>();
    public DbSet<Reservation> Reservations => Set<Reservation>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();
    public DbSet<SystemSetting> SystemSettings => Set<SystemSetting>();

    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        return base.SaveChangesAsync(cancellationToken);
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<ApplicationUser>(entity =>
        {
            entity.Property(u => u.FullName).HasMaxLength(150).IsRequired();
            entity.Property(u => u.OrganizationName).HasMaxLength(200).IsRequired();
            entity.Property(u => u.OrganizationAddress).HasMaxLength(300).IsRequired();
            entity.Property(u => u.SpecificType).HasMaxLength(100);
            entity.Property(u => u.TargetCommunityDescription).HasMaxLength(1000);
        });

        builder.Entity<FoodListing>(entity =>
        {
            entity.ToTable("FoodListings");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.FoodName).HasMaxLength(150).IsRequired();
            entity.Property(e => e.Description).HasMaxLength(1000).IsRequired();
            entity.Property(e => e.Quantity).HasPrecision(18, 2);
            entity.Property(e => e.UnitOfMeasurement).HasMaxLength(50).IsRequired();
            entity.Property(e => e.PickupAddress).HasMaxLength(250).IsRequired();
            entity.Property(e => e.StorageConditions).HasMaxLength(200).IsRequired();
            entity.Property(e => e.Allergens).HasMaxLength(250).IsRequired();
            entity.Property(e => e.ImageUrl).HasMaxLength(500);

            entity.Property(e => e.RowVersion).IsRowVersion();

            entity.HasIndex(e => e.Status);
            entity.HasIndex(e => e.FoodCategory);
            entity.HasIndex(e => e.PickupDeadline);

            entity.HasOne(e => e.Provider)
                  .WithMany(u => u.FoodListings)
                  .HasForeignKey(e => e.ProviderId)
                  .OnDelete(DeleteBehavior.Restrict);
        });

        builder.Entity<Reservation>(entity =>
        {
            entity.ToTable("Reservations");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.ConfirmedLocation).HasMaxLength(250);
            entity.Property(e => e.CancellationReason).HasMaxLength(500);
            entity.Property(e => e.ProblemDescription).HasMaxLength(1000);

            entity.Property(e => e.RowVersion).IsRowVersion();

            entity.HasIndex(e => e.Status);
            entity.HasIndex(e => e.FoodListingId);
            entity.HasIndex(e => e.CharityId);

            entity.HasOne(e => e.FoodListing)
                  .WithMany(l => l.Reservations)
                  .HasForeignKey(e => e.FoodListingId)
                  .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.Charity)
                  .WithMany(u => u.Reservations)
                  .HasForeignKey(e => e.CharityId)
                  .OnDelete(DeleteBehavior.Restrict);
        });

        builder.Entity<Review>(entity =>
        {
            entity.ToTable("Reviews");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Comment).HasMaxLength(1000);
            entity.Property(e => e.ReportReason).HasMaxLength(500);

            entity.HasIndex(e => new { e.ReservationId, e.ReviewerId }).IsUnique();

            entity.HasOne(e => e.Reservation)
                  .WithMany(r => r.Reviews)
                  .HasForeignKey(e => e.ReservationId)
                  .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(e => e.Reviewer)
                  .WithMany(u => u.ReviewsGiven)
                  .HasForeignKey(e => e.ReviewerId)
                  .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(e => e.Reviewee)
                  .WithMany(u => u.ReviewsReceived)
                  .HasForeignKey(e => e.RevieweeId)
                  .OnDelete(DeleteBehavior.Restrict);
        });

        builder.Entity<Notification>(entity =>
        {
            entity.ToTable("Notifications");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Title).HasMaxLength(200).IsRequired();
            entity.Property(e => e.Message).HasMaxLength(1000).IsRequired();
            entity.Property(e => e.RelatedEntityId).HasMaxLength(100);

            entity.HasIndex(e => new { e.UserId, e.IsRead });

            entity.HasOne(e => e.User)
                  .WithMany(u => u.Notifications)
                  .HasForeignKey(e => e.UserId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        builder.Entity<AuditLog>(entity =>
        {
            entity.ToTable("AuditLogs");
            entity.HasKey(e => e.Id);

            entity.Property(e => e.Action).HasMaxLength(100).IsRequired();
            entity.Property(e => e.TargetEntity).HasMaxLength(100).IsRequired();
            entity.Property(e => e.TargetId).HasMaxLength(100).IsRequired();
            entity.Property(e => e.Details).HasMaxLength(2000).IsRequired();

            entity.HasIndex(e => e.Timestamp);

            entity.HasOne(e => e.Admin)
                  .WithMany(u => u.AuditLogs)
                  .HasForeignKey(e => e.AdminId)
                  .OnDelete(DeleteBehavior.Restrict);
        });

        builder.Entity<SystemSetting>(entity =>
        {
            entity.ToTable("SystemSettings");
            entity.HasKey(e => e.Key);
            entity.Property(e => e.Key).HasMaxLength(100);
            entity.Property(e => e.Value).HasMaxLength(4000);
        });
    }
}