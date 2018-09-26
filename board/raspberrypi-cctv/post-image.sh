#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
CMDLINE_TXT_FILENAME="cmdline.txt"
CONFIG_TXT_FILENAME="config.txt"

for arg in "$@"
do
	case "${arg}" in
		--enable-nfs-booting)
			CMDLINE_TXT_FILENAME="cmdline.nfs.txt"
			CONFIG_TXT_FILENAME="config.nfs.txt"
		;;
		*)
			echo "Unknown option ${arg}"
		;;
	esac
done

if [ -f $BOARD_DIR/rpi-firmware/config.txt ];
then
	echo "Replacing firmware config.txt..."
	cp -fv ${BOARD_DIR}/rpi-firmware/${CONFIG_TXT_FILENAME} ${BINARIES_DIR}/rpi-firmware/config.txt
fi

if [ -f ${BOARD_DIR}/rpi-firmware/cmdline.txt ];
then
	echo "Replacing firmware cmdline.txt..."
	cp -fv ${BOARD_DIR}/rpi-firmware/${CMDLINE_TXT_FILENAME} ${BINARIES_DIR}/rpi-firmware/cmdline.txt
fi

rm -rf "${GENIMAGE_TMP}" &>/dev/null

echo "Creating extra partition image"
rm -f ${BINARIES_DIR}/mnt-data.ext4 2>/dev/null
dd if=/dev/zero of=${BINARIES_DIR}/mnt-data.ext4 bs=1M count=8
mkfs.ext4 ${BINARIES_DIR}/mnt-data.ext4

find "${TARGET_DIR}" -type f -name '.keep' -delete

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
