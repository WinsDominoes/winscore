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

rm -f /usr/bin/chsh
rm -f /usr/bin/chfn
rm -f /usr/bin/pkexec
rm -f /usr/bin/sudo
rm -f /usr/bin/su