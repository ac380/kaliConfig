#!/bin/bash
# Randomly update XFCE wallpaper and LightDM greeter background

### --- CONFIGURATION --- ###
WALLPAPER_DIR="/usr/share/backgrounds/kali-community"         # Directory with wallpapers
LIGHTDM_CONF="/etc/lightdm/lightdm-gtk-greeter.conf"  # LightDM config file
XFCE_CHANNEL="xfce4-desktop"            # XFCE config channel
### ---------------------- ###

# Pick a random wallpaper
wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)

if [ -z "$wallpaper" ]; then
    echo "❌ No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

echo "Selected wallpaper: $wallpaper"

### --- XFCE DESKTOP (user level) --- ###
echo "Updating XFCE wallpaper..."
for prop in $(xfconf-query -c "$XFCE_CHANNEL" -l | grep "last-image"); do
    xfconf-query -c "$XFCE_CHANNEL" -p "$prop" -s "$wallpaper"
done
xfdesktop --reload

### --- LIGHTDM GREETER (root level) --- ###
echo "Updating LightDM greeter background (requires sudo)..."
sudo sed -i "s|^background = .*|background = $wallpaper|" "$LIGHTDM_CONF"

echo "Wallpaper and greeter background updated!"
