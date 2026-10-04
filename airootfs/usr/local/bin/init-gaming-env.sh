#!/usr/bin/env bash
# Automated First-Boot Setup for HoYoverse, PGR, and Gaming Tooling

echo "[+] Initializing Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "[+] Installing Heroic Games Launcher & ProtonUp-Qt via Flatpak..."
flatpak install -y flathub com.heroicgameslauncher.hgl
flatpak install -y flathub net.davidotek.pupgui2

echo "[+] Enabling system services..."
systemctl enable --now bluetooth.service
systemctl enable --now waydroid-container.service

echo "[+] Gaming environment initialization complete!"
