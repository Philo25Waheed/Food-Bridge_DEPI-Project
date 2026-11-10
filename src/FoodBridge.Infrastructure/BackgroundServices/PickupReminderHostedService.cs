using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Infrastructure.BackgroundServices;

public class PickupReminderHostedService : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<PickupReminderHostedService> _logger;
    private readonly TimeSpan _checkInterval = TimeSpan.FromMinutes(2);

    public PickupReminderHostedService(
        IServiceProvider serviceProvider,
        ILogger<PickupReminderHostedService> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("PickupReminderHostedService started.");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                using (var scope = _serviceProvider.CreateScope())
                {
                    var reservationService = scope.ServiceProvider.GetRequiredService<IReservationService>();
                    var remindedCount = await reservationService.ProcessUpcomingPickupRemindersAsync();
                    if (remindedCount > 0)
                    {
                        _logger.LogInformation("Sent upcoming pickup reminders for {Count} reservations.", remindedCount);
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred in PickupReminderHostedService.");
            }

            try
            {
                await Task.Delay(_checkInterval, stoppingToken);
            }
            catch (OperationCanceledException)
            {
                break;
            }
        }

        _logger.LogInformation("PickupReminderHostedService is stopping.");
    }
}