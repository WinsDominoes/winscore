#!/bin/bash

set -ouex pipefail

# Packages
misc_packages=(
  "PackageKit"
)

packages=(
  ${misc_packages[@]}
)

# install rpms
dnf5 remove -y ${packages[@]}
