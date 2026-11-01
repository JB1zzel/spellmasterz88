@echo off
:: generates Z80 assembler sources, ready to be compiled by Mpm
dzasm --out .. ..\bank_files\spell62.bin -f annotate_bank62.cmd
dzasm --out .. ..\bank_files\spell63.bin -f annotate_bank63.cmd
