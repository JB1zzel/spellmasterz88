# Application workspace ($1F80-$1FFF, segment 0)

Both applications use the same layout. 'refs' counts instructions naming the address (bank 62 / bank 63). Names are given only where the code shows what the variable is; the equates are in defs/spell_names.def.

| address | name | size | refs 62/63 | meaning |
|---|---|---|---|---|
| $1F82 | dict_pos | 2 | 27/29 | Position (offset) within the current dictionary bank; loaded from the dictionary index entry |
| $1F84 | dict_bank | 1 | 1/1 | Absolute bank number of the dictionary bank currently bound into segment 2 |
| $1F85 | dict_target_length | 1 | 45/32 | Length of the word being looked up (two is subtracted once its first two letters select the section) |
| $1F86 | dict_letter1 | 1 | 35/37 | First letter of the word being looked up (ASCII) |
| $1F87 | dict_letter2 | 1 | 27/39 | Second letter of the word being looked up (ASCII, or apostrophe) |
| $1F88 | dict_word_length | 1 | 24/28 | Length of the dictionary word just expanded into buffer C |
| $1F89 | dict_word_flags | 1 | 26/30 | Inflection class of the expanded word: bit 7 set plus $10-$16, or 0 for none |
| $1F8A | dict_ending_ptr | 2 | 12/12 | Pointer into the current inflection class ending list |
| $1F8C | dict_stem_length | 1 | 24/12 | Length of the stem before an ending is appended |
| $1F8D | ptr_buffer_b | 2 | 7/8 | Pointer to a 0x42-byte work buffer (second part of the 0xC2-byte block) |
| $1F8F | ptr_buffer_c | 2 | 39/32 | Pointer to a 0x40-byte work buffer (third part of the 0xC2-byte block) |
| $1F91 | ptr_buffer_a | 2 | 40/35 | Pointer to a 0x40-byte work buffer (first part of the 0xC2-byte block; also the typed word in WordFinder) |
| $1F93 | pool_buffers | 2 | 3/5 | Memory pool handle for the 0xC2-byte buffer block |
| $1F95 |  |  | 4/2 | (not yet identified) |
| $1F97 |  |  | 26/3 | (not yet identified) |
| $1F99 | line_buffer | 2 | 49/18 | Pointer to the current-line edit buffer (0xF8 bytes, allocated at start-up) |
| $1F9B | line_buffer_bank | 1 | 13/1 | Bank of the current-line edit buffer |
| $1F9C |  |  | 27/7 | (not yet identified) |
| $1F9E |  |  | 19/6 | (not yet identified) |
| $1F9F |  |  | 52/9 | (not yet identified) |
| $1FA1 |  |  | 35/7 | (not yet identified) |
| $1FA2 | cursor_row | 1 | 32/14 | Screen row (0 to 7) of the cursor line in window 1 |
| $1FA3 |  |  | 8/1 | (not yet identified) |
| $1FA4 | cursor_col_limit | 1 | 5/8 | Screen column at which the cursor stops while the line scrolls sideways; also the number of columns drawn per row |
| $1FA5 | cursor_index | 1 | 58/36 | Cursor position as a character index within the current line |
| $1FA6 | line_length | 1 | 112/34 | Length of the current line in characters |
| $1FA7 | pool_main | 2 | 20/14 | Memory pool handle #1 (created first with OS_Mop) |
| $1FA9 | pool_second | 2 | 3/5 | Memory pool handle #2 (created second with OS_Mop) |
| $1FAB | edit_flags | 1 | 65/9 | QuickEdit flags: bit 0 = overtype mode (toggled by Insert/Over), bit 4 = check-as-you-type on, bits 1-3 (mask $0E) = screen redraw state (2 = redraw requested, 4 = redraw finished) |
| $1FAC |  |  | 20/4 | (not yet identified) |
| $1FAE |  |  | 13/2 | (not yet identified) |
| $1FAF |  |  | 15/15 | (not yet identified) |
| $1FB1 |  |  | 5/0 | (not yet identified) |
| $1FB3 |  |  | 9/13 | (not yet identified) |
| $1FB4 |  |  | 3/0 | (not yet identified) |
| $1FB5 |  |  | 3/0 | (not yet identified) |
| $1FB7 |  |  | 21/0 | (not yet identified) |
| $1FB8 |  |  | 16/0 | (not yet identified) |
| $1FBA |  |  | 5/0 | (not yet identified) |
| $1FBC |  |  | 24/8 | (not yet identified) |
| $1FBD |  |  | 0/3 | (not yet identified) |
| $1FBE |  |  | 17/3 | (not yet identified) |
| $1FBF |  |  | 11/9 | (not yet identified) |
| $1FC1 |  |  | 10/8 | (not yet identified) |
| $1FC2 |  |  | 6/1 | (not yet identified) |
| $1FC4 |  |  | 6/1 | (not yet identified) |
| $1FC8 | block_start_line | 2 | 32/9 | Block start marker: line number |
| $1FC9 |  |  | 1/0 | (not yet identified) |
| $1FCA | block_start_col | 1 | 39/8 | Block start marker: column |
| $1FCB | block_end_line | 2 | 30/9 | Block end marker: line number |
| $1FCC |  |  | 1/0 | (not yet identified) |
| $1FCD | block_end_col | 1 | 38/8 | Block end marker: column |
| $1FCE | marker_flags | 1 | 36/7 | Bit 0 = start marker set, bit 1 = end marker set (value 3 = both) |
| $1FCF | cursor_line | 2 | 38/24 | Number of the line the cursor is on |
| $1FD0 |  |  | 1/0 | (not yet identified) |
| $1FD1 | top_line | 2 | 51/17 | Number of the line shown on row 0 of the text window |
| $1FD3 | wf_menu_sel | 1 | 21/16 | WordFinder: currently selected menu line (0 to 3) |
| $1FD4 |  |  | 9/1 | (not yet identified) |
| $1FD6 |  |  | 7/1 | (not yet identified) |
| $1FD7 |  |  | 7/1 | (not yet identified) |
| $1FD9 |  |  | 5/1 | (not yet identified) |
| $1FDA |  |  | 2/0 | (not yet identified) |
| $1FDC |  |  | 2/0 | (not yet identified) |
| $1FDD |  |  | 0/9 | (not yet identified) |
| $1FDF |  |  | 0/7 | (not yet identified) |
| $1FE0 |  |  | 0/4 | (not yet identified) |
| $1FE2 |  |  | 0/3 | (not yet identified) |
| $1FE3 |  |  | 5/0 | (not yet identified) |
| $1FE4 |  |  | 26/5 | (not yet identified) |
| $1FE5 |  |  | 19/21 | (not yet identified) |
| $1FE7 |  |  | 4/0 | (not yet identified) |
| $1FE8 |  |  | 83/34 | (not yet identified) |
| $1FEA |  |  | 68/24 | (not yet identified) |
| $1FEB |  |  | 5/3 | (not yet identified) |
| $1FED |  |  | 5/0 | (not yet identified) |
| $1FF3 |  |  | 4/0 | (not yet identified) |
