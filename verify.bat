@echo off
:: Reassembles both annotated files with Mpm and compares the results with the banks in bank_files.
mpm -b -ospell63_rebuilt.bin -Idef spell63.asm
mpm -b -ospell62_rebuilt.bin -Idef spell62.asm
fc /b bank_files\spell63.bin spell63_rebuilt.bin
fc /b bank_files\spell62.bin spell62_rebuilt.bin
