FROM quay.io/fedora/fedora-kinoite:45@sha256:cbc9be8afaf179b2e9e7ce71412a01fd4264c711925e10e75017553ff124af31

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
  tailscale \
  gaze \
  gaze-gui \
  && systemctl enable tailscaled \
  && dnf5 clean all \
  && rm -rf /var/cache/libdnf5/* /var/log/dnf*

RUN bootc container lint
