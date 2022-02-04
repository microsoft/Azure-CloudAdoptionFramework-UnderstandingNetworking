
# Version 1.0  Provision VPN Client

# Sleep as extension has a habit of starting a little too quick.
Start-Sleep -Seconds 30

#Disable Firewall
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

#Enable RDP 
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

#Enable RDP
$RDPRegPath = 'HKLM:\System\CurrentControlSet\Control\Terminal Server'
set-ItemProperty -Path $RDPRegPath -name "fDenyTSConnections" -Value 0

Invoke-Command -ScriptBlock {

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

}