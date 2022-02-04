
# Version 1.0  Configure Console Servers for Access

Start-Sleep -Seconds 30

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
