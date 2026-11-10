using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Infrastructure.BackgroundServices;

public class ListingExpirationHostedService : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<ListingExpirationHostedService> _logger;
    private readonly TimeSpan _checkInterval = TimeSpan.FromMinutes(1);

    public ListingExpirationHostedService(
        IServiceProvider serviceProvider,
        ILogger<ListingExpirationHostedService> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("ListingExpirationHostedService started.");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                using (var scope = _serviceProvider.CreateScope())
                {
                    var listingService = scope.ServiceProvider.GetRequiredService<IFoodListingService>();
                    var expiredCount = await listingService.ProcessExpiredListingsAsync();
                    if (expiredCount > 0)
                    {
                        _logger.LogInformation("Processed and marked {Count} food listings as Expired.", expiredCount);
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred in ListingExpirationHostedService.");
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

        _logger.LogInformation("ListingExpirationHostedService is stopping.");
    }
}