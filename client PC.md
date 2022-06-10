#installs chocolatey for package management
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#allow powershell scripts to run on machine
Set-ExecutionPolicy Unrestricted

#add server IP to trusted hosts on remote management PC
Start-Service winRM
set-item WSMan:\localhost\Client\TrustedHosts -value (ServerIP)

Enter-PSSession (ServerIP) -Credential(Get-Credential)

#install the DC roles
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Get-NetIPAddress

#join a workstation to a domain
Add-Computer -Domainname (name) -Credential (name)\Administrator -Force -Restart
