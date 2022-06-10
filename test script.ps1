
<#extra
#grabs current ipv4 address
$ipv4 = (Get-NetIPAddress | Where-Object {$_.AddressState -eq "Preferred" -and $_.ValidLifetime -lt "24:00:00"}).IPAddress
#determine what subnet to use
$ipv4subnet = (Get-NetIPAddress | Where-Object {$_.IPAddress -eq "$ipv4"}).PrefixLength
$ipv4
$ipv4subnet

Start-Sleep -Seconds 5 
$staticipv4 = Read-Host -Prompt "Enter your static IP address"
$staticsubnet = Read-Host -Prompt "Enter your subnet in CIDR notation, / (e.g. 24)"#>
