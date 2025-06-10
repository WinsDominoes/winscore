#!/bin/bash

set -ouex pipefail

# Repositories
dnf5 install -y 'dnf5-command(copr)'
dnf5 -y copr enable ublue-os/packages
dnf5 config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# Packages
sysadmin_packages=(
  "tailscale"
  "podman" 
  "cockpit"
  "bootc"
)

firmware_packages=(
  "brcmfmac-firmware"
  "NetworkManager-wifi"
  "atheros-firmware" 
  "iwlegacy-firmware" 
  "iwlwifi-dvm-firmware" 
  "iwlwifi-mvm-firmware"
  "mt7xxx-firmware" 
  "nxpwireless-firmware"
  "realtek-firmware"
  "tiwilink-firmware"
)

utility_packages=(
  "distrobox" 
  "ublue-brew" 
  "uupd"
  "samba" 
  "micro"
)

dnf_packages=(
  ${sysadmin_packages[@]}
  ${firmware_packages[@]}
  ${utility_packages[@]}
)

# install rpms
dnf5 install -y ${dnf_packages[@]} --skip-unavailable

# Disabling stuff to that they won't end up enabled on the final image
dnf5 -y copr disable ublue-os/packages
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tailscale.repo

# brew_packages=(
#   "btop"
#   "dysk"
#   "dust"
#   "ffmpeg"
#   "fzf"
#   "broot"
# )
# 
# brew install ${brew_packages[@]}
