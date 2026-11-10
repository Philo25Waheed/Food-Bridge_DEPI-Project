namespace FoodBridge.Domain.Enums;

public enum UserType
{
    FoodProvider = 1,
    Charity = 2,
    Administrator = 3
}

public enum UserStatus
{
    Active = 1,
    Suspended = 2
}

public enum FoodCategory
{
    CookedMeals = 1,
    BakeryAndPastry = 2,
    FreshProduce = 3,
    CannedAndPackaged = 4,
    DairyAndEggs = 5,
    Beverages = 6,
    MeatAndPoultry = 7,
    Other = 8
}

public enum FoodListingStatus
{
    Available = 1,
    Reserved = 2,
    Completed = 3,
    Expired = 4,
    Cancelled = 5,
    Unavailable = 6
}

public enum ReservationStatus
{
    Pending = 1,
    Accepted = 2,
    Rejected = 3,
    ReadyForPickup = 4,
    Completed = 5,
    Cancelled = 6,
    ProblemReported = 7
}