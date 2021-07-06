#!/bin/sh
## File Version v1.00

# Set timezone
echo "Set Timezone... "
if [ -z "$TIMEZONE" ]; then
    echo "  · NO timezone applied "
    echo "    Timezone by default"
else
    echo "  · Timezone applied - ${TIMEZONE}"
    ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime
    dpkg-reconfigure -f noninteractive tzdata
fi
echo "    Done..."

# Check DB Initialized
echo "Checking Backy2 DB... "
if [ "$(ls /var/lib/backy2/backy.sqlite)" ]; then
    echo "Backy2 DB already exists... "
else
    echo "Initialize the database... "
    backy2 initdb
fi

echo "    Done... Starting"

tail -f /dev/null