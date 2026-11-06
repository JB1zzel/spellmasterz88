Reproduces the corrupt area list (docs/dzasm-issues.md, point 2).

From this folder:
    dzasm ../../../bank_files/spell62.bin -c "dm defb C336 C4A3" -c aa

Expected: the whole range C336-C4A3 becomes one defb area.
Seen (DZasm 0.35 and 0.36): only part of it is converted, many program areas remain between,
an area with its end before its start appears (C4A8h-C38Dh) and the resolved percentage falls below 100.
