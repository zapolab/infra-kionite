FROM quay.io/fedora/fedora-kinoite:46@sha256:1c84a09411861a8a8f51743e5afbdabed232d46c0644ae6337f51f2013104bd2

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
