#!/bin/bash

set -ouex pipefail

systemctl enable brew-setup.service
systemctl enable tailscaled.service
systemctl enable uupd.timer
systemctl enable podman.socket
systemctl enable docker.socket