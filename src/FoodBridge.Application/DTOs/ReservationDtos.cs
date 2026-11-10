using System;
using System.ComponentModel.DataAnnotations;
using FoodBridge.Domain.Enums;

namespace FoodBridge.Application.DTOs;

public class CreateReservationRequestDto
{
    [Required]
    public int FoodListingId { get; set; }
}

public class AcceptReservationDto
{
    [Required]
    public DateTime PickupDateTime { get; set; }

    [Required, StringLength(250)]
    public string ConfirmedLocation { get; set; } = string.Empty;
}

public class RejectReservationDto
{
    [Required, StringLength(500)]
    public string Reason { get; set; } = string.Empty;
}

public class CancelReservationDto
{
    [Required, StringLength(500)]
    public string Reason { get; set; } = string.Empty;
}

public class ReportProblemDto
{
    [Required, StringLength(1000)]
    public string ProblemDescription { get; set; } = string.Empty;
}

public class ReservationDto
{
    public int Id { get; set; }

    public int FoodListingId { get; set; }
    public string FoodName { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public string UnitOfMeasurement { get; set; } = string.Empty;
    public string FoodCategory { get; set; } = string.Empty;
    public string? ListingImageUrl { get; set; }
    public DateTime PickupDeadline { get; set; }

    public string CharityId { get; set; } = string.Empty;
    public string CharityName { get; set; } = string.Empty;
    public string CharityOrganization { get; set; } = string.Empty;
    public string CharityEmail { get; set; } = string.Empty;
    public string CharityPhone { get; set; } = string.Empty;
    public string CharityTargetCommunity { get; set; } = string.Empty;

    public string ProviderId { get; set; } = string.Empty;
    public string ProviderName { get; set; } = string.Empty;
    public string ProviderOrganization { get; set; } = string.Empty;
    public string ProviderEmail { get; set; } = string.Empty;
    public string ProviderPhone { get; set; } = string.Empty;

    public DateTimeOffset RequestDate { get; set; }
    public DateTime? PickupDateTime { get; set; }
    public string? ConfirmedLocation { get; set; }

    public ReservationStatus Status { get; set; }
    public string StatusName => Status.ToString();

    public string? CancellationReason { get; set; }
    public string? ProblemDescription { get; set; }
    public DateTimeOffset? CompletedAt { get; set; }

    public bool HasCharityReviewed { get; set; }
    public bool HasProviderReviewed { get; set; }
    public byte[]? RowVersion { get; set; }
}