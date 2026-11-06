#!/bin/sh
# Regenerates ../spell62.asm and ../spell63.asm from the annotation commands.
# It starts from the un-annotated projects in base/ every time, so the comments never pile up.
# Needs DZasm V0.36 or later (set DZASM=/path/to/dzasm if it is not on the PATH).
cd "$(dirname "$0")" || exit 1
DZASM=${DZASM:-dzasm}
for b in 62 63; do
    cp base/spell$b.clt spell$b.clt || exit 1
    $DZASM --out .. ../bank_files/spell$b.bin -f annotate_bank$b.cmd || exit 1
done
