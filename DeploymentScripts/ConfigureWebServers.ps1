
# Version 1.0  Configure Web Server

# Sleep as extension has a habit of starting a little too quick.
Start-Sleep -Seconds 30


#Install IIS
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -All -LimitAccess

#Configure custom IIS default page
$sysinfo = @()
$IPAddress = (Get-NetIPAddress -InterfaceAlias Ethernet | Where-Object {$_.AddressFamily -eq 'IPv4'}).IPAddress

$sysinfo = [pscustomobject]@{

Computername = $env:COMPUTERNAME
IPAddress = $IPAddress

}

$sysinfo | ConvertTo-Html | Out-File C:\inetpub\wwwroot\iisstart.htm

#Disable Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#Enable Powershell
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

#Disable IE-ESC
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

#Enable RDP
$RDPRegPath = 'HKLM:\System\CurrentControlSet\Control\Terminal Server'
set-ItemProperty -Path $RDPRegPath -name "fDenyTSConnections" -Value 0

