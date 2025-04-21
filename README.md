# MNSP (Mount NAS Shares Plex)

**MNSP** is a shell script designed to automate the process of mounting shared folders from a QNAP NAS onto a host system and binding them to a directory accessible by a Plex media server running in a container. This ensures seamless integration of your NAS media library with Plex for effortless media streaming.

## Features

- **Automated Mounting**: Automatically mounts CIFS/SMB shares from your QNAP NAS to a local directory.
- **Bind Mounting**: Binds the mounted NAS share to the directory used by your Plex container, ensuring Plex can access the media files.
- **Error Handling**: Includes checks to ensure successful mounting and binding, with clear error messages if something goes wrong.
- **Customizable**: Easily configurable with variables for NAS IP, share name, credentials, and Plex media directory.

## Prerequisites

- A QNAP NAS with shared folders configured and accessible via CIFS/SMB.
- `cifs-utils` installed on the host system (automatically installed by the script if missing).
- Plex media server running in a container (e.g., Docker or Podman).
- Sufficient permissions to mount shares and create directories (`sudo` access required).

## Installation and Usage

1. **Download the Script**:
   Save the script as `mount_nas_to_plex.sh`.

2. **Make it Executable**:
   ```bash
   chmod +x mount_nas_to_plex.sh
   ```

3. **Configure Variables**:
   Open the script and update the following variables to match your environment:
   - `NAS_IP`: The IP address of your QNAP NAS.
   - `NAS_SHARE`: The shared folder on the NAS (e.g., `/Media`).
   - `MOUNT_POINT`: The local directory where the NAS share will be mounted.
   - `PLEX_MEDIA_DIR`: The directory used by the Plex container for media storage.
   - `NAS_USER` and `NAS_PASS`: Credentials for accessing the NAS share.

4. **Run the Script**:
   Execute the script with root privileges:
   ```bash
   sudo ./mount_nas_to_plex.sh
   ```

5. **Verify**:
   Ensure the NAS share is mounted successfully and Plex can access the media files.

## Example Configuration

```bash
NAS_IP="192.168.1.100"              # QNAP NAS IP
NAS_SHARE="/Media"                  # Shared folder on NAS
MOUNT_POINT="/mnt/nas_media"        # Local mount point
PLEX_MEDIA_DIR="/path/to/plex/media" # Plex container media directory
NAS_USER="admin"                    # NAS username
NAS_PASS="password"                 # NAS password
```

## Persistence Across Reboots

To ensure the NAS share is mounted automatically after a reboot, add the following line to your `/etc/fstab` file:

```plaintext
//192.168.1.100/Media /mnt/nas_media cifs username=admin,password=password,iocharset=utf8,vers=3.0 0 0
```

Additionally, bind the mount point to the Plex directory using a systemd service or similar mechanism.

## Security Considerations

- Avoid hardcoding sensitive credentials in the script. Use a `.credentials` file or environment variables for better security.
- Restrict access to the script and credentials file using appropriate file permissions.

## Support

For issues or questions, please open an issue in the repository or consult the documentation.
