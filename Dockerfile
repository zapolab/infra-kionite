FROM quay.io/fedora/fedora-kinoite:45@sha256:4e86e68116ee64156b9df71a21c3904d37d4415e6f2b12b6fa308bae49c9a9de

# Remove unused packages
RUN dnf5 rm -y \
  firefox \
  firefox-langpacks \
  fedora-bookmarks \
  fedora-chromium-config \
  toolbox \
  plasma-discover-rpm-ostree \
  openssh-server \
  cups-browsed \
  realmd \
  sssd-kcm \
  thermald \
  intel-lpmd \
  nvidia-gpu-firmware \
  default-fonts-cjk-mono \
  default-fonts-cjk-sans \
  default-fonts-cjk-serif \
  && dnf5 clean all \
  && rm -rf /var/cache/libdnf5/* /var/log/dnf*

# Install packages
RUN dnf5 config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
  && dnf5 copr enable -y gundulabs/gaze \
  && dnf5 install -y \
  fish \
  podman-compose \
  ifuse \
  libimobiledevice-utils \
  tailscale \
  gaze \
  gaze-gui \
  && systemctl enable tailscaled \
  && dnf5 clean all \
  && rm -rf /var/cache/libdnf5/* /var/log/dnf*

RUN bootc container lint
