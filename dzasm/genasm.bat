@echo off
rem Regenerates ..\spell62.asm and ..\spell63.asm from the annotation commands.
rem It starts from the un-annotated projects in base\ every time, so the comments never pile up.
rem Needs DZasm V0.36 or later on the PATH.
cd /d "%~dp0"
for %%b in (62 63) do (
    copy /y base\spell%%b.clt spell%%b.clt >nul
    dzasm --out .. ..\bank_files\spell%%b.bin -f annotate_bank%%b.cmd
)
