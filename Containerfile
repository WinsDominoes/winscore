# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM quay.io/fedora/fedora-coreos:stable

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

ARG BASE_IMAGE_NAME="fedora-coreos"
ARG FEDORA_MAJOR-VERSION="43"
ARG IMAGE_NAME="winscore"
ARG IMAGE_VENDOR="winsdominoes"
ARG FEDORA_MAJOR_VERSION="43"
ARG UBLUE_IMAGE_TAG="43"
ARG VERSION=""

COPY --from=ghcr.io/ublue-os/brew:latest /system_files /
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/00-preconfigure.sh && \
    /ctx/01-image-info.sh && \
    /ctx/02-install-packages.sh && \
    /ctx/03-get-official-docker.sh && \
    /ctx/04-remove-packages.sh && \
    /ctx/05-enable-services.sh && \
    /ctx/06-cleanup.sh
ENV LD_PRELOAD="/usr/local/lib/libhardened_malloc.so"


RUN ostree container commit
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
