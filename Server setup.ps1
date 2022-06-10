#Installed Windows Server 2022 iso https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
#Installed Windows 11 iso https://www.microsoft.com/software-download/windows11
#Run through initial setup

<#remove restrictions from running unsigned powershell scripts
Set-ExecutionPolicy Unrestricted

#Install VMWare tools
D:\setup64.exe

<#set a static IP address, subnet mask, & gateway
#gateway is same as DC server IP


#grabs current ipv4 address
$ipv4 = (Get-NetIPAddress | Where-Object {$_.AddressState -eq "Preferred" -and $_.ValidLifetime -lt "24:00:00"}).IPAddress
#determine what subnet to use
$ipv4subnet = (Get-NetIPAddress | Where-Object {$_.IPAddress -eq "$ipv4"}).PrefixLength
$ipv4
$ipv4subnet

Start-Sleep -Seconds 5 
$staticipv4 = Read-Host -Prompt "Enter your static IP address"
$staticsubnet = Read-Host -Prompt "Enter your subnet in CIDR notation, / (e.g. 24)"#>
