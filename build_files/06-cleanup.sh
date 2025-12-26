#!/bin/bash

set -ouex pipefail

# Disabling stuff to that they won't end up enabled on the final image
dnf5 -y copr disable ublue-os/packages
dnf5 -y copr disable secureblue/run0edit
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tailscale.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/docker-ce.repo

