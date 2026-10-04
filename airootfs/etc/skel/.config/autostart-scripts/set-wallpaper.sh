#!/usr/bin/env bash

# Wait a few seconds for the desktop to fully load
sleep 5

# Tell KDE Plasma to change the wallpaper on all monitors
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var allDesktops = desktops();
    for (i=0; i<allDesktops.length; i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
        d.writeConfig('Image', 'file:///usr/share/backgrounds/desktop-background.png');
    }
"

# Delete this script so it only runs on the very first boot
rm -- "$0"
