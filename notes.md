#vmware workstation environment
#configured under a virtual switch as an internal network, no NAT no WAN access


##Client
#Install Windows 11 iso https://www.microsoft.com/software-download/windows11
#Run through initial setup
#Install VMware tools
D:\setup64.exe
#create a clone of client


#optional - install chocolatey for package management
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



##Server
#Install Windows Server 2022 iso https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
#Run through initial setup
#Install VMware tools
D:\setup64.exe

#set a static IPv4 address
Get-NetIPAddress
#note the interfaceindex for ipv4 address
Remove-NetIPAddress (IP)
New-NetIPAddress (NEWIP) -InterfaceIndex (interface) -PrefixLength (network bits/subnet)

#configure dns to point to itself, verify with
Get-DNSClientServerAddress –InterfaceIndex
#set the dns to either the server's IP or loopback address
Set-DnsClientServerAddress -InterfaceIndex (interface) -ServerAddresses ("*serverIP*","127.0.0.1")

#client should be able to ping the DC if it is under the same subnet/virtual switch
