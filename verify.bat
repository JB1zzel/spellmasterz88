@echo off
:: Reassembles both annotated files with Mpm and compares the results with the original ROM banks.
mpm -b -ospell63_rebuilt.bin -Idef spell63.asm
mpm -b -ospell62_rebuilt.bin -Idef spell62.asm
fc /b spell63.bin spell63_rebuilt.bin
fc /b spell62.bin spell62_rebuilt.bin
