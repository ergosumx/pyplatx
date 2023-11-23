# Enable WSL 2 and Install Ubuntu

# Copyright (c) 2023 Nilay Parikh (me@nilayparikh.com, nilayparikh@gmail.com), ErgoSum Technologies LTD (oss@ergosum.in)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Print message about enabling features
Write-Output "This script will enable all necessary features for WSL 2 and install Ubuntu."

$response = Read-Host "Would you like to continue? (Y/N)"
if ($response -ne "Y") {
  Exit
}

# Check if optional features already enabled  
$featuresEnabled = Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq "Enabled"}
if ($featuresEnabled) {
  Write-Output "Some optional features already enabled:" 
  $featuresEnabled | ForEach-Object { Write-Output $_.FeatureName }   
}
else {
  Write-Output "Enabling Windows optional features..."
  Get-WindowsOptionalFeature -Online | Where-Object {$_.State -ne "Enabled"} | ForEach-Object { Enable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -NoRestart }   
}

# Check if WSL already enabled
$wslEnabled = Get-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online
if ($wslEnabled.State -eq "Enabled") {
  Write-Output "Windows Subsystem for Linux already enabled"
}  
else {
  Write-Output "Enabling Windows Subsystem for Linux..." 
  dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
}

# Check if VirtualMachinePlatform already enabled  
$vmEnabled = Get-WindowsOptionalFeature -FeatureName VirtualMachinePlatform -Online
if ($vmEnabled.State -eq "Enabled") {
  Write-Output "Virtual Machine Platform already enabled" 
}
else {
  Write-Output "Enabling Virtual Machine Platform..."
  dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart 
}

Write-Output "Setting WSL 2 as default..."
wsl --set-default-version 2

# Print message and check if Ubuntu already installed
$ubuntuInstalled = Get-AppxPackage -Name CanonicalGroupLimited.UbuntuonWindows 
if ($ubuntuInstalled) {
  Write-Output "Ubuntu already installed."
  Exit
}

$response = Read-Host "Would you like to install Ubuntu from Store? (Y/N)"
if ($response -ne "Y") {
  Exit  
}

Write-Output "Installing Ubuntu..."

Get-AppxPackage -Name CanonicalGroupLimited.UbuntuonWindows | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }  

Write-Output "Done!"