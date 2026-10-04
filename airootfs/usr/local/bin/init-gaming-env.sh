#!/usr/bin/env bash
# Automated First-Boot Setup for HoYoverse, PGR, and Gaming Tooling

LOCKFILE="/var/lib/custom-os-initialized.flag"

# Exit immediately if this script has already run on a previous boot
if [ -f "$LOCKFILE" ]; then
    exit 0
fi

echo "[+] Initializing Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "[+] Installing Heroic Games Launcher & ProtonUp-Qt via Flatpak..."
flatpak install -y flathub com.heroicgameslauncher.hgl
flatpak install -y flathub net.davidotek.pupgui2

echo "[+] Enabling system services..."
systemctl enable --now bluetooth.service
systemctl enable --now waydroid-container.service

# Create the lock file so this script never runs again on future boots
mkdir -p "$(dirname "$LOCKFILE")"
touch "$LOCKFILE"

echo "[+] Gaming environment initialization complete!"
