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
| $1F95 | buffers_binding | 2 | 4/2 | BC for OS_Mpb that binds the three work buffers (B = their bank), saved from the OS_Mal at start-up |
| $1F97 | file_handle | 2 | 26/3 | IX handle of the file being loaded, saved, merged or used for the user dictionary (GN_Opf) |
| $1F99 | line_buffer | 2 | 49/18 | Pointer to the current-line edit buffer (0xF8 bytes, allocated at start-up) |
| $1F9B | line_buffer_bank | 1 | 13/1 | Bank of the current-line edit buffer |
| $1F9C | prev_line_ptr | 2 | 27/7 | Offset (segment 1) of the line record above the cursor line; 0 = the cursor line is the first line |
| $1F9E | prev_line_bank | 1 | 19/6 | Bank of the record above the cursor line |
| $1F9F | next_line_ptr | 2 | 52/9 | Offset (segment 1) of the line record below the cursor line; 0 = the cursor line is the last line |
| $1FA1 | next_line_bank | 1 | 35/7 | Bank of the record below the cursor line |
| $1FA2 | cursor_row | 1 | 32/14 | Screen row (0 to 7) of the cursor line in window 1 |
| $1FA3 | wrap_column | 1 | 8/1 | Right margin for word wrap and Format paragraph: 72, set at start-up and never changed (notes section 16) |
| $1FA4 | cursor_col_limit | 1 | 5/8 | Screen column at which the cursor stops while the line scrolls sideways; also the number of columns drawn per row |
| $1FA5 | cursor_index | 1 | 58/36 | Cursor position as a character index within the current line |
| $1FA6 | line_length | 1 | 112/34 | Length of the current line in characters |
| $1FA7 | pool_main | 2 | 20/14 | Memory pool handle #1 (created first with OS_Mop) |
| $1FA9 | pool_second | 2 | 3/5 | Memory pool handle #2 (created second with OS_Mop) |
| $1FAB | edit_flags | 1 | 65/9 | QuickEdit flags: bit 0 = overtype mode (toggled by Insert/Over), bit 4 = check-as-you-type on, bits 1-3 (mask $0E) = screen redraw state (2 = redraw requested, 4 = redraw finished) |
| $1FAC | user_dict_ptr | 2 | 20/4 | Offset (segment 1) of the user dictionary table: 26 three-byte list heads, one per letter A-Z; 0 = no table yet (see notes section 14) |
| $1FAE | user_dict_bank | 1 | 13/2 | Bank of the user dictionary table |
| $1FAF | browse_pos | 2 | 15/15 | Browse (Correction menu and WordFinder): dictionary position of the record of the current word, used to step back |
| $1FB1 | typing_word_pending | 1 | 5/0 | Check as you type: 1 while a word is being typed or edited and has not been checked yet (notes section 15) |
| $1FB3 | misc_flags | 1 | 9/13 | Bit 1 = the current Browse word comes from the user dictionary; bit 6 cleared by Browse; bit 7 = Search and Replace is selective |
| $1FB4 | saved_word_bank | 1 | 3/0 | Bank of the record holding the typed word while Browse runs (save_typed_word) |
| $1FB5 | saved_word_ptr | 2 | 3/0 | Offset of that record |
| $1FB7 | scan_chars_left | 1 | 21/0 | Characters of the line still to scan for the next word (next_word_from_text); set to line_length minus the scan start |
| $1FB8 | scan_ptr | 2 | 16/0 | Address in the line buffer just after the word being checked; where the scan for the next word continues |
| $1FBA | word_start_ptr | 2 | 5/0 | Address in the line buffer where the word just taken by next_word_from_text starts |
| $1FBC | temp_ptr | 2 | 24/8 | Scratch banked pointer, offset: last guess, user dictionary walks, print_decimal; in the crossword solver $1FBC and $1FBD are two counters |
| $1FBD |  | 1 | 0/3 | Crossword solver only: letters of the dictionary word left at the last '*' (with $1FBC = pattern letters left); otherwise the high byte of temp_ptr |
| $1FBE | temp_bank | 1 | 17/3 | Bank for temp_ptr |
| $1FBF | temp2_ptr | 2 | 11/9 | Second scratch banked pointer, offset: new guess, Browse prefix record |
| $1FC1 | temp2_bank | 1 | 10/8 | Bank for temp2_ptr |
| $1FC2 | guess_list_ptr | 2 | 6/1 | Offset of the first record of the guess list built by Guess correct word; 0 = none (notes section 15) |
| $1FC4 | guess_list_bank | 1 | 6/1 | Bank of that record |
| $1FC8 | block_start_line | 2 | 32/9 | Block start marker: line number |
| $1FC9 |  | 1 | 1/0 | High byte of block_start_line, read on its own once (written as block_start_line+1) |
| $1FCA | block_start_col | 1 | 39/8 | Block start marker: column |
| $1FCB | block_end_line | 2 | 30/9 | Block end marker: line number |
| $1FCC |  | 1 | 1/0 | High byte of block_end_line, read on its own once (written as block_end_line+1) |
| $1FCD | block_end_col | 1 | 38/8 | Block end marker: column |
| $1FCE | marker_flags | 1 | 36/7 | Bit 0 = start marker set, bit 1 = end marker set (value 3 = both) |
| $1FCF | cursor_line | 2 | 38/24 | Number of the line the cursor is on |
| $1FD0 |  | 1 | 1/0 | High byte of cursor_line, read on its own once (written as cursor_line+1) |
| $1FD1 | top_line | 2 | 51/17 | Number of the line shown on row 0 of the text window |
| $1FD3 | wf_menu_sel | 1 | 21/16 | WordFinder: currently selected menu line (0 to 3) |
| $1FD4 | text_name_ptr | 2 | 9/1 | Offset of the record holding the text filename last loaded or saved; offered by Save, shown by Information (notes section 18) |
| $1FD6 | text_name_bank | 1 | 7/1 | Bank of that record |
| $1FD7 | user_dict_name_ptr | 2 | 7/1 | Offset of a record holding the user dictionary filename last saved or loaded (byte 0 = length); shown by Information |
| $1FD9 | user_dict_name_bank | 1 | 5/1 | Bank of that record |
| $1FDA | ignore_list_ptr | 2 | 2/0 | Offset of the ignored-words table (same structure as the user dictionary); only touched by swap_word_lists |
| $1FDC | ignore_list_bank | 1 | 2/0 | Bank of the ignored-words table |
| $1FDD | search_str_ptr | 2 | 0/9 | Offset of the record holding the last Find string (byte 0 = record size, then the string); 0 = none (notes section 17) |
| $1FDF | search_str_bank | 1 | 0/7 | Bank of that record |
| $1FE0 | replace_str_ptr | 2 | 0/4 | Offset of the record holding the last Replace string; 0 = none |
| $1FE2 | replace_str_bank | 1 | 0/3 | Bank of that record |
| $1FE3 | own_header_flag | 1 | 5/0 | 1 if the loaded file began with its own %...% option line, so Save does not add %CO:A,72,72% |
| $1FE4 | char_scratch | 1 | 26/5 | Scratch byte: the character just typed, the current letter A-Z while walking a word list, the start column of a search attempt |
| $1FE5 | line_counter | 1 | 19/21 | Scratch line counter: lines moved down by word wrap, Format paragraph and Replace (a word in Replace); a row counter during the redraw in bank 63 |
| $1FE7 | pull_count | 1 | 4/0 | Word wrap: number of characters pulled up from the next line |
| $1FE8 | line_rec_ptr | 2 | 83/34 | Offset (segment 1) of the line record being worked on: just allocated (alloc_line_record) or reached by walking the links (step_to_prev_record, step_to_next_record). WordFinder reuses this word in the crossword solver as a pointer into the pattern |
| $1FEA | line_rec_bank | 1 | 68/24 | Bank of that record |
| $1FEB | link_ptr | 2 | 5/3 | word_list_add: address of the link being patched; in the crossword solver a pointer into the dictionary word |
| $1FED | link_binding | 2 | 5/0 | word_list_add: BC for OS_Mpb that binds the bank of that link |
| $1FF3 | saved_letter | 1 | 4/0 | Copy of char_scratch kept while looking for the nearest user dictionary word |
