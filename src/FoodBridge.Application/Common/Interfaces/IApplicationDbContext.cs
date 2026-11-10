using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using FoodBridge.Domain.Entities;

namespace FoodBridge.Application.Common.Interfaces;

public interface IApplicationDbContext
{
    DbSet<ApplicationUser> Users { get; }
    DbSet<FoodListing> FoodListings { get; }
    DbSet<Reservation> Reservations { get; }
    DbSet<Review> Reviews { get; }
    DbSet<Notification> Notifications { get; }
    DbSet<AuditLog> AuditLogs { get; }
    DbSet<SystemSetting> SystemSettings { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
