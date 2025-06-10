#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1


dnf5 install 'dnf5-command(copr)'
dnf5 -y copr enable ublue-os/packages
dnf5 config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# This installs a package from fedora repos
dnf5 -y install tailscale distrobox ublue-brew uupd podman cockpit samba brcmfmac-firmware bootc NetworkManager-wifi atheros-firmware iwlegacy-firmware iwlwifi-dvm-firmware iwlwifi-mvm-firmware mt7xxx-firmware nxpwireless-firmware realtek-firmware tiwilink-firmware 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# Enable required System Unit files

systemctl enable brew-setup.service
systemctl enable tailscaled.service
systemctl enable uupd.timer
systemctl enable podman.socket
systemctl enable docker.socket
