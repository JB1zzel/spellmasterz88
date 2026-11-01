#!/usr/bin/env bash
mpm -b -ospell63_rebuilt.bin -Idef spell63.asm && cmp spell63.bin spell63_rebuilt.bin && echo "bank 63 identical"
mpm -b -ospell62_rebuilt.bin -Idef spell62.asm && cmp spell62.bin spell62_rebuilt.bin && echo "bank 62 identical"
