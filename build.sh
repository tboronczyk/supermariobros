#! /bin/bash

set -e

ORIG='Super Mario Bros. (World).nes'
ROM="supermariobros-eo.nes"
IPS="supermariobros-eo.ips"
FLIPS="wine /opt/floating/flips.exe"

echo "GENERATING ROM AND IPS FROM $ORIG..."
cp "$ORIG" "$ROM"

echo "Updating CHR..."
dd if=chr/1up.bin of="$ROM" conv=notrunc bs=1 seek=$((0x8FE0))
dd if=chr/cxgxsx.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9210))

echo "Updating PRG..."
dd if=prg/dialog-ptr.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0076))
dd if=prg/dialog-txt.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0D64))
dd if=prg/header.bin of="$ROM" conv=notrunc bs=1 seek=$((0x076A))
dd if=prg/timeup-mask.bin of="$ROM" conv=notrunc bs=1 seek=$((0x079F))
dd if=prg/gametxt-ptr.bin of="$ROM" conv=notrunc bs=1 seek=$((0x080E))
dd if=prg/gametxt-text-1.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0792))
dd if=prg/gametxt-text-2.bin of="$ROM" conv=notrunc bs=1 seek=$((0x07B0))
dd if=prg/titlescreen.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9FC3))

echo "Generating patch..."
$FLIPS -c -i "$ORIG" "$ROM" "$IPS"

echo "Done"
