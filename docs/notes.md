# Spell-Master (Cambridge Z88) - technical notes

These notes accompany an annotated disassembly of the two code banks of Spell-Master, the spelling checker card for the Cambridge Z88. They record what could be established from the ROM and how sure we are of each point. The sources are `spell62.asm` and `spell63.asm`.

**Status.** Both files assemble with Mpm 2.1.1 to bytes identical to `bank_files/spell62.bin` and `spell63.bin`. Those are the original ROM banks with the bank-addressing fix described in section 5 (7 bytes changed in each); the other six banks are untouched. The card has been loaded as a 128K image in OZvm under OZ 5 (slot 1) and runs. Nothing described here about behaviour has been observed directly: it is read from the code. Every name and comment is an inference, not an original label.

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

The About text in bank 63 reads "Written by James Lynn", "Copyright (C) 1988 Computer Concepts Ltd.", "Cartridge version 1.05" and "10th August 1989", which appears to be the date of this version.

Both banks are assembled with ORG $C000 because each application's code bank is bound into segment 3. The front DOR is at $FFC0 (name "APPL") and the card header at $FFF8 (8 banks, "OZ" mark). In bank 63, offsets $003B-$0195 are real code between the two DORs.

## 2. QuickEdit

QuickEdit is a text editor with spell checking. `qe_start` creates memory pools with `OS_Mop`, allocates a 0xF8-byte current-line edit buffer and a 0xC2-byte block holding three work buffers (0x40, 0x42 and 0x40 bytes), sets the error handler, draws window 1 and enters `qe_main_loop`.

**Command dispatch.** The loop reads a key with `OS_Tin` (a timeout of 50). A zero byte means a command code follows. Some raw codes are translated first (`translate_key_code`): $C3 Delete line, $D3 Delete character, $F4/$F5 Start/End of line, $F8/$F9 Previous/Next word. The dispatch code (0 to 46) indexes 47 words at $D171 and the loop does `JP (HL)`. `docs/commands.md` lists all 46 commands with their handlers. The menu in bank 63 gives each command a code and the table gives each code a handler; where it could be cross-checked (far calls and text a handler uses, for example Information, Search, Print and Load text) the handler agrees with its name.

**Memory.** When `OS_Mal` cannot supply memory the editor shows "No Room!" (`show_no_room_error`) in window 2.

## 3. WordFinder

The menu offers four options: 1 Browse through dictionary, 2 Find anagrams, 3 Find close matches, 4 Solve crossword. Keys 1-4 select directly, cursor up/down moves `wf_menu_sel`, Enter runs it, Escape frees the pools and exits. The option routines are `wf_option_1_...` to `wf_option_4_...`. The window titles ("Anagram", "Find close matches", "Crossword") confirm which is which.

All four work on the ROM dictionary only: WordFinder has no user dictionary (`wf_start` clears `user_dict_ptr`). Words are typed with `input_wf_word` (up to 32 characters) and checked for bad characters (`bad_character`); results are printed by `show_found_word` in four 16-column slots per row, six rows to a page, with "Press SPACE to continue" between pages (an extended Escape there stops the search).

- **1 Browse through dictionary** is the QuickEdit Browse (section 15) almost instruction for instruction, with the same routine names. It starts at "AA" instead of a typed word, and where QuickEdit looks in the user dictionary it calls `no_user_word` ($E5DB), a stub that always answers "none". (Bank 62 holds an unused copy of the same stub as data at $F77E.)
- **2 Find anagrams** accepts letters only. It sorts the letters of the typed word (`sort_letters`, $C712), then for every word form of the same length in the whole dictionary sorts its letters too and compares. A key pressed during the search stops it (checked after each first letter).
- **3 Find close matches** is Guess correct word without the user dictionary: the same section filter and the same one-edit test (`section_could_match`, `is_one_edit_away`, copies of the bank 62 routines). It does not stop for a key press.
- **4 Solve crossword** takes a pattern of letters, apostrophes, `#` (any one letter) and `*` (any run of letters, including none). If the pattern starts with letters only those sections are searched. Matching backtracks to the most recent `*` on a mismatch; while it runs `line_rec_ptr` and `$1FEB` are borrowed as pointers into the pattern and the word. It does not stop for a key press either.

Bank 63 also has its own copies of the dialog routines: `open_dialog_with_title` ($EC90) with five window sizes (`open_dialog_centre`, `open_dialog_wide`, `open_dialog_mid`, `open_dialog_wf`, `open_dialog_right`).

## 4. Calls between the two banks

Some QuickEdit commands are implemented in bank 63. `far_call_bank63` (bank 62, $C286) takes an index in A, binds bank 63 into segment 1 and jumps to a stub at $7F80 (file offset $3F80 of SPELL.63). The stub binds that bank into segment 3 and enters `far_call_dispatch`, which looks the index up in `far_call_table` (11 words, bank 63 $D008), calls the routine and returns through a second stub that rebinds bank 62.

| index | routine | used by |
|---|---|---|
| 0 | far_information ($CD87) | Information |
| 2 | far_search_for_string ($D498) | Search for string |
| 3 | far_search_and_replace ($D19D) | Search and Replace |
| 4 | far_load_text_at_cursor ($D909) | Merge text at cursor |
| 6 | far_append_guess ($D880) | Guess correct word: append_guess at $E076 adds each guess to the list (section 15) |
| 7 | far_redraw_text_window ($C799) | draw_text_window, which redraw_screen calls (section 12) |
| 8 | far_tab ($D01E) | Tab |
| 9 | far_next_match ($D479) | Next Match |
| 10 | far_print_text ($D100) | Print out text |
| 1 | find_next_match ($D54F) | not called through the table; used directly by Search, Next Match and Search and Replace in bank 63 (section 17) |
| 5 | far_call_5_unused ($DB25) | nothing calls it; unreachable code (section 18) |

## 5. Dictionary access and bank addressing

The dictionary index entries are three bytes. Bits 7-5 of the first byte select one of six dictionary banks; the next two bytes are an offset in that bank. `bind_dictionary_bank` (identical copies in both banks) binds the bank into segment 2 and saves the bank in `dict_bank` ($1F84) and the offset in `dict_pos` ($1F82).

**The original code assumes the eight banks are at the top of one slot.** Four places compute a bank as "slot bits of the running bank OR a fixed number":

| # | where | what it does |
|---|---|---|
| 1 | bank 62 $C1B6 and bank 63 $C0BF | dictionary bank = slot bits OR ($38 + index) |
| 2 | bank 62 $C286 | bank 63 = slot bits OR $3F |
| 3 | bank 63 $FF8B (inside the stub) | bank 62 = slot bits OR $3E |

patters has published patches that make these relative to the running bank ("Spell-Master Fix Patches" on the Cambridge Z88 developer wiki); with them the card works in any slot and any eight consecutive banks. He notes that RAM-app support in OZ 4.6 to 5.0 does not guarantee consecutive banks, so it must run as a card application there. The banks in `bank_files/` already contain this fix, so the listing shows the patched instructions and the comment at each site gives the original ones. The changed bytes are: bank 62 `$C1CB-$C1CD` and `$C28C-$C28F`; bank 63 `$C0D4-$C0D6` and `$FF90-$FF93`.

## 6. Dictionary tokens

The dictionary stores common groups of letters as single bytes ($80 or more). The strings are kept in bank 62 from $C38A (each begins with a letter that has bit 7 set: "TION", then three-letter groups such as WAY, ITY, IES, MAN, IAN, ISM, FUL, IAL, ING, then two-letter groups) and `token_pointer_table` ($C4A4) indexes them; `append_token` ($C355) copies one out clearing bit 7. These looked like code in a first disassembly, and an earlier version of these notes wrongly called them suffix tables. See section 13.

## 7. Workspace

Both apps use the application workspace $1F80-$1FFF with the same layout. `docs/workspace.md` lists every address used and names those the code establishes: the buffer pointers, the pool handles, the dictionary position and bank, the current-line buffer, the cursor row, column limit, index and line length, the block markers, the cursor and top line numbers, the links around the cursor line and the working line-record pointer, the user dictionary, the ignored words and the user dictionary filename (see "How the text is stored" in section 12), `edit_flags` and `wf_menu_sel`, the file handle and filenames, the search strings, and a handful of scratch locations shared by several commands. Every address used now has a description; a few are only scratch space and some are borrowed for other purposes in particular commands (noted in the table).

## 8. RAM installation under OZ 5 (learned along the way)

From reading the OZ ROM (`ozs0-7e93476`) and the developer notes; untested.

- The RAM installer allocates each file separately (`OS_Fma`, any slot) and rewrites only the bank numbers in the application DOR.
- The loop in this build counts 0 to 6, so it appears to install seven files, not eight; `.ap7` (the first dictionary bank) would not be installed.
- Both points agree with patters' advice to run Spell-Master as a card.

## 9. How this was produced

1. The banks were disassembled with DZasm and reassembled with Mpm 2.1.1 at every step; a region was accepted as code only if the result stayed byte-identical. (The first analysis used DZasm 0.35; the sources are now generated with DZasm 0.36 and its OZ V5 definition files in `def/`.)
2. The command table, jump tables and far-call table were found by reading the code and the menu structures.
3. The annotations were added with DZasm commands and the source regenerated with `ca`. No post-processing is needed: the output assembles with `mpm -b -Idef`. The one workaround is that the two application DORs are kept as raw bytes (`dm defb`), because DZasm 0.36 writes their topic, command and help pointers with a `& $3FFF` mask, but this card stores them as full `$Cxxx` addresses (see `docs/dzasm-issues.md`). The project files in `dzasm/base/` are the un-annotated starting point; `dzasm/genasm.sh` (or `.bat`) copies them and applies the annotation commands once.
4. Names are given only where the evidence is direct: the table entry, the text a routine prints, the OZ calls it makes, or how its callers use it.

## 10. What is still unknown

- Most unnamed routines (`docs/routine_index_bank*.md`).
- Regions that decode as code may be data that happens to assemble; the byte-identical check cannot tell.
- Some names of scratch locations and borrowed variables describe their main use only.
- Behaviour has not been traced on a running machine. Worth testing in OZvm: the last word before Enter is not checked as you type (section 15); a failed search leaves the cursor at the end of the text (section 17).

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

**How the text is stored.** The cursor line is not in the chain: it lives in the edit buffer (`line_buffer`, `line_length`), and the chain is cut around it. `prev_line_ptr`/`prev_line_bank` ($1F9C/$1F9E) point at the record above it and `next_line_ptr`/`next_line_bank` ($1F9F/$1FA1) at the record below; a zero offset means there is none, so an empty text is `line_length` = 0 with both offsets zero (the test `cmd_load_text` makes before asking whether to discard the text). Moving to another line goes in two steps. `store_cursor_line` ($CCA2) writes the edit buffer into a new record (`alloc_line_record`, $CFE9, which links it between the two neighbours and leaves it in `line_rec_ptr`/`line_rec_bank`, $1FE8/$1FEA). Then the target record is put in `line_rec`, and `take_line_record` ($CCE2) copies its text into the edit buffer, takes its links as the new `prev_line`/`next_line` and frees it. `step_to_prev_record` ($ED76) and `step_to_next_record` ($ED9C) walk `line_rec` along the links, returning Z at either end. `store_cursor_line` (40 callers) and `take_line_record` (36) are among the most called routines in bank 62.

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

## 14. The user dictionary and ignored words

**In memory.** QuickEdit keeps two word lists with the same structure: the user dictionary (`user_dict_ptr`/`user_dict_bank`, $1FAC/$1FAE) and the ignored words (`ignore_list_ptr`/`ignore_list_bank`, $1FDA/$1FDC). Each is a 78-byte ($4E) table of 26 three-byte heads (bank, offset low, offset high), one per letter A-Z. Each head starts a linked list of word records in alphabetical order, allocated from `pool_main`:

| offset | size | contents |
|---|---|---|
| 0 | 1 | n = number of letters stored = word length - 1 |
| 1 | 3 | next record: bank, offset low, offset high (offset 0 = end of list) |
| 4 | n | the word without its first letter, which is given by the table slot |

The table is allocated and cleared the first time a word is added. The list routines only ever use `user_dict_ptr`; `swap_word_lists` ($FC71) exchanges the two pointers, and every use of the ignored words is a swap, the call and a swap back.

**Routines (bank 62).** `word_list_add` ($F88C) inserts the word in buffer A in alphabetical order (Z if it is already there, carry if it does not start with A-Z). `word_list_lookup` ($FBE3) finds a word (carry clear = found). `word_list_clear` ($FEC1) frees every record and clears the heads. `word_list_select_letter`, `word_list_first_from` and `word_list_next` walk the whole table in order; `L_F9DF` and `L_FADE` use them to look for nearby user words (purpose not yet confirmed).

**How the checker uses them.** `dictionary_lookup` tries the ROM dictionary first; if the word is not there it tries the user dictionary and then the ignored words ($C083). In the Correction menu, option 1 'Ignore word' adds the word to the ignored words and option 2 'Add word to user dictionary' to the user dictionary ($D5CA). When a check of the text ends ($D467) the ignored words are freed together with their table, so 'Ignore' lasts for one check; the user dictionary stays until it is replaced.

**The file.** Save user dictionary ($FC8E) writes plain text: for each letter A-Z and each word in order, a space, the first letter, the stored letters and a CR. Load user dictionary ($FD99) asks before discarding the current list, clears it (`word_list_clear`), then reads the file a byte at a time: every run of letters or apostrophes (`is_word_char`, upper-casing letters, at most 64) is a word and any other byte ends it. Words shorter than 3 characters are skipped, and each word goes through `word_list_add`, so any plain word list in any order and case can be loaded. The filename used is kept in a small record (`user_dict_name_ptr`/`user_dict_name_bank`, $1FD7/$1FD9), offered as the default filename by Save user dictionary and shown by Information.

## 15. Checking words, check as you type and guessing

**Taking a word from the text.** `next_word_from_text` ($D8CA) skips to the next letter or apostrophe and copies the word into buffer A through `is_word_char`, which turns every letter into upper case. **Capital letters therefore make no difference**: "london", "London" and "LONDON" are all checked as LONDON, and a proper noun is accepted only if it is in the dictionary or the user dictionary. Digits and other symbols end a word. A leading apostrophe is dropped, and the length passed to the lookup leaves out a final apostrophe or a final 'S, so JOHN'S is checked as JOHN. `word_start_ptr` ($1FBA) keeps where the word starts so it can be replaced, and `scan_chars_left` ($1FB7) counts what is left of the line. `find_word_start` ($DD33) moves back from the cursor to the start of the current word.

**Check as you type.** When it is on (`EF_CHECK_ON`, toggled by the Check as you type command and shown as Check: On/Off in the status panel) two hooks in the main loop do the work:

- `typing_check_char` ($DCA2) runs after every typed character. A letter or apostrophe sets `typing_word_pending` ($1FB1); any other character (space, punctuation, digit) ends the word and checks it.
- `typing_check_command` ($DC74) runs before every command. Rubout and Delete character mark the word as pending; the cursor movements (screen and cursor up/down/left/right, top/bottom of text, start/end of line, next/previous word) check a pending word before moving.

`typing_check_word` ($DCBD) takes the word before the cursor, upper case as always, drops a final 'S or apostrophe and looks it up (ROM dictionary, user dictionary, ignored words). Words of fewer than 3 letters are skipped. **A word that is not found only makes the Z88 beep** (BEL through `OS_Out`); the Correction menu is not opened. Read from the code and not yet tried on a machine: Enter goes straight to the new-line code without calling either hook, so the last word of a line, typed just before Enter, does not seem to be checked as you type.

**Correction menu.** When a word is not found the menu offers 1 Ignore word, 2 Add word to user dictionary, 3 Guess correct word, 4 Change word, 5 Browse through dictionary (section 14 covers 1 and 2).

**Guess correct word** (`guess_correct_word`, $DDBD) is a brute-force search for words one edit away from the typed word:

1. It goes through every section of the ROM dictionary, first letter A-Z and second letter apostrophe then A-Z, but searches only those where `section_could_match` ($E063) holds: the section's first or second letter equals the typed word's first or second letter. So a guess is found only if one of its first two letters equals one of the typed word's first two letters, in either position (a swap of the first two letters is still found; a word whose first two letters are both wrong is not).
2. In each section it produces every accepted form, endings included (`next_word_form`), and tests it with `is_one_edit_away` ($E090).
3. It then tests every word of the user dictionary the same way.
4. A key pressed during the search stops it (checked after each first letter).

`is_one_edit_away` accepts a word that is:

| typed word | accepted when | code |
|---|---|---|
| same length | one letter differs, or two adjacent letters are swapped (one swap) | $E0B3, $E0C0 |
| one letter shorter | one letter is missing | $E0EF |
| one letter longer | one letter is extra | $E10F |

Words whose length differs by two or more are rejected at once.

Each guess is added by `append_guess` ($E076), which is far call 6 (`far_append_guess`, bank 63 $D880). The list is a chain of records like the line records: byte 0 = word length, bytes 1-3 = previous guess, bytes 4-6 = next guess, then the word. Its head is `guess_list_ptr`/`guess_list_bank` ($1FC2/$1FC4). If there are none the routine shows "No Guesses found". Otherwise "Guesses found" lists them six at a time in the right-hand dialog (borrowing `top_line` as a row counter): up and down move the highlight, Enter takes the word (copied to buffer C), 1-5 jump to that Correction menu option and Escape cancels. `free_guess_list` ($DFF5) frees the list afterwards. `edit_flags` bit 6 ($40) is set when no word was chosen, and the caller then returns to the menu instead of replacing the word.

**Change word** (option 4, `change_word`, $D64A) opens "Replace with" with the word as it stands in the text (without a final 'S or apostrophe, which stay in the text) and lets you edit it.

**Replacing** (`replace_word_everywhere`, $D6D8, used by Change word and by a guess taken with Enter) shows "Replacing...", puts the new word in place of the old one and moves the block markers on that line to match. Each letter of the new word takes its case from the letter in the same position of the old word, so "teh" becomes "the" and "Teh" becomes "The". It then goes on to the end of the text and replaces every later occurrence of the same misspelling, in any capitalisation and keeping each one's case pattern, before returning to the original line.

**Browse through dictionary** (option 5, `browse_dictionary`, $F399) saves the typed word (`save_typed_word`, `saved_word_ptr`/`saved_word_bank`) and shows the dictionary around it in the right-hand window, with the current word highlighted (`draw_browse_page`). Letters typed build a prefix and the list jumps to the first word at or after it (`browse_seek_prefix`); Enter takes the highlighted word. Cursor up and down move one word (`browse_prev_word`/`browse_next_word`, which also bring in user dictionary words through `L_FADE`/`L_F9DF`; `$1FB3` bit 1 marks such a word); Screen up/down move a whole two-letter section and Top/Bottom of text a whole first letter. `browse_pos` ($1FAF) keeps the dictionary position of the current word so the list can step backwards through the packed records.

## 16. Word wrap and Format paragraph

`wrap_column` ($1FA3) is the right margin. It is set to 72 at start-up and nothing changes it, so QuickEdit always wraps at 72 columns (the text window is 74 wide).

`wrap_cursor_line` ($CD49) does the work. If the cursor line, ignoring trailing spaces, is longer than 72 it splits it at the last space at or before column 72 (or at column 72 if the line has no space there): the first part becomes a new line record above, the rest stays in the edit buffer, block markers move with their text, and it repeats. If the line fits, it pulls up the next line, or as many of its words as fit, unless the next line is empty or starts with a space; that is how a paragraph end is recognised. `line_counter` ($1FE5) counts the lines the cursor moves down.

`wrap_from_cursor_line` ($CD44) clears the counter and calls it. It is used:

- while typing, when a character takes the line past column 72 (word wrap as you type);
- by Format paragraph, which repeats it for each following line until a line that is empty or starts with a space;
- after Search and Replace, which rewraps every line of the text from the top;
- after Copy marked block and Delete marked block.

## 17. Search, Next Match and Search and Replace

These run in bank 63 through the far-call table. The last Find and Replace strings are kept in small records (`search_str_ptr`/`search_str_bank` $1FDD/$1FDF, `replace_str_ptr`/`replace_str_bank` $1FE0/$1FE2) and offered again the next time (`load_string_record`, `save_string_record`, `free_string_record`). Each string can be up to 63 characters.

**Searching** (`find_next_match`, $D54F, which is also far-call entry 1) starts at the cursor and compares characters exactly, so **the search is case-sensitive**, unlike the spelling check. A match may continue past the end of a line: when the line runs out the comparison carries on at the start of the next line. On a mismatch it returns to the line where the attempt started (`back_to_start_line`) and tries one character further on. When a match is found the cursor is put at its start. Read from the code and not yet tried: when nothing is found the lines already searched are not walked back, so the cursor is left at the end of the text.

- **Search for string** ($D498) asks for the string and searches (`start_search`).
- **Next Match** ($D479) searches again for the saved string from one character after the cursor.
- **Search and Replace** ($D19D) first asks "Global or selective ? (G/S)" (selective sets `$1FB3` bit 7), then for the Find and Replace strings (up and down move between the two fields). For each match, in selective mode, the text is redrawn and "Replace ? (Y/N)" asked: Y replaces, N moves on one character, Escape stops. A replacement is refused, and the search ends, if it would make the line 240 characters or longer. Afterwards QuickEdit rewraps the whole text from the top (section 16).

`save_string_record` does not check whether `OS_Mal` succeeded before writing into the new record.

## 18. Files, printing, Information and Tab

**Save text** (`cmd_save_text`, sharing `save_or_export` with Export text) writes the text as plain characters, each line followed by a CR ($0D). The file starts with the PipeDream option line `%CO:A,72,72%` (column A, width 72, right margin 72; `str_pipedream_header`), so a QuickEdit file opens in PipeDream with the same layout. The header is left out if the file that was loaded began with its own `%...%` option line (`own_header_flag`, $1FE3). If the file exists, "Overwrite text? (Y/N)" is asked first (`open_output_file`). The filename is kept (`text_name_ptr`/`text_name_bank`, $1FD4/$1FD6), offered next time, and its leaf name becomes the activity name in the Index (`name_activity`, DC_Nam).

**Export text** sets `edit_flags` bit 7 and uses the same code, but writes no header, does not keep the filename, and leaves out the CR after any line that ends in a space. Because word wrap leaves a space at the end of each wrapped line, every paragraph comes out as a single line: the form other programs expect.

**Save marked block** writes only the marked text, plain lines ending in CR, with no header.

**Load text** (`load_text_file`, $EDF7) frees the whole current text (`free_all_lines`) and reads the file a byte at a time:

- a first line that is exactly `%CO:A,72,72%` is dropped; a first line that starts with another `%...%` option (up to 15 characters) is kept as text and sets `own_header_flag`;
- lines end at CR only. A LF is kept as a character, so a file with CR LF line ends shows ^J at the start of each line after the first, and a file with LF only comes in as one long line cut into pieces;
- a line longer than 239 characters is cut into pieces of 239; lines are not rewrapped;
- reading stops at end of file or Escape. Any other read error makes it read again, which would loop if the error persisted.

**Merge text at cursor** (bank 63, $D909) reads a file the same way and inserts its lines at the cursor. It does not recognise the header, so `%CO:A,72,72%` would be merged as a line of text. It checks free memory before each line and stops when memory is nearly full; if the file cannot be opened it only beeps.

**Print out text** (bank 63, `far_print_text`) enables Escape detection, sends $05 `[` to the printer filter, then every line of the whole text followed by LF CR through `OS_Prt`, then $05 `]`, and disables Escape detection again. The $05 pairs appear to mark the start and end of the job for the printer filter. An error from `OS_Prt` (for example Escape) beeps and ends the printout. Tabs and control characters are passed through unchanged.

**Information** (bank 63, `far_information`) shows the text filename, number of lines, free memory in K (`NQ_Mfs`, pages divided by 4), word count and the user dictionary filename (or "None"). A word is a run of letters and apostrophes, so numbers are not counted. Counting walks the whole text; if a key is pressed meanwhile the line and word counts are left out.

**Tab** (bank 63, `far_tab`) uses stops every 8 columns. If the characters up to the next stop are all spaces the cursor just moves over them; otherwise spaces are inserted up to the stop. Insert real tab (command $2D) inserts a $09 character instead.

**Unreachable code.** Far-call entry 5 (`far_call_5_unused`, $DB25) is never called, and nothing else reaches the code from $DB25 to $DCFD (about 470 bytes). It looks a word up in the dictionary, positions at the first word not before it, and consults the user dictionary: probably left over from an earlier design. The "Opened file" string at $DB17 is unused too. Smaller unused pieces are noted in the source at bank 63 $C709 and $D756 and bank 62 $F77E.
