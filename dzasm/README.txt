DZasm project files and the annotation commands.

spell62.clt / spell63.clt    the DZasm collect files, with all names, comments, constants and expressions
annotate_bank62.cmd / 63.cmd the dl / rem / dc / de / di commands that were applied (plain text; one per line)
fixmpm.py                    the small adjustments made to DZasm's output for Mpm (see NOTES.md section 9)

To regenerate a source file (copy ../spell6x.bin here first, and run from this folder):
    dzasm spell62.bin -c ca
    python3 fixmpm.py spell62.asm
    mpm -mz80 -b -I../defs spell62.asm

To reapply the annotations to a fresh DZasm project: dzasm spell62.bin -f annotate_bank62.cmd
(needs the un-annotated project first). The equates are in ../defs/spell_names.def.
