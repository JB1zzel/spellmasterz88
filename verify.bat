@echo off
rem Reassembles both annotated files with Mpm and compares the results with the original ROM banks.
mpm -mz80 -b -ospell63_rebuilt.bin -Idefs spell63.asm
mpm -mz80 -b -ospell62_rebuilt.bin -Idefs spell62.asm
fc /b spell63.bin spell63_rebuilt.bin
fc /b spell62.bin spell62_rebuilt.bin
