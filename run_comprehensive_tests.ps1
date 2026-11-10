# Comprehensive End-to-End Test Suite for FoodBridge Platform
$ErrorActionPreference = 'Stop'
$baseUrl = 'http://localhost:5000/api'
$rootUrl = 'http://localhost:5000'

$passed = 0
$failed = 0
$totalTests = 0

function Run-Test {
    param(
        [string]$Name,
        [scriptblock]$Action
    )
    $script:totalTests++
    Write-Host -NoNewline "[TEST $script:totalTests] $Name ... "
    try {
        & $Action
        Write-Host "PASSED" -ForegroundColor Green
        $script:passed++
    }
    catch {
        Write-Host "FAILED" -ForegroundColor Red
        Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor DarkRed
        $script:failed++
    }
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   FOODBRIDGE PLATFORM — COMPREHENSIVE INTEGRATION TEST   " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Base API: $baseUrl"
Write-Host ""

# ========================================================
# 1. PUBLIC ENDPOINTS & METADATA
# ========================================================
Write-Host "--- GROUP 1: Public Endpoints & Metadata ---" -ForegroundColor Yellow

Run-Test "Landing Page (HTTP GET /)" {
    $res = Invoke-WebRequest -Uri "$rootUrl" -UseBasicParsing
    if ($res.StatusCode -ne 200) { throw "Status was $($res.StatusCode)" }
    if ($res.Content -notmatch "FoodBridge") { throw "Page content does not contain 'FoodBridge'" }
}

Run-Test "OpenAPI / Swagger Spec (/swagger/v1/swagger.json)" {
    $spec = Invoke-RestMethod -Uri "$rootUrl/swagger/v1/swagger.json" -Method Get
    if ($spec.openapi -notmatch "3\." -and $spec.swagger -notmatch "2\.") { throw "Invalid OpenAPI spec" }
    if ($spec.info.title -notmatch "FoodBridge") { throw "Spec title mismatch: $($spec.info.title)" }
}

Run-Test "Platform Public Stats (/api/reports/platform)" {
    $stats = Invoke-RestMethod -Uri "$baseUrl/reports/platform" -Method Get
    if ($null -eq $stats.totalFoodRedistributedQuantity) { throw "Missing totalFoodRedistributedQuantity" }
}

Run-Test "Maintenance Status Public Query (/api/admin/maintenance/status)" {
    $maint = Invoke-RestMethod -Uri "$baseUrl/admin/maintenance/status" -Method Get
    if ($null -eq $maint.isMaintenanceActive) { throw "Missing isMaintenanceActive flag" }
}

Run-Test "Recent Dispatched Emails Query (/api/auth/recent-emails)" {
    $emails = Invoke-RestMethod -Uri "$baseUrl/auth/recent-emails" -Method Get
    if ($null -eq $emails) { throw "Emails returned null" }
}

# ========================================================
# 2. AUTHENTICATION & AUTHORIZATION
# ========================================================
Write-Host "`n--- GROUP 2: Authentication & Role Enforcement ---" -ForegroundColor Yellow

$adminToken = $null
$providerToken = $null
$charityToken = $null

Run-Test "Admin Login (admin@foodbridge.com)" {
    $body = @{ email = 'admin@foodbridge.com'; password = 'Admin@123456' } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $body -ContentType 'application/json'
    if ($res.role -ne 'Admin') { throw "Role was $($res.role), expected Admin" }
    if ([string]::IsNullOrEmpty($res.token)) { throw "Token is empty" }
    $script:adminToken = $res.token
}

Run-Test "Provider Login (chef.mario@bellaitalia.com)" {
    $body = @{ email = 'chef.mario@bellaitalia.com'; password = 'Provider@123' } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $body -ContentType 'application/json'
    if ($res.role -ne 'Provider') { throw "Role was $($res.role), expected Provider" }
    if ([string]::IsNullOrEmpty($res.token)) { throw "Token is empty" }
    $script:providerToken = $res.token
}

Run-Test "Charity Login (coordinator@hopefoodbank.org)" {
    $body = @{ email = 'coordinator@hopefoodbank.org'; password = 'Charity@123' } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $body -ContentType 'application/json'
    if ($res.role -ne 'Charity') { throw "Role was $($res.role), expected Charity" }
    if ([string]::IsNullOrEmpty($res.token)) { throw "Token is empty" }
    $script:charityToken = $res.token
}

Run-Test "Invalid Credentials Rejection (401 Unauthorized)" {
    $body = @{ email = 'admin@foodbridge.com'; password = 'WrongPassword!' } | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $body -ContentType 'application/json'
        throw "Login succeeded unexpectedly!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 401) { throw "Expected status 401, got $status" }
    }
}

Run-Test "Protected Endpoint without Token (401 Unauthorized)" {
    try {
        Invoke-RestMethod -Uri "$baseUrl/admin/dashboard" -Method Get
        throw "Access succeeded without token!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 401) { throw "Expected status 401, got $status" }
    }
}

Run-Test "Role Enforcement: Charity Denied Admin Dashboard (403 Forbidden)" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    try {
        Invoke-RestMethod -Uri "$baseUrl/admin/dashboard" -Method Get -Headers $headers
        throw "Charity accessed admin dashboard unexpectedly!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 403) { throw "Expected status 403, got $status" }
    }
}

Run-Test "Role Enforcement: Charity Denied Listing Creation (403 Forbidden)" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $body = @{ foodName = 'Unauthorized food'; quantity = 5 } | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri "$baseUrl/foodlistings/json" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
        throw "Charity created food listing unexpectedly!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 403) { throw "Expected status 403, got $status" }
    }
}

# ========================================================
# 3. USER REGISTRATION & ADMIN MODERATION WORKFLOW
# ========================================================
Write-Host "`n--- GROUP 3: Registration & Admin Verification Lifecycle ---" -ForegroundColor Yellow

$uniqueId = [System.Environment]::TickCount
$newProviderEmail = "prov.test.$uniqueId@foodbridge-test.org"
$newCharityEmail = "char.test.$uniqueId@foodbridge-test.org"
$newProviderId = $null
$newCharityId = $null

Run-Test "Register New Food Provider ($newProviderEmail)" {
    $body = @{
        fullName = 'Tarek Al-Masry'
        email = $newProviderEmail
        password = 'Password@123'
        organizationName = 'Al-Masry Bakery & Cafe'
        organizationAddress = '15 Abbasia St, Cairo'
        specificType = 'Bakery'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/auth/register-provider" -Method Post -Body $body -ContentType 'application/json'
    if ([string]::IsNullOrEmpty($res.token)) { throw "Registration did not return auth token" }
    if ($res.isVerified -ne $false) { throw "New provider should be unverified by default" }
    $script:newProviderId = $res.userId
}

Run-Test "Register New Charity Organization ($newCharityEmail)" {
    $body = @{
        fullName = 'Mona Mahmoud'
        email = $newCharityEmail
        password = 'Password@123'
        organizationName = 'Nour El-Amal Shelter'
        organizationAddress = '88 Ramses Sq, Cairo'
        specificType = 'Shelter'
        targetCommunityDescription = 'Providing temporary shelter and warm meals to vulnerable families.'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/auth/register-charity" -Method Post -Body $body -ContentType 'application/json'
    if ([string]::IsNullOrEmpty($res.token)) { throw "Registration did not return auth token" }
    if ($res.isVerified -ne $false) { throw "New charity should be unverified by default" }
    $script:newCharityId = $res.userId
}

Run-Test "Admin Query Pending Unverified Users" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $users = Invoke-RestMethod -Uri "$baseUrl/admin/users?isVerified=false" -Method Get -Headers $headers
    $match = $users | Where-Object { $_.id -eq $script:newProviderId }
    if ($null -eq $match) { throw "Newly registered provider not found in unverified list" }
}

Run-Test "Admin Approves New Provider Verification" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/admin/users/$($script:newProviderId)/verify?approve=true" -Method Post -Headers $headers
    if ($res.message -notmatch "verified") { throw "Unexpected response: $($res.message)" }
}

Run-Test "Admin Rejects New Charity (Transitions to Suspended)" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/admin/users/$($script:newCharityId)/verify?approve=false" -Method Post -Headers $headers
    if ($res.message -notmatch "rejected") { throw "Unexpected response: $($res.message)" }
}

Run-Test "Rejected User Login Rejection (403 Forbidden with Suspended Notice)" {
    $body = @{ email = $newCharityEmail; password = 'Password@123' } | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $body -ContentType 'application/json'
        throw "Rejected/suspended user logged in unexpectedly!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 403) { throw "Expected status 403 Forbidden, got $status" }
    }
}

Run-Test "Admin Reactivates User Account" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/admin/users/$($script:newCharityId)/status?suspend=false" -Method Post -Headers $headers
    if ($res.message -notmatch "reactivated") { throw "Unexpected response: $($res.message)" }
}

# ========================================================
# 4. PROFILE MANAGEMENT
# ========================================================
Write-Host "`n--- GROUP 4: Profile Management ---" -ForegroundColor Yellow

Run-Test "Fetch Current User Profile" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $prof = Invoke-RestMethod -Uri "$baseUrl/auth/profile" -Method Get -Headers $headers
    if ($prof.email -ne 'chef.mario@bellaitalia.com') { throw "Profile email mismatch: $($prof.email)" }
}

Run-Test "Update Current User Profile" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $body = @{
        fullName = 'Chef Mario Rossi'
        organizationName = 'Bella Italia Ristorante'
        organizationAddress = '42 Nile Corniche, Zamalek, Cairo (Updated Suite)'
        specificType = 'Restaurant'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/auth/profile" -Method Put -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.organizationAddress -ne '42 Nile Corniche, Zamalek, Cairo (Updated Suite)') { throw "Address update failed" }
}

# ========================================================
# 5. FOOD LISTING CREATION & DISCOVERY
# ========================================================
Write-Host "`n--- GROUP 5: Food Listing Lifecycle ---" -ForegroundColor Yellow

$testListingId = $null

Run-Test "Provider Creates Food Listing (Egyptian Mixed Grill & Rice)" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $body = @{
        foodName = "Egyptian Mixed Grill & Basmati Rice ($uniqueId)"
        description = 'Premium fresh grilled meats, kofta, and rice prepared for private banquet.'
        foodCategory = 'CookedMeals'
        quantity = 40
        unitOfMeasurement = 'portions'
        preparationDate = (Get-Date).ToString('o')
        pickupDeadline = (Get-Date).AddHours(6).ToString('o')
        pickupAddress = '42 Nile Corniche, Zamalek, Cairo'
        storageConditions = 'Thermal insulated hot-boxes'
        allergens = 'None'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/foodlistings/json" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.status -ne 'Available') { throw "Listing status was $($res.status), expected Available" }
    $script:testListingId = $res.id
}

Run-Test "Provider Fetches Their Own Listings" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $listings = Invoke-RestMethod -Uri "$baseUrl/foodlistings/provider/my-listings" -Method Get -Headers $headers
    $match = $listings | Where-Object { $_.id -eq $script:testListingId }
    if ($null -eq $match) { throw "Created listing not found in provider's inventory" }
}

Run-Test "Charity Discovers Listing (Search & Filters)" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $paged = Invoke-RestMethod -Uri "$baseUrl/foodlistings?searchTerm=Grill" -Method Get -Headers $headers
    $match = $paged.items | Where-Object { $_.id -eq $script:testListingId }
    if ($null -eq $match) { throw "Listing not found in paged search results" }
}

Run-Test "Get Listing By ID" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/foodlistings/$($script:testListingId)" -Method Get -Headers $headers
    if ($res.id -ne $script:testListingId) { throw "Listing ID mismatch" }
    if ($res.quantity -ne 40) { throw "Quantity mismatch" }
}

Run-Test "Provider Updates Listing Details" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $body = @{
        foodName = "Egyptian Mixed Grill & Basmati Rice ($uniqueId) [Updated]"
        description = 'Premium fresh grilled meats, kofta, and fragrant spiced rice.'
        foodCategory = 'CookedMeals'
        quantity = 35
        unitOfMeasurement = 'portions'
        preparationDate = (Get-Date).ToString('o')
        pickupDeadline = (Get-Date).AddHours(7).ToString('o')
        pickupAddress = '42 Nile Corniche, Zamalek, Cairo'
        storageConditions = 'Thermal insulated hot-boxes'
        allergens = 'None'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/foodlistings/$($script:testListingId)" -Method Put -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.quantity -ne 35) { throw "Quantity update failed" }
}

# ========================================================
# 6. RESERVATION, CANCELLATION & SELF-HEALING LIFECYCLE
# ========================================================
Write-Host "`n--- GROUP 6: Reservation Lifecycle & Self-Healing ---" -ForegroundColor Yellow

$tempReservationId = $null

Run-Test "Charity Requests Reservation #1" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $body = @{ foodListingId = $script:testListingId } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/reservations/request" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.status -ne 'Pending') { throw "Reservation status was $($res.status), expected Pending" }
    $script:tempReservationId = $res.id
}

Run-Test "Listing Stays Available While Reservation is Pending" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/foodlistings/$($script:testListingId)" -Method Get -Headers $headers
    if ($res.status -ne 'Available') { throw "Listing status was $($res.status), expected Available while pending" }
}

Run-Test "Charity Cancels Reservation #1" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $body = @{ reason = 'Driver route conflict - releasing listing for other charities' } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/reservations/$($script:tempReservationId)/cancel" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.status -ne 'Cancelled') { throw "Status was $($res.status), expected Cancelled" }
}

Run-Test "Verify Listing Stays/Self-Heals to Available" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/foodlistings/$($script:testListingId)" -Method Get -Headers $headers
    if ($res.status -ne 'Available') { throw "Status was $($res.status), expected Available" }
}

$activeReservationId = $null

Run-Test "Charity Re-Requests Reservation #2" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $body = @{ foodListingId = $script:testListingId } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/reservations/request" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.status -ne 'Pending') { throw "Status was $($res.status), expected Pending" }
    $script:activeReservationId = $res.id
}

Run-Test "Provider Accepts Reservation with Pickup Schedule" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $body = @{
        pickupDateTime = (Get-Date).AddHours(2).ToString('o')
        confirmedLocation = '42 Nile Corniche, Kitchen Delivery Bay 3'
        providerNotes = 'Boxes packed and sealed.'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/reservations/$($script:activeReservationId)/accept" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.status -ne 'Accepted') { throw "Status was $($res.status), expected Accepted" }
}

Run-Test "Verify Listing Transitions to Reserved After Acceptance" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/foodlistings/$($script:testListingId)" -Method Get -Headers $headers
    if ($res.status -ne 'Reserved') { throw "Listing status was $($res.status), expected Reserved after acceptance" }
}

Run-Test "Provider Marks Reservation Ready For Pickup" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/reservations/$($script:activeReservationId)/ready-for-pickup" -Method Post -Headers $headers
    if ($res.status -ne 'ReadyForPickup') { throw "Status was $($res.status), expected ReadyForPickup" }
}

Run-Test "Charity Marks Reservation Completed" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/reservations/$($script:activeReservationId)/complete" -Method Post -Headers $headers
    if ($res.status -ne 'Completed') { throw "Status was $($res.status), expected Completed" }
    if ($null -eq $res.completedAt) { throw "CompletedAt timestamp missing" }
}

# ========================================================
# 7. CONCURRENCY & RACE-CONDITION PROTECTION
# ========================================================
Write-Host "`n--- GROUP 7: Concurrency & Duplicate Request Protection ---" -ForegroundColor Yellow

Run-Test "Double Reservation Prevention (Attempt to reserve completed listing)" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $body = @{ foodListingId = $script:testListingId } | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri "$baseUrl/reservations/request" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
        throw "Reservation succeeded on non-available listing!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 400) { throw "Expected status 400 Bad Request, got $status" }
    }
}

# ========================================================
# 8. MUTUAL REVIEW SYSTEM & CONSTRAINT VERIFICATION
# ========================================================
Write-Host "`n--- GROUP 8: Mutual Review System & Anti-Abuse ---" -ForegroundColor Yellow

$providerUserId = $null
Run-Test "Charity Submits Review for Provider (5 Stars)" {
    $listing = Invoke-RestMethod -Uri "$baseUrl/foodlistings/$($script:testListingId)" -Method Get -Headers @{ Authorization = "Bearer $script:charityToken" }
    $script:providerUserId = $listing.providerId
    
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $body = @{
        reservationId = $script:activeReservationId
        revieweeId = $script:providerUserId
        rating = 5
        comment = 'Flawless communication, outstanding meals, and very polite team.'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/reviews" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.rating -ne 5) { throw "Rating mismatch: $($res.rating)" }
}

Run-Test "Duplicate Review Prevention (Charity attempts second review on same reservation)" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $body = @{
        reservationId = $script:activeReservationId
        revieweeId = $script:providerUserId
        rating = 4
        comment = 'Trying duplicate review.'
    } | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri "$baseUrl/reviews" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
        throw "Duplicate review was accepted unexpectedly!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 400) { throw "Expected status 400 Bad Request, got $status" }
    }
}

Run-Test "Provider Submits Mutual Review for Charity (5 Stars)" {
    $resDetails = Invoke-RestMethod -Uri "$baseUrl/reservations/$($script:activeReservationId)" -Method Get -Headers @{ Authorization = "Bearer $script:providerToken" }
    $charityUserId = $resDetails.charityId

    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $body = @{
        reservationId = $script:activeReservationId
        revieweeId = $charityUserId
        rating = 5
        comment = 'On-time pickup with dedicated insulated delivery van. Excellent charity!'
    } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/reviews" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.rating -ne 5) { throw "Rating mismatch: $($res.rating)" }
}

Run-Test "Fetch Provider Reviews Publicly" {
    $res = Invoke-RestMethod -Uri "$baseUrl/reviews/provider/$($script:providerUserId)" -Method Get
    if ($null -eq $res.reviews -or $res.reviews.Count -lt 1) { throw "No reviews returned in ProviderReviewsSummary" }
}

# ========================================================
# 9. NOTIFICATIONS SUBSYSTEM
# ========================================================
Write-Host "`n--- GROUP 9: Notifications Subsystem ---" -ForegroundColor Yellow

Run-Test "Provider Fetches Notifications" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $notifs = Invoke-RestMethod -Uri "$baseUrl/notifications" -Method Get -Headers $headers
    if ($null -eq $notifs) { throw "Notifications returned null" }
}

Run-Test "Provider Checks Unread Count" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/notifications/unread-count" -Method Get -Headers $headers
    if ($null -eq $res.count) { throw "Unread count missing" }
}

Run-Test "Provider Marks All Notifications As Read" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $res = Invoke-RestMethod -Uri "$baseUrl/notifications/mark-all-read" -Method Post -Headers $headers
    if ($res.message -notmatch "read") { throw "Unexpected response: $($res.message)" }
}

# ========================================================
# 10. METRICS, REPORTS & AUDIT TRAIL
# ========================================================
Write-Host "`n--- GROUP 10: Reports, Platform Impact & Audit Trail ---" -ForegroundColor Yellow

Run-Test "Provider Impact Statistics" {
    $headers = @{ Authorization = "Bearer $script:providerToken" }
    $stats = Invoke-RestMethod -Uri "$baseUrl/reports/provider" -Method Get -Headers $headers
    if ($null -eq $stats.totalRedistributedQuantity) { throw "Missing totalRedistributedQuantity" }
}

Run-Test "Charity Impact Statistics" {
    $headers = @{ Authorization = "Bearer $script:charityToken" }
    $stats = Invoke-RestMethod -Uri "$baseUrl/reports/charity" -Method Get -Headers $headers
    if ($null -eq $stats.totalQuantityReceived) { throw "Missing totalQuantityReceived" }
}

Run-Test "Admin Audit Logs Inspection" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $logs = Invoke-RestMethod -Uri "$baseUrl/admin/audit-logs" -Method Get -Headers $headers
    if ($logs.Count -lt 1) { throw "Audit log records should not be empty" }
}

# ========================================================
# 11. REAL-TIME SYSTEM MAINTENANCE MODE
# ========================================================
Write-Host "`n--- GROUP 11: Real-Time Maintenance Mode ---" -ForegroundColor Yellow

Run-Test "Admin Activates Maintenance Mode" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $body = @{ enable = $true; reason = 'Testing scheduled maintenance mode' } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/admin/maintenance/toggle" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.isMaintenanceActive -ne $true) { throw "Maintenance mode was not activated" }
}

Run-Test "Non-Admin Login Blocked During Maintenance (503 Service Unavailable)" {
    $body = @{ email = 'chef.mario@bellaitalia.com'; password = 'Provider@123' } | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $body -ContentType 'application/json'
        throw "Provider was able to log in during maintenance mode!"
    }
    catch {
        $status = $_.Exception.Response.StatusCode.value__
        if ($status -ne 503) { throw "Expected status 503 Service Unavailable, got $status" }
    }
}

Run-Test "Admin Retains Full Access During Maintenance (Admin Bypass)" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $dash = Invoke-RestMethod -Uri "$baseUrl/admin/dashboard" -Method Get -Headers $headers
    if ($null -eq $dash.totalUsers) { throw "Admin could not access dashboard during maintenance" }
}

Run-Test "Admin Deactivates Maintenance Mode" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $body = @{ enable = $false; reason = 'Maintenance testing complete' } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/admin/maintenance/toggle" -Method Post -Body $body -ContentType 'application/json' -Headers $headers
    if ($res.isMaintenanceActive -ne $false) { throw "Maintenance mode was not deactivated" }
}

Run-Test "Normal Operations Resume for Non-Admin After Maintenance" {
    $body = @{ email = 'chef.mario@bellaitalia.com'; password = 'Provider@123' } | ConvertTo-Json
    $res = Invoke-RestMethod -Uri "$baseUrl/auth/login" -Method Post -Body $body -ContentType 'application/json'
    if ([string]::IsNullOrEmpty($res.token)) { throw "Provider login failed after maintenance deactivation" }
}

# ========================================================
# 12. SIGNALR REAL-TIME NOTIFICATION HUB HANDSHAKE
# ========================================================
Write-Host "`n--- GROUP 12: Real-Time SignalR WebSockets ---" -ForegroundColor Yellow

Run-Test "SignalR Negotiate Handshake (/hubs/notifications/negotiate)" {
    $headers = @{ Authorization = "Bearer $script:adminToken" }
    $res = Invoke-RestMethod -Uri "$rootUrl/hubs/notifications/negotiate?negotiateVersion=1" -Method Post -Headers $headers
    if ([string]::IsNullOrEmpty($res.connectionId) -and [string]::IsNullOrEmpty($res.connectionToken)) {
        throw "SignalR negotiate did not return connectionId or connectionToken"
    }
    if ($null -eq $res.availableTransports) { throw "Missing availableTransports" }
}

# ========================================================
# FINAL RESULTS SUMMARY
# ========================================================
Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   TEST SUITE EXECUTION SUMMARY                           " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Total Tests Executed : $totalTests"
Write-Host "Passed Tests         : $passed" -ForegroundColor Green
Write-Host "Failed Tests         : $failed" -ForegroundColor $(if ($failed -gt 0) { 'Red' } else { 'Green' })

if ($failed -eq 0) {
    Write-Host "`nALL $totalTests INTEGRATION TESTS PASSED WITH 100% SUCCESS!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n$failed TEST(S) FAILED!" -ForegroundColor Red
    exit 1
}
