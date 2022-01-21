#! /bin/sh

set -e

if [ "$#" -ne 1 ]; then
    echo "usage: $(basename "$0") ROM" 1>&2
    exit
fi
ROM="$1"

# update graphics
dd if=gfx/8FE0.bin of="$ROM" conv=notrunc bs=1 seek=36832
dd if=gfx/9210.bin of="$ROM" conv=notrunc bs=1 seek=37392

# update text
dd if=text/0076.bin of="$ROM" conv=notrunc bs=1 seek=118
dd if=text/076A.bin of="$ROM" conv=notrunc bs=1 seek=1898
dd if=text/0792.bin of="$ROM" conv=notrunc bs=1 seek=1938
dd if=text/079F.bin of="$ROM" conv=notrunc bs=1 seek=1951  # mask for TIME UP
dd if=text/07B0.bin of="$ROM" conv=notrunc bs=1 seek=1968
dd if=text/080E.bin of="$ROM" conv=notrunc bs=1 seek=2062
dd if=text/0D64.bin of="$ROM" conv=notrunc bs=1 seek=3428
dd if=text/9FC3.bin of="$ROM" conv=notrunc bs=1 seek=40899
