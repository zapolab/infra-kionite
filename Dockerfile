FROM quay.io/fedora/fedora-kinoite:45@sha256:594588b6e4604aff601a9414023b841b2a6517ca06f742d6a93e7e9fb412d521

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
    && dnf5 install "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    && dnf5 copr enable -y gundulabs/gaze \
    && dnf5 install -y \
    vim \
    fish \
    podman-compose \
    ifuse \
    libimobiledevice-utils \
    libheif-freeworld \
    libheif-tools \
    tailscale \
    gaze \
    gaze-gui \
    && systemctl enable tailscaled \
    && dnf5 clean all \
    && rm -rf /var/cache/libdnf5/* /var/log/dnf*

RUN bootc container lint
