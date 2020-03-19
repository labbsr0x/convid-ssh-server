#!/bin/bash

# set -x
set -e

if [ "$ACCOUNTS_API_URL" == "" ]; then
    echo "ENV ACCOUNTS_API_URL is required"
    exit 1
fi

echo $ACCOUNTS_API_URL > /api.url

# generate host keys if not present
ssh-keygen -A

#fix bug in ssh
if [ ! -d /var/run/sshd ]; then
   mkdir /var/run/sshd
   chmod 0755 /var/run/sshd
fi

echo "Starting SSH server..."
exec /usr/sbin/sshd -D -e

