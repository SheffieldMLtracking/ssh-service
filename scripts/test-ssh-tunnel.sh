#!/bin/bash
set -e

# Test script to create a reverse SSH tunnel.
# It will establish a connection to the remote host and configure port forwarding.
# This will bind a port ($bind_port) on the remote host to a port on your machine (localhost).

destination="com@iot.bugtrack.org.uk"
identity_file="/home/joe/.ssh/bt/com.pem"
bind_port=5033
remote_port=22

# Test SSH connection can be established
# https://manpages.ubuntu.com/manpages/xenial/man1/ssh.1.html
ssh $destination -i $identity_file

# Establish reverse tunnel
# This will allow you, from the remote machine, to connect to port $bind_port
# and the connection will be forwarded to port 22 on localhost.
ssh $destination -i $identity_file -R $bind_port:localhost:$remote_port -NT -o ServerAliveInterval=20 -o ServerAliveCountMax=3 -o ExitOnForwardFailure=yes
