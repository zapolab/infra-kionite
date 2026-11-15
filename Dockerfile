FROM quay.io/fedora/fedora-kinoite:45@sha256:f87601299d5b427d81a77ee77128d1548b814727c8366345ded70367d8b4a633

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
