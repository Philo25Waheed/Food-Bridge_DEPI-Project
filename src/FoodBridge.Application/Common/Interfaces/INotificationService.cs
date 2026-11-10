using System.Collections.Generic;
using System.Threading.Tasks;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Common.Interfaces;

public interface INotificationService
{
    Task SendNotificationAsync(string userId, string title, string message, string? relatedEntityId = null);
    Task<List<NotificationDto>> GetUserNotificationsAsync(string userId);
    Task<int> GetUnreadCountAsync(string userId);
    Task<bool> MarkAsReadAsync(int notificationId, string userId);
    Task<bool> MarkAllAsReadAsync(string userId);
}