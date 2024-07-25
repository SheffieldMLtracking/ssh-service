# Bee tracker SSH tunnel service

This repository contains [systemd](https://systemd.io/) units that define a service to maintain a permanent SSH
reverse tunnel.

# Installation

To set up the service, please follow the following steps on the local machine and remote host.

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

If we trust the server and know its fingerprint is correct, we can add its SSH key fingerprint to our known_hosts file
using [ssh-keyscan](https://manpages.debian.org/bookworm/openssh-client/ssh-keyscan.1.en.html).

```bash
# Get SSH key fingerprint
remote_host="TODO"
ssh-keyscan -H $remote_host >> ~/.ssh/known_hosts

# Install systemd units
cp --recursive --verbose scripts/systemd/* /etc/systemd/system
systemctl daemon-reload

# Activate the service
systemctl enable ssh-tunnel.service
```

### Configuration

Edit the environment variables in the systemd override configuration files
located at `/etc/systemd/system/ssh-tunnel.service.d/*.conf`

# Usage

The service is controlled using [systemctl](https://www.freedesktop.org/software/systemd/man/latest/systemctl.html#).

```bash
# Start
systemctl start ssh-tunnel.service

# Stop
systemctl stop ssh-tunnel.service
```

## Monitoring

To view the service status, use `systemctl` like so:

```bash
systemctl status ssh-tunnel
```

To view the logs, use [journalctl](https://www.freedesktop.org/software/systemd/man/latest/journalctl.html).

For example, to show the last 40 lines of information: 

```bash
journalctl --unit=ssh-tunnel --lines=40
```
