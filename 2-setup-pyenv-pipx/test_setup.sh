#!/usr/bin/env bats

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

load 'setup.sh'

@test "install_yq installs yq if not already installed" {
  # Mock command -v to simulate yq not being installed
  run command -v yq
  [ "$status" -eq 1 ]

  # Run the install_yq function
  run install_yq

  # Check that yq is now installed
  run command -v yq
  [ "$status" -eq 0 ]
}

@test "install_pipx installs pip if not already installed" {
  # Mock command -v to simulate pip not being installed
  run command -v pip
  [ "$status" -eq 1 ]

  # Run the install_pipx function
  run install_pipx

  # Check that pip is now installed
  run command -v pip
  [ "$status" -eq 0 ]
}

@test "install_pipx installs pipx if not already installed" {
  # Mock command -v to simulate pipx not being installed
  run command -v pipx
  [ "$status" -eq 1 ]

  # Run the install_pipx function
  run install_pipx

  # Check that pipx is now installed
  run command -v pipx
  [ "$status" -eq 0 ]
}

@test "install_pipx upgrades pipx if already installed" {
  # Mock command -v to simulate pipx being installed
  run command -v pipx
  [ "$status" -eq 0 ]

  # Run the install_pipx function
  run install_pipx

  # Check that pipx is still installed
  run command -v pipx
  [ "$status" -eq 0 ]
}