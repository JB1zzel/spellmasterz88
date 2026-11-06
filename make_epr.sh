#!/usr/bin/env bash
# Builds the 128K card image spell_rebuilt.epr: the six dictionary banks, then the two code banks rebuilt from the source.
mpm -b -ospell62_rebuilt.bin -Idef spell62.asm || exit 1
mpm -b -ospell63_rebuilt.bin -Idef spell63.asm || exit 1
cat bank_files/spell56.bin bank_files/spell57.bin bank_files/spell58.bin bank_files/spell59.bin \
    bank_files/spell60.bin bank_files/spell61.bin spell62_rebuilt.bin spell63_rebuilt.bin > spell_rebuilt.epr
ls -l spell_rebuilt.epr
