#vmware workstation environment
#configured under a virtual switch as an internal network, no NAT no WAN access outside of installing server roles


**##Client**
#Install Windows 11 iso https://www.microsoft.com/software-download/windows11
#Run through initial setup
#Install VMware tools
D:\setup64.exe
#create a clone of client


#optional - install chocolatey for package management
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#optional allow powershell scripts to run on machine
Set-ExecutionPolicy Unrestricted

#setup PC for remote management of DC
#add server IP to trusted hosts on remote management PC
Start-Service winRM
set-item WSMan:\localhost\Client\TrustedHosts -value (ServerIP)

Enter-PSSession (ServerIP) -Credential(Get-Credential)


#domain PC - join a workstation to a domain
Add-Computer -Domainname (name) -Credential (name)\Administrator -Force -Restart



##Server
#Install Windows Server 2022 iso https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
#Run through initial setup
#Install VMware tools
D:\setup64.exe

#useful commands
Set-DNSClientServerAddress                                #Statically confiure DNS (e.g. Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses ("1.1.1.1","1.0.0.1"))
Set-DnsClientServerAddress -ResetServerAddresses          #removes statically configured DNS address
Remove-NetRoute                                           #removes statically configured default gateways
Remove-NetIPAddress                                       #removes a network config/statically configured IP from an interface
New-NetIPAddress                                          #Creates a new network configuration for an interface




**#DC setup**
#install the DC features
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
#install AD DS forest
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "domain.local" -InstallDNS


#set a static IPv4 address
Get-NetIPAddress
#note the interfaceindex for ipv4 address
Remove-NetIPAddress (IP)
New-NetIPAddress (NEWIP) -InterfaceIndex (interface) -PrefixLength (network bits/subnet) -DefaultGateway (IP)

#configure dns on DC to point to itself, verify with
Get-DNSClientServerAddress –InterfaceIndex
#set the dns to either the server's IP or loopback address
Set-DnsClientServerAddress -InterfaceIndex (interface) -ServerAddresses ("*serverIP*","127.0.0.1")

#client should be able to ping the DC if it is under the same subnet/virtual switch

#add windows features
Add-WindowsFeature AD-Domain-Services
#install forest/promote to domain controller
Install-ADDSForest -DomainName (DOMAINNAME) -InstallDNS








































##exchange
#install pre-reqs
a. .NET Framework 4.8

b. Visual C++ Redistributable Package for Visual Studio 2012

c. Visual C++ Redistributable Package for Visual Studio 2013

#install windows features
Install-WindowsFeature RSAT-ADDS

#begin install for remaining features - come back tomorrow
Install-WindowsFeature Server-Media-Foundation, NET-Framework-45-Features, RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, RSAT-Clustering-PowerShell, WAS-Process-Model, Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Metabase, Web-Mgmt-Service, Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-Windows-Auth, Web-WMI, RSAT-ADDS
