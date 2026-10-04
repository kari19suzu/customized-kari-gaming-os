#!/usr/bin/env bash
# Custom OS identity and boot configuration

iso_name="Karis-customgaming-os"
iso_label="CUSTOM_OS_$(date +%Y%m)"
iso_publisher="Kari"
iso_application="Gaming and Streaming Workstation"
iso_version="1.0"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.grub')
arch="x86_64"
pacman_conf="pacman.conf"

file_permissions=(
  ["/usr/local/bin/smart-proton-update.sh"]="0:0:755"
  ["/etc/skel/.config/autostart-scripts/set-wallpaper.sh"]="0:0:755"
  ["/usr/local/bin/init-gaming-env.sh"]="0:0:755"
)
