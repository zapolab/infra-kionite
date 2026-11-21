FROM quay.io/fedora/fedora-kinoite:46@sha256:7a2af4f7a657651f4e91edadc876a8b4a9e62035c8f88b70501729eaabc7efab

# Remove unused packages
RUN dnf5 rm -y \
    firefox \
    firefox-langpacks \
    fedora-bookmarks \
    fedora-chromium-config \
    gwenview \
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

# Enable flathub
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install packages
RUN dnf5 config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
    && dnf5 install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    && dnf5 copr enable -y gundulabs/gaze \
    && dnf5 install -y \
    libheif-freeworld \
    libheif-tools \
    ifuse \
    libimobiledevice-utils \
    vim \
    fish \
    podman-compose \
    tailscale \
    gaze \
    gaze-gui \
    && systemctl enable tailscaled \
    && dnf5 clean all \
    && rm -rf /var/cache/libdnf5/* /var/log/dnf*

RUN bootc container lint
