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