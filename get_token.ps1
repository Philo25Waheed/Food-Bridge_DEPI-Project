$b = @{email='admin@foodbridge.com';password='Admin@123456'} | ConvertTo-Json
$res = Invoke-RestMethod -Uri 'http://localhost:5000/api/auth/login' -Method Post -ContentType 'application/json' -Body $b
$res.token | Set-Clipboard
Write-Host "TOKEN_START:"
Write-Host $res.token
Write-Host "TOKEN_END"
