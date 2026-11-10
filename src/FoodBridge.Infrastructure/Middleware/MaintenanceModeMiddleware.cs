using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using FoodBridge.Application.Services.Interfaces;

namespace FoodBridge.Infrastructure.Middleware;

public class MaintenanceModeMiddleware
{
    private readonly RequestDelegate _next;

    public MaintenanceModeMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context, IMaintenanceService maintenanceService)
    {
        if (!maintenanceService.IsActive)
        {
            await _next(context);
            return;
        }

        var path = context.Request.Path.Value?.ToLowerInvariant() ?? "";

        // 1. Allow root, HTML, and all static frontend assets so client can load and render the UI
        if (path == "/" || path == "/index.html" ||
            path.EndsWith(".js") || path.EndsWith(".css") || path.EndsWith(".png") ||
            path.EndsWith(".jpg") || path.EndsWith(".jpeg") || path.EndsWith(".svg") ||
            path.EndsWith(".ico") || path.EndsWith(".woff") || path.EndsWith(".woff2") ||
            path.EndsWith(".map") || path.EndsWith(".json") && !path.StartsWith("/api"))
        {
            await _next(context);
            return;
        }

        // 2. Allow SignalR hubs so real-time push and reconnection work
        if (path.StartsWith("/hubs/"))
        {
            await _next(context);
            return;
        }

        // 3. Allow maintenance status inquiry and admin login
        if (path == "/api/admin/maintenance/status" ||
            path == "/api/auth/login")
        {
            await _next(context);
            return;
        }

        // 4. Allow authenticated Admins to access anything
        if (context.User.Identity?.IsAuthenticated == true && context.User.IsInRole("Admin"))
        {
            await _next(context);
            return;
        }

        // 5. Allow any /api/admin/ endpoints so an admin with Bearer token can operate
        if (path.StartsWith("/api/admin/"))
        {
            await _next(context);
            return;
        }

        // 6. Block all other API requests with HTTP 503 Service Unavailable
        if (path.StartsWith("/api/"))
        {
            context.Response.StatusCode = StatusCodes.Status503ServiceUnavailable;
            context.Response.ContentType = "application/json; charset=utf-8";

            var status = maintenanceService.GetCurrentStatus();
            var response = new
            {
                isMaintenance = true,
                statusCode = 503,
                title = "Platform Under Maintenance",
                titleAr = "المنصة في وضع الصيانة والتحديثات",
                message = string.IsNullOrWhiteSpace(status.Reason)
                    ? "FoodBridge is temporarily offline for scheduled system upgrades. Regular operations will resume shortly."
                    : status.Reason,
                messageAr = string.IsNullOrWhiteSpace(status.ReasonAr)
                    ? "منصة FoodBridge متوقفة مؤقتاً لأعمال الصيانة والتحديثات المجدولة. ستستأنف كافة العمليات قريباً."
                    : status.ReasonAr,
                estimatedDuration = status.EstimatedDuration ?? "Short duration",
                activatedAt = status.ActivatedAt
            };

            await context.Response.WriteAsync(JsonSerializer.Serialize(response));
            return;
        }

        await _next(context);
    }
}
