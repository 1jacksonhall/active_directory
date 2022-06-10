#Installed Windows Server 2022 iso https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
#Installed Windows 11 iso https://www.microsoft.com/software-download/windows11



#Ran through initial setup

#remove restrictions from running unsigned powershell scripts
Set-ExecutionPolicy Unrestricted

#Install VMWare tools
D:\setup64.exe

#set a static IP address, subnet mask, & gateway
#gateway is same as DC IP
