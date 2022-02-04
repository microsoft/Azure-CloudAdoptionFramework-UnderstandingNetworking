
# Version 1.0  Provision VPN Client

# Sleep as extension has a habit of starting a little too quick.
Start-Sleep -Seconds 30

#Disable Firewall
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

#Enable RDP 
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

#Disable OOBE
$regPath = 'HKLM:\Software\Policies\Microsoft\Windows\OOBE'
New-Item -Path $regPath -Force
New-ItemProperty -Path $regPath -Name DisablePrivacyExperience -PropertyType dword -Value 1 -Force

# Disable EDGE Launch
$regPath = 'HKLM:\Software\Policies\Microsoft\MicrosoftEdge\Main'
New-Item -Path $regPath -Force
New-ItemProperty -Path $regPath -Name PreventFirstRunPage -PropertyType dword -Value 1 -Force

#Disable First Logon Animation
$regPath = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon'
New-Item -Path $regPath -Force
New-ItemProperty -Path $regPath -Name EnableFirstLogonAnimation -PropertyType dword -Value 0 -Force

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Confirm:$false -Force

# Install Chocolatey
Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')) 

# Install OpenVPN
choco install openvpn --params "'/SELECT_SHORTCUTS=1 /SELECT_ASSOCIATIONS=1'" -y

# Create Lab Cert Files
New-Item 'C:\Users\All Users\VPNCertificates' -ItemType Directory -Force 
$p2sClientCertPath = (New-Item 'C:\Users\All Users\Desktop\VPNCertificates\P2SClientCertificate.txt' -ItemType File -Force).FullName
$p2sClientPrivateKeyPath = (New-Item 'C:\Users\All Users\Desktop\VPNCertificates\P2SClientPrivateKey.txt' -ItemType File -Force).FullName
$rootCertPath = (New-Item 'C:\Users\All Users\Desktop\VPNCertificates\RootCert.txt' -ItemType File -Force).FullName

# Populate Content of Cert Files
Set-Content -Value ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/billcurtis/AzureNetEssentials1.0/master/DeploymentScripts/Artifacts/P2SClientCertificate.txt' -UseBasicParsing).Content) -LiteralPath $p2sClientCertPath -Force
Set-Content -Value ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/billcurtis/AzureNetEssentials1.0/master/DeploymentScripts/Artifacts/P2SClientPrivateKey.txt' -UseBasicParsing).Content) -LiteralPath $p2sClientPrivateKeyPath -Force
Set-Content -Value ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/billcurtis/AzureNetEssentials1.0/master/DeploymentScripts/Artifacts/RootCert.txt' -UseBasicParsing).Content) -LiteralPath $rootCertPath -Force

# Install Latest Microsoft Edge

choco install microsoft-edge -y

# Create Shortcut for Azure Portal

$TargetPath = "https://portal.azure.com"
$ShortcutFile = "C:\Users\Public\Desktop\Azure Portal.url"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetPath
$Shortcut.Save()


# Disable Edge First Run Experience 
regPath = 'HKLM:\Software\Microsoft\Edge'
New-Item -Path $regPath -Force
New-ItemProperty -Path $regPath -Name HideFirstRunExperience -PropertyType dword -Value 1 -Force