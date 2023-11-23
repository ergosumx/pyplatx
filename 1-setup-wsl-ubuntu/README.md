## Enable WSL 2 and Install Ubuntu Script
This PowerShell script automates the steps required to set up WSL 2 on Windows and install an Ubuntu Linux distribution from the Windows Store.

### Usage
1. Make sure you are running Windows 10 version 2004 or higher
2. Download and save the script as `enable-wsl2-ubuntu.ps1`
3. Open a PowerShell window as Administrator
4. Navigate to the script directory
5. Run the script:
  ``` powershell
  .\enable-wsl2-ubuntu.ps1
  ```
6. Follow the prompts to enable features and install Ubuntu

### What it does
Enables the optional Windows features required by WSL 2
- Enables Windows Subsystem for Linux
- Enables Virtual Machine Platform
- Sets WSL 2 as the default architecture
- Installs the Ubuntu Linux distribution from the Windows Store
### Notes
- Requires Windows 10 version 2004 or higher
- Must be run as Administrator to enable features
- Reboots may be required after enabling certain features
### Contribution
Spot an issue or have an improvement? Submit a pull request!

### License
This script is released under the MIT License

Let me know if you have any other questions!
