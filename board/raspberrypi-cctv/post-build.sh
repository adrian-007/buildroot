#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

if [ -L ${TARGET_DIR}/var/spool ];
then
    rm -f ${TARGET_DIR}/var/spool
    mkdir ${TARGET_DIR}/var/spool
fi

mkdir -p ${TARGET_DIR}/var/spool/cron/crontabs
