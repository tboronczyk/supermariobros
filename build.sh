#! /bin/bash

set -e

ORIG='Super Mario Bros. (World).nes'
ROM="supermariobros-eo.nes"
IPS="supermariobros-eo.ips"
FLIPS="wine /opt/floating/flips.exe"

echo "GENERATING ROM AND IPS FROM $ORIG..."
cp "$ORIG" "$ROM"

echo "Updating graphics..."
dd if=gfx/8FE0.bin of="$ROM" conv=notrunc bs=1 seek=$((0x8FE0))
dd if=gfx/9210.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9210))

echo "Updating text..."
dd if=text/0076.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0076))
dd if=text/076A.bin of="$ROM" conv=notrunc bs=1 seek=$((0x076A))
dd if=text/0792.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0792))
dd if=text/079F.bin of="$ROM" conv=notrunc bs=1 seek=$((0x079F))  # mask for TIME UP
dd if=text/07B0.bin of="$ROM" conv=notrunc bs=1 seek=$((0x07B0))
dd if=text/080E.bin of="$ROM" conv=notrunc bs=1 seek=$((0x080E))
dd if=text/0D64.bin of="$ROM" conv=notrunc bs=1 seek=$((0x0D64))
dd if=text/9FC3.bin of="$ROM" conv=notrunc bs=1 seek=$((0x9FC3))

echo "Generating patch..."
$FLIPS -c -i "$ORIG" "$ROM" "$IPS"

echo "Done"
