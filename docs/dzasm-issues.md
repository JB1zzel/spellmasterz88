# DZasm issues found while working on Spell-Master

Found with DZasm 0.35 and rechecked with 0.36. The first two matter for this project; the others are smaller.

## 1. Application DOR pointers are masked with `& $3FFF` (0.35 and 0.36)

`mth frontdor` decodes each application DOR and writes the topic, command and help pointers as `defp name & $3fff,$3f`. On this card the stored values are full addresses in the bound segment (`EB E6 3F` for `$E6EB`, not `EB 26 3F`), so the masked form assembles to different bytes (six bytes differ in SPELL.63).

Reproduce: start a new project on `bank_files/spell63.bin` with `--org C000`, run `mth romhdr`, `mth frontdor`, `ca`, and compare line `defp QuickEdit_topics & $3fff,$3f` with the bytes at `$C022`. The `de` command has no effect on the fields inside a decoded DOR. The repo works around it by converting the two DORs to raw bytes (`dm defb C001 C03A`, `dm defb C196 C1D0`) and describing the fields in comments.

Suggestion: only mask when the stored high bits are clear, or write the pointer as it appears in the file.

## 2. `dm` over a range that crosses many areas leaves a corrupt area list (0.35 and 0.36)

`dm defb C336 C4A3` on a project where that range holds many small `program` and `defb` areas converts only some of them and leaves an area whose end is before its start (seen as `C4A8h-C38Dh [defb]` in `aa`); the resolved percentage drops. The output still assembles, so it is easy to miss. Splitting the command into one `dm` per existing area avoids it.

Reproduce: `dzasm/repro/area_bug/` has a collect file and the command (see its README).

## 3. `rem` is not idempotent

Running the same `rem` commands again adds the comments again (the project file grows and each comment appears twice, then three times). That is why `dzasm/genasm.sh` always starts from the un-annotated project in `dzasm/base/`. A command to clear the comments at an address, or making an identical `rem` a no-op, would help.

## 4. Smaller points

- A character constant for the byte `$7F` is written as a quote pair around the raw DEL character, which is invisible in an editor. Mpm 2.1.1 accepts it (the banks assemble to identical bytes), but `$7F` would be clearer.
- The byte `$27` is written as `'''`. Mpm 2.1.1 accepts that too.
- `dm defm` over text that contains a double quote produced a line Mpm rejected in 0.35. In 0.36 it works: the quote is written as the character constant `'"'` between the quoted parts, and Mpm 2.1.1 assembles it to the same bytes (checked on the Find, Replace and Replace ? strings in bank 63).
- `dm defm` on an area that does not start at a label adds a label there (`L_xxxx`) even though nothing refers to it. Harmless, but it adds unused labels to the listing (six in this project: bank 62 $D155, $F04E, $FE75; bank 63 $C740, $D52B, $EB17).
- The `Unknown instruction at <addr>` message can print thousands of times when a long list of `pp` commands runs into data; printing each address once would help.
