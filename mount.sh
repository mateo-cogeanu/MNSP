#!/bin/bash

# Configuration file - Update this path if needed
CONFIG_FILE="config.conf"

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found at $CONFIG_FILE. Exiting..."
    exit 1
fi

# Source the configuration file
source "$CONFIG_FILE"

# Ensure the configuration file has secure permissions
if [ "$(stat -c %a "$CONFIG_FILE")" != "600" ]; then
    echo "Warning: The configuration file should have permissions set to 600 for security."
    echo "Fixing permissions now..."
    sudo chmod 600 "$CONFIG_FILE"
fi

# Check if cifs-utils is installed
if ! dpkg -l | grep -q cifs-utils; then
    echo "cifs-utils is not installed. Installing now..."
    sudo apt-get update
    sudo apt-get install -y cifs-utils
fi

# Create the mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point at $MOUNT_POINT"
    sudo mkdir -p "$MOUNT_POINT"
fi

# Mount the NAS share using the credentials from the config file
echo "Mounting NAS share $NAS_SHARE from $NAS_IP to $MOUNT_POINT"
sudo mount -t cifs -o username="$NAS_USER",password="$NAS_PASS",iocharset=utf8,vers=3.0 "$NAS_IP:$NAS_SHARE" "$MOUNT_POINT"

# Check if the mount was successful
if mountpoint -q "$MOUNT_POINT"; then
    echo "NAS share successfully mounted at $MOUNT_POINT"
else
    echo "Failed to mount NAS share. Exiting..."
    exit 1
fi

# Bind the mounted NAS share to the Plex media directory
if [ ! -d "$PLEX_MEDIA_DIR" ]; then
    echo "Plex media directory $PLEX_MEDIA_DIR does not exist. Creating it..."
    sudo mkdir -p "$PLEX_MEDIA_DIR"
fi

echo "Binding $MOUNT_POINT to $PLEX_MEDIA_DIR"
sudo mount --bind "$MOUNT_POINT" "$PLEX_MEDIA_DIR"

# Verify the bind mount
if mountpoint -q "$PLEX_MEDIA_DIR"; then
    echo "Bind mount successful. Plex can now access media from $PLEX_MEDIA_DIR"
else
    echo "Failed to bind mount. Exiting..."
    exit 1
fi

echo "Script completed successfully."
