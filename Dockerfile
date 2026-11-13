FROM quay.io/fedora/fedora-kinoite:45@sha256:cbc9be8afaf179b2e9e7ce71412a01fd4264c711925e10e75017553ff124af31

RUN dnf5 rm -y \
  # Remove intel/nvidia driver and deamons
  intel-audio-firmware \
  intel-gpu-firmware \
  intel-lpmd \
  intel-vsc-firmware \
  libva-intel-media-driver \
  thermald \
  nvidia-gpu-firmware \
  # Remove unused wifi firmwares
  b43-fwcutter \
  b43-openfwwf \
  brcmfmac-firmware \
  atheros-firmware \
  iwlegacy-firmware \
  iwlwifi-dvm-firmware \
  iwlwifi-mvm-firmware \
  libertas-firmware \
  nxpwireless-firmware \
  tiwilink-firmware \
  qcom-wwan-firmware \
  # Remove legacy printer and scanner firmwares
  hplip \
  gutenprint \
  gutenprint-cups \
  splix \
  c2esp \
  dymo-cups-drivers \
  ptouch-driver \
  printer-driver-brlaser \
  bluez-cups \
  mpage \
  paps \
  cups-browsed \
  # Remove legacy network packages
  NetworkManager-adsl \
  NetworkManager-ppp \
  NetworkManager-wwan \
  mobile-broadband-provider-info \
  usb_modeswitch \
  lrzsz \
  # Remove AFS packages
  realmd \
  sssd-common \
  sssd-kcm \
  pam_afs_session \
  # Remove unused asian specific packages
  ibus-anthy \
  ibus-chewing \
  ibus-hangul \
  ibus-libpinyin \
  ibus-m17n \
  ibus-typing-booster \
  default-fonts-cjk-mono \
  default-fonts-cjk-sans \
  default-fonts-cjk-serif \
  # Remove generic packages
  firefox \
  firefox-langpacks \
  fedora-bookmarks \
  fedora-chromium-config \
  toolbox \
  plasma-discover-rpm-ostree \
  openssh-server \
  # Clean up
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
