# Bee tracker SSH tunnel service

This repository contains [systemd](https://systemd.io/) units that define a service to maintain a permanent SSH
reverse tunnel.

# Installation

```bash
# Get SSH key fingerprint

# Install systed units
cp --verbose scripts/systemd/* /etc/systemd/system

# Enable service
systemctl enable ssh-tunnel.service
```

# Usage

The service is controlled using [systemctl](https://www.freedesktop.org/software/systemd/man/latest/systemctl.html#).

```bash
systemctl start ssh-tunnel.service
systemctl stop ssh-tunnel.service
```
