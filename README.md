# Bee tracker SSH tunnel service

This repository contains [systemd](https://systemd.io/) units that define a service to maintain a permanent SSH
reverse tunnel.

# Installation

## On the server

You must list the public key in the [`authorized_keys`](https://www.ssh.com/academy/ssh/authorized-keys-file) file on
the remote machine.

To restrict the permissions of the connecting user, specify that they can't run any commands and may only connect from
a restricted range of addresses. See: [Configuring Authorized Keys for OpenSSH](https://www.ssh.com/academy/ssh/authorized-keys-openssh)

```
from="$address",command="$command" $ssh_public-key
```

For example:

```
from="132.235.0.0/16",command="/bin/true" ssh-rsa AAAAB3Nza...cDR5yDhRte2SWk=
```

## On the client

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
