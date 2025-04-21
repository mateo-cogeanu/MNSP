# MNSP (Mount NAS Shares Plex)

**MNSP** is a shell script designed to automate the process of mounting shared folders from a QNAP NAS onto a host system and binding them to a directory accessible by a Plex media server running in a container. This ensures seamless integration of your NAS media library with Plex for effortless media streaming.

## Features

- **Automated Mounting**: Automatically mounts CIFS/SMB shares from your QNAP NAS to a local directory.
- **Unified Configuration**: Combines NAS credentials and mount settings into a single configuration file for easy management.
- **Secure Credentials Management**: Ensures sensitive credentials are stored securely with restricted file permissions.
- **Bind Mounting**: Binds the mounted NAS share to the directory used by your Plex container, ensuring Plex can access the media files.
- **Error Handling**: Includes checks to ensure successful mounting and binding, with clear error messages if something goes wrong.

## Prerequisites

- A QNAP NAS with shared folders configured and accessible via CIFS/SMB.
- `cifs-utils` installed on the host system (automatically installed by the script if missing).
- Plex media server running in a container (e.g., Docker or Podman).
- Sufficient permissions to mount shares and create directories (`sudo` access required).

## Installation and Usage

1. **Create the Configuration File**:
   Create a file named `/etc/mount_nas_to_plex.conf` with the following content:
   ```bash
   # NAS Configuration
   NAS_IP="192.168.1.100"              # QNAP NAS IP
   NAS_SHARE="/Media"                  # Shared folder on NAS
   NAS_USER="your_username"            # Username for NAS authentication
   NAS_PASS="your_password"            # Password for NAS authentication

   # Local Configuration
   MOUNT_POINT="/mnt/nas_media"        # Local mount point
   PLEX_MEDIA_DIR="/path/to/plex/media" # Plex container media directory
   ```
   Set secure permissions for the file:
   ```bash
   sudo chmod 600 /etc/mount_nas_to_plex.conf
   ```

2. **Download the Script**:
   Save the script as `mount_nas_to_plex.sh`.

3. **Make it Executable**:
   ```bash
   chmod +x mount_nas_to_plex.sh
   ```

4. **Run the Script**:
   Execute the script with root privileges:
   ```bash
   sudo ./mount_nas_to_plex.sh
   ```

5. **Verify**:
   Ensure the NAS share is mounted successfully and Plex can access the media files.

## Example Configuration

#### `/etc/mount_nas_to_plex.conf`
```bash
# NAS Configuration
NAS_IP="192.168.1.100"              # QNAP NAS IP
NAS_SHARE="/Media"                  # Shared folder on NAS
NAS_USER="your_username"            # Username for NAS authentication
NAS_PASS="your_password"            # Password for NAS authentication

# Local Configuration
MOUNT_POINT="/mnt/nas_media"        # Local mount point
PLEX_MEDIA_DIR="/path/to/plex/media" # Plex container media directory
```

## Persistence Across Reboots

To ensure the NAS share is mounted automatically after a reboot, add the following line to your `/etc/fstab` file:

```plaintext
//192.168.1.100/Media /mnt/nas_media cifs username=your_username,password=your_password,iocharset=utf8,vers=3.0 0 0
```

Additionally, bind the mount point to the Plex directory using a systemd service or similar mechanism.

## Security Considerations

- **Configuration File**: Store the configuration file with restricted permissions (`chmod 600`) to prevent unauthorized access.
- **Sensitive Data**: Avoid sharing the configuration file or storing it in insecure locations.
- **File Permissions**: Regularly audit the permissions of the configuration file to ensure they remain secure.

## Support

For issues or questions, please open an issue in the repository or consult the documentation.
