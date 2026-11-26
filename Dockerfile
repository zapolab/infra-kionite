FROM quay.io/fedora/fedora-kinoite:45@sha256:72c24fe77ec6f541529c6db4ff38f91b7f0b3a23072ee8e145b37fde6b1b167d

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
