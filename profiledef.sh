#!/usr/bin/env bash
# Custom OS identity and boot configuration

iso_name="custom-gaming-os"
iso_label="CUSTOM_OS_$(date +%Y%m)"
iso_publisher="Custom Build"
iso_application="Gaming and Streaming Workstation"
iso_version="1.0"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.grub.esp' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
