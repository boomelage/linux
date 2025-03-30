#!/bin/bash

# Name of the new custom shortcut
SHORTCUT_NAME='Open File Explorer'

# The command to launch Nautilus (default file explorer)
SHORTCUT_COMMAND='nautilus'

# The keyboard binding for the shortcut
SHORTCUT_BINDING='<Primary><Alt>e'

# Get existing custom keybindings
EXISTING_KEYS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# Determine new custom shortcut path
if [ "$EXISTING_KEYS" = "@as []" ]; then
    NEW_KEY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$NEW_KEY']"
else
    INDEX=$(echo "$EXISTING_KEYS" | grep -o "custom[0-9]\+" | sed 's/custom//' | sort -n | tail -1)
    INDEX=$((INDEX + 1))
    NEW_KEY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${INDEX}/"
    UPDATED_KEYS=$(echo "$EXISTING_KEYS" | sed "s/]$/, '$NEW_KEY']/")
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$UPDATED_KEYS"
fi

# Set the actual keybinding, name, and command
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$NEW_KEY" name "$SHORTCUT_NAME"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$NEW_KEY" command "$SHORTCUT_COMMAND"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$NEW_KEY" binding "$SHORTCUT_BINDING"

echo "✅ Shortcut 'Ctrl + Alt + E' to open File Explorer has been added."
