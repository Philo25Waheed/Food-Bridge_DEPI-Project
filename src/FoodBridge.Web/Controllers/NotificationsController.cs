using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using FoodBridge.Application.Common.Interfaces;

namespace FoodBridge.Web.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class NotificationsController : ControllerBase
{
    private readonly INotificationService _notificationService;
    private readonly ICurrentUserService _currentUserService;

    public NotificationsController(
        INotificationService notificationService,
        ICurrentUserService currentUserService)
    {
        _notificationService = notificationService;
        _currentUserService = currentUserService;
    }

    [HttpGet]
    public async Task<IActionResult> GetNotifications()
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var list = await _notificationService.GetUserNotificationsAsync(userId);
        return Ok(list);
    }

    [HttpGet("unread-count")]
    public async Task<IActionResult> GetUnreadCount()
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var count = await _notificationService.GetUnreadCountAsync(userId);
        return Ok(new { count });
    }

    [HttpPatch("{id}/read")]
    public async Task<IActionResult> MarkAsRead(int id)
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var success = await _notificationService.MarkAsReadAsync(id, userId);
        if (!success) return NotFound();

        return Ok(new { message = "Notification marked as read." });
    }

    [HttpPost("mark-all-read")]
    public async Task<IActionResult> MarkAllAsRead()
    {
        var userId = _currentUserService.UserId;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        await _notificationService.MarkAllAsReadAsync(userId);
        return Ok(new { message = "All notifications marked as read." });
    }
}