using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using FoodBridge.Application.Common.Interfaces;
using FoodBridge.Application.DTOs;
using FoodBridge.Domain.Entities;
using FoodBridge.Infrastructure.Hubs;

namespace FoodBridge.Infrastructure.Services;

public class NotificationService : INotificationService
{
    private readonly IApplicationDbContext _context;
    private readonly IHubContext<NotificationHub> _hubContext;
    private readonly IEmailSenderService? _emailSender;

    public NotificationService(
        IApplicationDbContext context,
        IHubContext<NotificationHub> hubContext) : this(context, hubContext, null)
    {
    }

    public NotificationService(
        IApplicationDbContext context,
        IHubContext<NotificationHub> hubContext,
        IEmailSenderService? emailSender)
    {
        _context = context;
        _hubContext = hubContext;
        _emailSender = emailSender;
    }

    public async Task SendNotificationAsync(string userId, string title, string message, string? relatedEntityId = null)
    {
        var notification = new Notification
        {
            UserId = userId,
            Title = title,
            Message = message,
            RelatedEntityId = relatedEntityId,
            IsRead = false,
            CreatedAt = DateTimeOffset.UtcNow
        };

        _context.Notifications.Add(notification);
        await _context.SaveChangesAsync();

        var dto = new NotificationDto
        {
            Id = notification.Id,
            UserId = notification.UserId,
            Title = notification.Title,
            Message = notification.Message,
            IsRead = notification.IsRead,
            RelatedEntityId = notification.RelatedEntityId,
            CreatedAt = notification.CreatedAt
        };

        await _hubContext.Clients.Group($"user-{userId}").SendAsync("ReceiveNotification", dto);

        if (_emailSender != null)
        {
            try
            {
                var user = await _context.Users.FindAsync(userId);
                if (user?.Email != null)
                {
                    var htmlBody = $"<h3>{title}</h3><p>{message}</p><br><p><small>FoodBridge Platform Notification</small></p>";
                    await _emailSender.SendEmailAsync(user.Email, $"[FoodBridge] {title}", htmlBody);
                }
            }
            catch
            {
            }
        }
    }

    public async Task<List<NotificationDto>> GetUserNotificationsAsync(string userId)
    {
        var list = await _context.Notifications
            .Where(n => n.UserId == userId)
            .OrderByDescending(n => n.CreatedAt)
            .Take(50)
            .AsNoTracking()
            .ToListAsync();

        return list.Select(n => new NotificationDto
        {
            Id = n.Id,
            UserId = n.UserId,
            Title = n.Title,
            Message = n.Message,
            IsRead = n.IsRead,
            RelatedEntityId = n.RelatedEntityId,
            CreatedAt = n.CreatedAt
        }).ToList();
    }

    public async Task<int> GetUnreadCountAsync(string userId)
    {
        return await _context.Notifications
            .CountAsync(n => n.UserId == userId && !n.IsRead);
    }

    public async Task<bool> MarkAsReadAsync(int notificationId, string userId)
    {
        var n = await _context.Notifications
            .FirstOrDefaultAsync(x => x.Id == notificationId && x.UserId == userId);

        if (n == null) return false;

        n.IsRead = true;
        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> MarkAllAsReadAsync(string userId)
    {
        var unread = await _context.Notifications
            .Where(n => n.UserId == userId && !n.IsRead)
            .ToListAsync();

        if (!unread.Any()) return true;

        foreach (var n in unread)
        {
            n.IsRead = true;
        }

        await _context.SaveChangesAsync();
        return true;
    }
}