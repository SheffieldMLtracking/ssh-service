# Bee tracker SSH tunnel service

This repository contains [systemd](https://systemd.io/) units that define a service to maintain a permanent SSH
reverse tunnel.

# Installation

You must list the public key in the [`authorized_keys`](https://www.ssh.com/academy/ssh/authorized-keys-file) file on the remote machine.

```bash
# Get SSH key fingerprint
ssh-keyscan TODO

# Install systemd units
cp --verbose scripts/systemd/* /etc/systemd/system
systemctl daemon-reload

# Activate the service
systemctl enable ssh-tunnel.service
```

# Usage

The service is controlled using [systemctl](https://www.freedesktop.org/software/systemd/man/latest/systemctl.html#).

```bash
# Start
systemctl start ssh-tunnel.service

# Stop
systemctl stop ssh-tunnel.service
```

## Monitoring

To view the logs, use [journalctl](https://www.freedesktop.org/software/systemd/man/latest/journalctl.html).

For example, to show the last 40 lines of information: 

```bash
journalctl --unit=ssh-tunnel --lines=40
```
