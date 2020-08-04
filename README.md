# Docker configuration for big data

It includes:

- Spark
- Python
- Zeppelin

## Switching from Docker to VMWare

On Windows
- Enabling docker `bcdedit /set hypervisorlaunchtype auto`
- Enabling VMWare `bcdedit /set hypervisorlaunchtype off`

In case VM tools is not working after install `sudo systemctl restart open-vm-tools.service`
