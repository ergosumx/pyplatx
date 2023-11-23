# Unit Tests for Enable WSL 2 and Install Ubuntu

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

# Import Pester module
Import-Module Pester

# Test enabling optional features
Describe "Enable optional features" {

    Mock Enable-WindowsOptionalFeature { return $true }  

    It "Calls Enable-WindowsOptionalFeature for each disabled feature" {
        Get-WindowsOptionalFeature -Online | Where State -ne Enabled | Should -Invoke Enable-WindowsOptionalFeature -Exactly -Times 1 
    }
}

# Test WSL installation
Describe "WSL Installation" {
    
    Mock dism.exe { return $true }

    It "Enables WSL feature using dism.exe" {
        dism.exe -EnableFeature Microsoft-Windows-Subsystem-Linux | Should -Be $true 
    }

    It "Sets default WSL version to 2" {
        Mock wsl { return $true }
        wsl --Set-Default-Version 2 | Should -Be $true
    }
}

# Test Ubuntu installation
Describe "Ubuntu Installation" {

    Mock Get-AppxPackage -MockWith { [PSCustomObject]@{ InstallLocation = "C:\fakepath" }}
    Mock Add-AppxPackage { return $true }

    It "Calls Add-AppxPackage with correct parameters" {
        Add-AppxPackage -DisableDevelopmentMode -Register C:\fakepath\AppxManifest.xml | Should -Be $true 
    }
}