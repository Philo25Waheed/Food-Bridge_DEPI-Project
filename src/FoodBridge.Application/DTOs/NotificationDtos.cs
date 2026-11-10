using System;

namespace FoodBridge.Application.DTOs;

public class NotificationDto
{
    public int Id { get; set; }
    public string UserId { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public bool IsRead { get; set; }
    public string? RelatedEntityId { get; set; }
    public DateTimeOffset CreatedAt { get; set; }
}