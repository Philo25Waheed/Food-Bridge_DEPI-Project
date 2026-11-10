using System.Collections.Generic;
using System.Threading.Tasks;
using FoodBridge.Application.Common;
using FoodBridge.Application.DTOs;

namespace FoodBridge.Application.Services.Interfaces;

public interface IReservationService
{
    Task<Result<ReservationDto>> RequestReservationAsync(string charityId, int foodListingId);
    Task<Result<ReservationDto>> AcceptReservationAsync(string providerId, int reservationId, AcceptReservationDto dto);
    Task<Result<ReservationDto>> RejectReservationAsync(string providerId, int reservationId, RejectReservationDto dto);
    Task<Result<ReservationDto>> MarkReadyForPickupAsync(string providerId, int reservationId);
    Task<Result<ReservationDto>> MarkCompletedAsync(string charityId, int reservationId);
    Task<Result<ReservationDto>> CancelReservationAsync(string charityId, int reservationId, CancelReservationDto dto);
    Task<Result<ReservationDto>> ReportPickupProblemAsync(string charityId, int reservationId, ReportProblemDto dto);
    Task<Result<ReservationDto>> GetReservationByIdAsync(int reservationId, string currentUserId);
    Task<List<ReservationDto>> GetIncomingRequestsForProviderAsync(string providerId, string? statusFilter = null);
    Task<List<ReservationDto>> GetCharityReservationsAsync(string charityId, string? statusFilter = null);
    Task<int> ProcessUpcomingPickupRemindersAsync();
}