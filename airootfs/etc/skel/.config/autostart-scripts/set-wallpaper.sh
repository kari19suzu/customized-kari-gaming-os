#!/usr/bin/env bash
# Set custom KDE Plasma wallpaper on first user boot only

LOCKFILE="${HOME}/.config/custom-wallpaper-applied.flag"

# Exit immediately if this script has already run for this user
if [ -f "$LOCKFILE" ]; then
    exit 0
fi

# Wait a few seconds for the desktop and D-Bus session to fully load
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

# Create the lock file so this never runs again on future boots
mkdir -p "$(dirname "$LOCKFILE")"
touch "$LOCKFILE"
