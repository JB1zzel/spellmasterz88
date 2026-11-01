# Spell-Master (Cambridge Z88) - technical notes

These notes accompany an annotated disassembly of the two code banks of Spell-Master, the spelling checker card for the Cambridge Z88. They record what could be established from the ROM and how sure we are of each point. The sources are `spell62.asm` and `spell63.asm`.

**Status.** Both files assemble with Mpm 2.1.1 to bytes identical to the original `SPELL.62` and `SPELL.63`. The card has been loaded as a 128K image in OZvm under OZ 5 (slot 1) and runs. Nothing described here about behaviour has been observed directly: it is read from the code. Every name and comment is an inference, not an original label.

**Where the annotations live.** The names, comments, workspace names and operand expressions are DZasm commands (`dl`, `rem`, `dc`, `de`), stored in the DZasm collect files (`dzasm/spell62.clt`, `dzasm/spell63.clt`) and listed in `dzasm/annotate_bank62.cmd` and `annotate_bank63.cmd`. The equates they use are in `defs/spell_names.def`.

## 1. Layout of the card

The card is 128K, eight 16K banks. The file extension is the bank number relative to the card ($38-$3F):

| file | bank | contents |
|---|---|---|
| SPELL.63 | $3F | card header, front DOR, both application DORs, QuickEdit menu text, the WordFinder application, shared routines |
| SPELL.62 | $3E | most of QuickEdit |
| SPELL.61 to SPELL.56 | $3D to $38 | the dictionary (six banks, data only, not disassembled) |

The application DORs are in bank 63:

| DOR | key | entry | segment 3 bank |
|---|---|---|---|
| QuickEdit, at $C001 | Q | $C000 | $3E (SPELL.62) |
| WordFinder, at $C196 | W | $C1D1 | $3F (SPELL.63) |

Both banks are assembled with ORG $C000 because each application's code bank is bound into segment 3. The front DOR is at $FFC0 (name "APPL") and the card header at $FFF8 (8 banks, "OZ" mark). In bank 63, offsets $003B-$0195 are real code between the two DORs.

## 2. QuickEdit

QuickEdit is a text editor with spell checking. `qe_start` creates memory pools with `OS_Mop`, allocates a 0xF8-byte current-line edit buffer and a 0xC2-byte block holding three work buffers (0x40, 0x42 and 0x40 bytes), sets the error handler, draws window 1 and enters `qe_main_loop`.

**Command dispatch.** The loop reads a key with `OS_Tin` (a timeout of 50). A zero byte means a command code follows. Some raw codes are translated first (`translate_key_code`): $C3 Delete line, $D3 Delete character, $F4/$F5 Start/End of line, $F8/$F9 Previous/Next word. The dispatch code (0 to 46) indexes 47 words at $D171 and the loop does `JP (HL)`. `docs/commands.md` lists all 46 commands with their handlers. The menu in bank 63 gives each command a code and the table gives each code a handler; where it could be cross-checked (far calls and text a handler uses, for example Information, Search, Print and Load text) the handler agrees with its name.

**Memory.** When `OS_Mal` cannot supply memory the editor shows "No Room!" (`show_no_room_error`) in window 2.

## 3. WordFinder

The menu offers four options: 1 Browse through dictionary, 2 Find anagrams, 3 Find close matches, 4 Solve crossword. Keys 1-4 select directly, cursor up/down moves `wf_menu_sel`, Enter runs it, Escape frees the pools and exits. The option routines are `wf_option_1_...` to `wf_option_4_...`. The window titles ("Anagram", "Find close matches", "Crossword") confirm which is which.

## 4. Calls between the two banks

Some QuickEdit commands are implemented in bank 63. `far_call_bank63` (bank 62, $C286) takes an index in A, binds bank 63 into segment 1 and jumps to a stub at $7F80 (file offset $3F80 of SPELL.63). The stub binds that bank into segment 3 and enters `far_call_dispatch`, which looks the index up in `far_call_table` (11 words, bank 63 $D008), calls the routine and returns through a second stub that rebinds bank 62.

| index | routine | used by |
|---|---|---|
| 0 | far_information ($CD87) | Information |
| 2 | far_search_for_string ($D498) | Search for string |
| 3 | far_search_and_replace ($D19D) | Search and Replace |
| 4 | far_load_text_at_cursor ($D909) | Merge text at cursor |
| 6 | far_call_6 ($D880) | called from bank 62 at $E076; purpose not identified |
| 7 | far_redraw_text_window ($C799) | draw_text_window, which redraw_screen calls (section 12) |
| 8 | far_tab ($D01E) | Tab |
| 9 | far_next_match ($D479) | Next Match |
| 10 | far_print_text ($D100) | Print out text |
| 1, 5 | $D54F, $DB25 | not used by bank 62 |

## 5. Dictionary access and bank addressing

The dictionary index entries are three bytes. Bits 7-5 of the first byte select one of six dictionary banks; the next two bytes are an offset in that bank. `bind_dictionary_bank` (identical copies in both banks) binds the bank into segment 2 and saves the bank in `dict_bank` ($1F84) and the offset in `dict_pos` ($1F82).

**The original code assumes the eight banks are at the top of one slot.** Four places compute a bank as "slot bits of the running bank OR a fixed number":

| # | where | what it does |
|---|---|---|
| 1 | bank 62 $C1B6 and bank 63 $C0BF | dictionary bank = slot bits OR ($38 + index) |
| 2 | bank 62 $C286 | bank 63 = slot bits OR $3F |
| 3 | bank 63 $FF8B (inside the stub) | bank 62 = slot bits OR $3E |

patters has published patches that make these relative to the running bank ("Spell-Master Fix Patches" on the Cambridge Z88 developer wiki); with them the card works in any slot and any eight consecutive banks. He notes that RAM-app support in OZ 4.6 to 5.0 does not guarantee consecutive banks, so it must run as a card application there. The sources here are the original code; the places are marked.

## 6. Dictionary tokens

The dictionary stores common groups of letters as single bytes ($80 or more). The strings are kept in bank 62 from $C38A (each begins with a letter that has bit 7 set: "TION", then three-letter groups such as WAY, ITY, IES, MAN, IAN, ISM, FUL, IAL, ING, then two-letter groups) and `token_pointer_table` ($C4A4) indexes them; `append_token` ($C355) copies one out clearing bit 7. These looked like code in a first disassembly, and an earlier version of these notes wrongly called them suffix tables. See section 13.

## 7. Workspace

Both apps use the application workspace $1F80-$1FFF with the same layout. `docs/workspace.md` lists every address used and names those the code establishes: the buffer pointers, the pool handles, the dictionary position and bank, the current-line buffer, the cursor row, column limit, index and line length, the block markers, the cursor and top line numbers, `edit_flags` and `wf_menu_sel`. The rest are unidentified.

## 8. RAM installation under OZ 5 (learned along the way)

From reading the OZ ROM (`ozs0-7e93476`) and the developer notes; untested.

- The RAM installer allocates each file separately (`OS_Fma`, any slot) and rewrites only the bank numbers in the application DOR.
- The loop in this build counts 0 to 6, so it appears to install seven files, not eight; `.ap7` (the first dictionary bank) would not be installed.
- Both points agree with patters' advice to run Spell-Master as a card.

## 9. How this was produced

1. The banks were disassembled with DZasm 0.35 and reassembled with Mpm 2.1.1 at every step; a region was accepted as code only if the result stayed byte-identical. (Mpm was built on Linux with a compiler overflow check switched off, because the stock build aborts on the `oz` macro. The sources avoid that macro.)
2. The command table, jump tables and far-call table were found by reading the code and the menu structures.
3. The annotations were added with DZasm commands and the source regenerated with `ca`. A small script (`fixmpm.py`) then makes three adjustments: it writes the apostrophe character as `$27`, expands the `oz` and `fpp` calls to plain `rst` and the call number, and keeps the topic and command pointers as the card stores them.
4. Names are given only where the evidence is direct: the table entry, the text a routine prints, the OZ calls it makes, or how its callers use it.

## 10. What is still unknown

- The purpose of far call 6 and most unnamed routines (`docs/routine_index_bank*.md`).
- The user dictionary format (the Save and Load user dictionary commands), and how the checker treats capital letters.
- Regions that decode as code may be data that happens to assemble; the byte-identical check cannot tell.
- Most workspace variables.
- Behaviour has not been traced on a running machine.

## 13. The dictionary

Fully described in `docs/dictionary.md`; in brief. The six dictionary banks (SPELL.56 to SPELL.61) hold 32,497 words in 302 sections, one for each two-letter start. `first_letter_index` ($E84E) leads to a list of three-byte entries (second letter, bank, offset) for each first letter. A section is a run of records in alphabetical order. Each record is a first byte (the number of letters to keep from the previous word, plus a bit meaning "takes -S") followed by the new letters, where a byte of $80 or more is a token for a group of letters and a byte of $10-$16 is an inflection class naming the endings that can be added (for example $13 = E, ED, ES, ING for a stem such as SIZZL). A $0F ends the section. With the endings added the checker accepts 57,971 distinct words, including British -ISE and -IZE spellings and 45 contractions. `dictionary_lookup` scans one section, comparing each expanded word with the target and stopping as soon as a word is greater, because the words are sorted.

`tools/spelldict.py` reads the ROM files and lists the words, the stems with their classes, or every accepted form. It was checked on the whole dictionary: every section ends exactly where the next one starts and the words come out in order. It reads the data but does not modify the ROM.

## 11. Rights

Spell-Master is Cambridge Computer's software. This disassembly and the extraction tool are research aids for people who already have the ROM. The word list itself is not included here. Check before redistributing any of it.

## 12. How the screen is drawn

**Screen model.** The Z88 screen is 8 rows by 94 columns. QuickEdit uses three windows (`docs/screen.md` lists every control string, decoded):

| window | position and size | type | used for |
|---|---|---|---|
| 1 | x 0, y 0, 74 x 8 | $81 (bars) | the text |
| 2 | x 75, y 0, 19 x 8 | $80 | side panel: the line number and status |
| 3 | x 0 or 37, y 1, 37 x 7 | $80 or $83 | pop-up dialogs, some with a title bar |

Coordinates sent to the screen driver have 32 added (`SD_COORD`). Window 1 is redefined by printing a control string (`str_define_window1`) with `GN_Sop`.

**When a redraw happens.** After each key read, `handle_os_error` ($D089) receives any OZ error. `RC_Draw` means the screen was corrupted (another application ran): it prints the window 1 definition again, sets the redraw state in `edit_flags` to "requested" ($02) and calls `redraw_screen`. `RC_Quit` frees the three pools and exits with `OS_Bye`. A redraw is also called directly after most editing commands.

**`redraw_screen` ($D241).** 1) `draw_text_window` ($D06F), which is `LD A,7` and a far call to `far_redraw_text_window` in bank 63. 2) `draw_status_line` ($D0F7). 3) `place_cursor` ($D247).

**`far_redraw_text_window` ($C799).** The text is a chain of line records in banked memory: byte 0 is the record length (text length + `LINE_HDR_SIZE`, 7), bytes 1-3 the previous line (bank, offset low, offset high), bytes 4-6 the next line, and the text from byte 7. The cursor line itself is held in the edit buffer. The routine:
1. works out `top_line` = `cursor_line` - `cursor_row` (clamped at line 0, in which case `cursor_row` becomes `cursor_line`);
2. draws the cursor line at `cursor_row` (`draw_cursor_line`, $C7C5);
3. walks back from the cursor line, `cursor_row` records, to find the line for row 0;
4. draws rows 0 to 7 in order: positions the cursor at (0, row), copies the line to the window up to the window width (`cursor_col_limit`), pads the rest of the row with spaces, then follows the next-line pointer;
5. when the chain ends it draws the End of text marker in reverse video (`draw_end_of_text_marker`) and blanks the rows below (`clear_remaining_rows`);
6. sets the redraw state to "finished" ($04).

It appears to check for a waiting key with `OS_Xin` and stop early, so typing is not held up.

**Horizontal scrolling.** `draw_cursor_line` shifts a long line left so the cursor stays on screen: if `cursor_index` is at or beyond `cursor_col_limit`, the first `cursor_index - cursor_col_limit` characters are skipped. `place_cursor` puts the cursor at column min(`cursor_col_limit`, `cursor_index`), row `cursor_row`.

**Characters.** `put_text_char` ($C948) sends printable characters with `OS_Out`. A control character (below 32) is shown as the letter code + 64 in reverse video.

**Marked blocks.** `order_block_markers` ($C9FC) swaps the block markers if the end comes before the start. `highlight_block_on_row` ($CA36) applies reverse video over the part of the block on the row just drawn, using the "toggle over N characters" sequence.

**Status line.** `draw_status_line` redefines and clears window 2, prints the number `cursor_line + 1`, then in tiny type shows Insert or Overtype on row 7 (`edit_flags` bit 0) and Check: On or Off on row 6 (bit 4), and selects window 1 again.

**Dialogs.** `open_dialog_with_title` ($FF61) draws window 3 as an outer window (type $83), prints the title centred, makes the title line reverse across 75 characters, then redefines window 3 as an inner window (type $81) below the title. `dialog_window_right` and `dialog_window_left` open a plain window 3 in the right (x 37) or left (x 0) half. Which of the two a caller uses depends on the caller; nothing in the code selects by cursor position.
