#!/usr/bin/env bats

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