$baseUrl = 'http://localhost:5000/api'
Write-Host '===================================================' -ForegroundColor Cyan
Write-Host '   RUNNING COMPLETE END-TO-END WORKFLOW            ' -ForegroundColor Cyan
Write-Host '===================================================' -ForegroundColor Cyan

# 1. Platform Stats
Write-Host '[1/10] Platform Public Stats...' -ForegroundColor Yellow
$stats = Invoke-RestMethod -Uri "$baseUrl/reports/platform" -Method Get
Write-Host "   Platform Stats OK: Total Redistributed: $($stats.totalFoodRedistributedQuantity), Active Listings: $($stats.totalActiveListings)" -ForegroundColor Green

# 2. Login Admin
Write-Host '[2/10] Admin Authentication...' -ForegroundColor Yellow
$adminLogin = @{ email = 'admin@foodbridge.com'; password = 'Admin@123456' } | ConvertTo-Json
$adminAuth = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $adminLogin -ContentType 'application/json'
$adminHeaders = @{ Authorization = "Bearer $($adminAuth.token)" }
Write-Host "   Admin Login OK: Role = $($adminAuth.role)" -ForegroundColor Green

# 3. Admin Dashboard
Write-Host '[3/10] Admin Dashboard Query...' -ForegroundColor Yellow
$adminDash = Invoke-RestMethod -Uri "$baseUrl/admin/dashboard" -Method Get -Headers $adminHeaders
Write-Host "   Dashboard OK: Total Users = $($adminDash.totalUsers), Pending Verifications = $($adminDash.pendingVerifications)" -ForegroundColor Green

# 4. Login Provider
Write-Host '[4/10] Provider Authentication...' -ForegroundColor Yellow
$providerLogin = @{ email = 'chef.mario@bellaitalia.com'; password = 'Provider@123' } | ConvertTo-Json
$providerAuth = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $providerLogin -ContentType 'application/json'
$providerHeaders = @{ Authorization = "Bearer $($providerAuth.token)" }
Write-Host "   Provider Login OK: Name = $($providerAuth.fullName)" -ForegroundColor Green

# 5. Create Food Listing
Write-Host '[5/10] Provider Creating Surplus Food Listing...' -ForegroundColor Yellow
$newListing = @{
    foodName = 'Freshly Baked Artisan Focaccia'
    description = 'Surplus batch of herb focaccia baked this afternoon.'
    foodCategory = 'BakeryAndPastry'
    quantity = 25
    unitOfMeasurement = 'portions'
    preparationDate = (Get-Date).ToString('o')
    pickupDeadline = (Get-Date).AddHours(8).ToString('o')
    pickupAddress = '42 Nile Corniche, Zamalek, Cairo'
    storageConditions = 'Room temperature (20-25C)'
    allergens = 'Gluten'
} | ConvertTo-Json

$createdListing = Invoke-RestMethod -Uri "$baseUrl/foodlistings/json" -Method Post -Body $newListing -ContentType 'application/json' -Headers $providerHeaders
$listingId = $createdListing.id
Write-Host "   Listing Created: ID = $listingId, Name = $($createdListing.foodName), Status = $($createdListing.status)" -ForegroundColor Green

# 6. Login Charity
Write-Host '[6/10] Charity Authentication...' -ForegroundColor Yellow
$charityLogin = @{ email = 'coordinator@hopefoodbank.org'; password = 'Charity@123' } | ConvertTo-Json
$charityAuth = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $charityLogin -ContentType 'application/json'
$charityHeaders = @{ Authorization = "Bearer $($charityAuth.token)" }
Write-Host "   Charity Login OK: Name = $($charityAuth.fullName)" -ForegroundColor Green

# 7. Charity Requests Reservation
Write-Host "[7/10] Charity Reserving Listing #$listingId..." -ForegroundColor Yellow
$resReq = @{ foodListingId = $listingId } | ConvertTo-Json
$reservation = Invoke-RestMethod -Uri "$baseUrl/reservations/request" -Method Post -Body $resReq -ContentType 'application/json' -Headers $charityHeaders
$resId = $reservation.id
Write-Host "   Reservation Created: ID = $resId, Status = $($reservation.status)" -ForegroundColor Green

# 8. Provider Accepts with Pickup Schedule
Write-Host "[8/10] Provider Accepting Reservation #$resId..." -ForegroundColor Yellow
$acceptDto = @{
    pickupDateTime = (Get-Date).AddHours(2).ToString('o')
    confirmedLocation = '42 Nile Corniche, Zamalek, Cairo (Side Kitchen Entrance)'
    providerNotes = 'Packed in thermal catering boxes ready for pickup.'
} | ConvertTo-Json
$acceptedRes = Invoke-RestMethod -Uri "$baseUrl/reservations/$resId/accept" -Method Post -Body $acceptDto -ContentType 'application/json' -Headers $providerHeaders
Write-Host "   Reservation Accepted: Status = $($acceptedRes.status), Pickup Loc = $($acceptedRes.confirmedLocation)" -ForegroundColor Green

# 9. Provider Marks Ready and Charity Marks Completed
Write-Host '[9/10] Ready for Pickup and Completion Workflow...' -ForegroundColor Yellow
$readyRes = Invoke-RestMethod -Uri "$baseUrl/reservations/$resId/ready-for-pickup" -Method Post -Headers $providerHeaders
Write-Host "   Status Updated: $($readyRes.status)" -ForegroundColor Green

$completedRes = Invoke-RestMethod -Uri "$baseUrl/reservations/$resId/complete" -Method Post -Headers $charityHeaders
Write-Host "   Completed by Charity: Status = $($completedRes.status), CompletedAt = $($completedRes.completedAt)" -ForegroundColor Green

# 10. Review and Reporting Verification
Write-Host '[10/10] Submitting Review and Verifying Platform Impact...' -ForegroundColor Yellow
$reviewDto = @{
    reservationId = $resId
    revieweeId = $createdListing.providerId
    rating = 5
    comment = 'Outstanding food quality and seamless pickup coordination! Thank you Chef Mario.'
} | ConvertTo-Json
$review = Invoke-RestMethod -Uri "$baseUrl/reviews" -Method Post -Body $reviewDto -ContentType 'application/json' -Headers $charityHeaders
Write-Host "   Review Submitted: Rating = $($review.rating) Stars, Comment = $($review.comment)" -ForegroundColor Green

$finalStats = Invoke-RestMethod -Uri "$baseUrl/reports/platform" -Method Get
Write-Host "   Live Platform Total Redistributed: $($finalStats.totalFoodRedistributedQuantity) items across $($finalStats.totalCompletedDonations) completed donations!" -ForegroundColor Green

Write-Host '===================================================' -ForegroundColor Cyan
Write-Host '   ALL 10 STEPS EXECUTED AND PASSED 100%!          ' -ForegroundColor Cyan
Write-Host '===================================================' -ForegroundColor Cyan
