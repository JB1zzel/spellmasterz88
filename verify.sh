#!/bin/sh
mpm -mz80 -b -ospell63_rebuilt.bin -Idefs spell63.asm && cmp spell63.bin spell63_rebuilt.bin && echo "bank 63 identical"
mpm -mz80 -b -ospell62_rebuilt.bin -Idefs spell62.asm && cmp spell62.bin spell62_rebuilt.bin && echo "bank 62 identical"
