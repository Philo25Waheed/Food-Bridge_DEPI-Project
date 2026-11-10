using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using FoodBridge.Application.Common.Interfaces;

namespace FoodBridge.Infrastructure.Services;

public class EmailLogRecord
{
    public DateTime SentAt { get; set; } = DateTime.UtcNow;
    public string ToEmail { get; set; } = string.Empty;
    public string Subject { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public string? Token { get; set; }
}

public class EmailSenderService : IEmailSenderService
{
    private readonly ILogger<EmailSenderService> _logger;
    public static readonly ConcurrentBag<EmailLogRecord> RecentEmails = new();

    public EmailSenderService(ILogger<EmailSenderService> logger)
    {
        _logger = logger;
    }

    public Task SendEmailAsync(string toEmail, string subject, string htmlMessage)
    {
        _logger.LogInformation("================ EMAIL DISPATCHED ================");
        _logger.LogInformation("To: {ToEmail}", toEmail);
        _logger.LogInformation("Subject: {Subject}", subject);
        _logger.LogInformation("Message: {Message}", htmlMessage);
        _logger.LogInformation("==================================================");

        RecentEmails.Add(new EmailLogRecord
        {
            ToEmail = toEmail,
            Subject = subject,
            Message = htmlMessage
        });

        return Task.CompletedTask;
    }

    public Task SendVerificationEmailAsync(string toEmail, string userId, string token)
    {
        var encodedToken = UrlEncoder.Default.Encode(token);
        var verificationUrl = $"/verify-email?userId={userId}&token={encodedToken}";
        var body = $@"<h3>Welcome to FoodBridge!</h3>
<p>Thank you for registering your organization. Please verify your email to unlock all donation features.</p>
<p>Your verification token is: <code>{token}</code></p>
<p><a href='{verificationUrl}'>Click here to verify your account</a></p>";

        _logger.LogInformation("[VERIFICATION TOKEN] User: {UserId}, Email: {ToEmail}, Token: {Token}", userId, toEmail, token);

        RecentEmails.Add(new EmailLogRecord
        {
            ToEmail = toEmail,
            Subject = "Verify Your FoodBridge Account",
            Message = body,
            Token = token
        });

        return Task.CompletedTask;
    }

    public Task SendPasswordResetEmailAsync(string toEmail, string token)
    {
        var encodedToken = UrlEncoder.Default.Encode(token);
        var resetUrl = $"/reset-password?email={toEmail}&token={encodedToken}";
        var body = $@"<h3>Password Reset Request</h3>
<p>We received a request to reset your FoodBridge account password.</p>
<p>Your reset token is: <code>{token}</code></p>
<p><a href='{resetUrl}'>Click here to reset your password</a></p>";

        _logger.LogInformation("[PASSWORD RESET TOKEN] Email: {ToEmail}, Token: {Token}", toEmail, token);

        RecentEmails.Add(new EmailLogRecord
        {
            ToEmail = toEmail,
            Subject = "Reset Your FoodBridge Password",
            Message = body,
            Token = token
        });

        return Task.CompletedTask;
    }
}