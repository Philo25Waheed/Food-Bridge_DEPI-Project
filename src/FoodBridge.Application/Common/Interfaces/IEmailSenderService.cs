using System.Threading.Tasks;

namespace FoodBridge.Application.Common.Interfaces;

public interface IEmailSenderService
{
    Task SendEmailAsync(string toEmail, string subject, string htmlMessage);
    Task SendVerificationEmailAsync(string toEmail, string userId, string token);
    Task SendPasswordResetEmailAsync(string toEmail, string token);
}