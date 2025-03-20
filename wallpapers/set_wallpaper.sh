#!/bin/bash

# Image URL
IMAGE_URL="https://github.com/boomelage/wallpapers/blob/main/NISTvoltChip.jpg?raw=true"

# Destination file
DESTINATION="$HOME/Pictures/NISTvoltChip.jpg"

# Ensure Pictures directory exists
mkdir -p "$HOME/Pictures"

# Download the image
wget -O "$DESTINATION" "$IMAGE_URL"

# Set the image as wallpaper (GNOME)
gsettings set org.gnome.desktop.background picture-uri "file://$DESTINATION"

# Confirm success
echo "Wallpaper has been set!"
