; Spell-Master annotation commands for DZasm (bank 63)
di "spell_names.def"
dm defb C001 C03A
dm defb C196 C1D0
rem C001 < QuickEdit application DOR. Kept as raw bytes because DZasm V0.36 masks the topic, command and help pointers with $3FFF, but this card stores them as full $Cxxx addresses.
rem C001 < $C001 parent link 00 00 00; brother link 96 01 3F = offset $0196, bank $3F (the WordFinder DOR); son link 00 00 00.
rem C001 < $83 = application ROM DOR, length $2F. '@' = info section, length $12:
rem C001 < reserved 00 00; key letter 'Q'; contiguous RAM size $FF (only used by bad applications); overhead 0; unsafe workspace $001A; safe workspace $0062;
rem C001 < entry point $C000; bindings S0 to S3 = 00 00 00 3E (code bank $3E = SPELL.62 in segment 3); type 1 = $01 (AT_GOOD, an ordinary application); type 2 = $00.
rem C001 < 'H' = help section, length $0C: topics $E6EB, commands $E728, application help $EAB5 (all bank $3F), tokens 00 00 00 (none).
rem C001 < 'N' = name section, length 10: QuickEdit, 0. Then $FF ends the DOR.
rem C196 < WordFinder application DOR (raw bytes for the same reason as the QuickEdit DOR).
rem C196 < $C196 parent link 0; brother link 0 (last application on the card); son link 0. $83 = application ROM DOR, length $30. '@' = info section, length $12:
rem C196 < reserved 00 00; key letter 'W'; contiguous RAM size 0; overhead 0; unsafe workspace $007C; safe workspace 0; entry point $C1D1;
rem C196 < bindings S0 to S3 = 00 00 00 3F (code bank $3F = SPELL.63 in segment 3); type 1 = $09 (AT_GOOD + AT_POPD: a popdown, closed when you switch application); type 2 = $02 (AT2_ICL: inverted caps lock on entry).
rem C196 < 'H' = help section: topics $EBA0, commands $EBAE, application help $EAB5 (shared with QuickEdit), tokens none. 'N' = name section: WordFinder, 0. Then $FF.
rem C000 < Spell-Master for the Cambridge Z88 - bank 63 ($3F, SPELL.63). Card header, front DOR, both application DORs, QuickEdit menu text,
rem C000 < the WordFinder application and the routines QuickEdit calls through the far-call table.
rem C000 < Annotated disassembly made with DZasm (project spell63.clt). It assembles to bytes IDENTICAL to bank_files/spell63.bin (the original ROM bank with the bank-addressing fix: 7 bytes changed).
rem C000 < Offsets $0000-$003A and $0196-$01D0 are the application DORs. Names and comments are inferred, not original. See NOTES.md.
dc 1F82 dict_pos
dc 1F84 dict_bank
dc 1F85 dict_target_length
dc 1F86 dict_letter1
dc 1F87 dict_letter2
dc 1F88 dict_word_length
dc 1F89 dict_word_flags
dc 1F8A dict_ending_ptr
dc 1F8C dict_stem_length
dc 1F8D ptr_buffer_b
dc 1F8F ptr_buffer_c
dc 1F91 ptr_buffer_a
dc 1F93 pool_buffers
dc 1F99 line_buffer
dc 1F9B line_buffer_bank
dc 1F9C prev_line_ptr
dc 1F9E prev_line_bank
dc 1F9F next_line_ptr
dc 1FA1 next_line_bank
dc 1FA2 cursor_row
dc 1FA3 wrap_column
dc 1FA4 cursor_col_limit
dc 1FA5 cursor_index
dc 1FA6 line_length
dc 1FA7 pool_main
dc 1FA9 pool_second
dc 1FAB edit_flags
dc 1FAC user_dict_ptr
dc 1FAE user_dict_bank
dc 1FC2 guess_list_ptr
dc 1FC4 guess_list_bank
dc 1FAF browse_pos
dc 1FC8 block_start_line
dc 1FCA block_start_col
dc 1FCB block_end_line
dc 1FCD block_end_col
dc 1FCE marker_flags
dc 1FCF cursor_line
dc 1FD1 top_line
dc 1FD3 wf_menu_sel
dc 1FD7 user_dict_name_ptr
dc 1FD9 user_dict_name_bank
dc 1FDA ignore_list_ptr
dc 1FDC ignore_list_bank
dc 1FE5 line_counter
dc 1FE8 line_rec_ptr
dc 1FEA line_rec_bank
rem C576 < WordFinder reuses the line_rec_ptr word ($1FE8) here: in the crossword solver it holds a pointer into the pattern
rem C576 < (set after a '*' or '#' at $C5C4, 0 = none), not a line record. Likewise $1FEB holds a pointer into the dictionary word.
dl C087 find_dictionary_section
rem C087 < Same routine as find_dictionary_section in bank 62.
dl C0EB next_word_form
rem C0EB < Same routine as next_word_form in bank 62: the next accepted word form in buffer C (next ending, or next record expanded). Carry set at the end of the section.
dl E5E5 next_full_word
rem E5E5 < Same routine as next_full_word in bank 62: next_word_form, with the two section letters written just before buffer C.
rem D600 < $D600-$D74F: copies of the bank 62 line-record routines, used by the far-called commands (see notes section 12, 'How the text is stored').
dl D600 store_cursor_line
dl D61A take_line_record
rem D61A < Copies the record at line_rec into the edit buffer, takes its links as prev_line and next_line, then frees it (falls into free_line_record).
dl D640 free_line_record
dl D651 alloc_line_record
dl D6E3 step_to_prev_record
dl D704 step_to_next_record
dl D728 inc_cursor_line
dl D730 dec_cursor_line
dl D738 copy_record_to_line_buffer
rem D756 < $D756-$D765 (16 bytes) are code, left as data because nothing calls them: an unused copy of check_free_memory
rem D756 < (LD BC,NQ_Mfs / LD IX,(pool_main) / OS_Nq / CP 0 / RET NZ / LD A,B / CP 5 / RET). The bank's own copy is at $DAD1.
dl C31B wf_quit
rem C31B < RC_Quit: closes the three memory pools and leaves WordFinder with OS_Bye.
dl C3EE show_found_word
rem C3EE < Prints the found word (the two section letters, then buffer C) in 16-column slots, four to a 64-column row, using cursor_index and cursor_row (borrowed) as column and row.
rem C3EE < After six rows: 'Press SPACE to continue'. Any key clears the window and goes on; an extended Escape stops the search (carry set).
dl C46E check_quit
rem C46E < After an OS_In error: if it is RC_Quit ('g', $67) leaves WordFinder (wf_quit); otherwise returns.
dl C476 open_words_found
rem C476 < Opens the 'Words found' dialog (wide window) and clears cursor_row and cursor_index.
dl C4B8 input_wf_word
rem C4B8 < GN_Sip into buffer A (32 bytes, 32 columns). Out: dict_target_length = the length typed; A = the key that ended the input (Escape returns to the menu).
dl C4DB bad_character
rem C4DB < Shows 'Bad character in word' and waits for a key (end_of_search).
dl C6F4 end_of_search
rem C6F4 < Shows 'Press SPACE to continue' and waits for a key before going back to the menu.
dl C712 sort_letters
rem C712 < Sorts the B letters at HL into alphabetical order (a simple exchange sort). Find anagrams sorts the typed word once, then each dictionary word of the same length, and compares.
rem C709 < $C709-$C711 are code left as data, and nothing calls them: SCF / RET, then PUSH AF / LD A,7 / OS_Out / POP AF / RET (a beep).
dl D862 section_could_match
rem D862 < Same routine as section_could_match in bank 62 (identical bytes).
dl DD8A is_one_edit_away
rem DD8A < Same routine as is_one_edit_away in bank 62 (identical apart from the jump addresses): Z if the word is one letter different, missing, extra or swapped.
dl EC90 open_dialog_with_title
rem EC90 < Same routine as open_dialog_with_title in bank 62. In: HL = title, BC = window description.
dl EC5D open_dialog_centre
rem EC5D < Titled dialog x 25, 30 columns, full height (as open_dialog_centre in bank 62).
dl EC62 open_dialog_wide
rem EC62 < Titled dialog x 5, 70 columns, full height ('Words found').
dl EC67 open_dialog_mid
rem EC67 < Titled dialog x 18, 44 columns, full height.
dl EC6C open_dialog_wf
rem EC6C < Titled dialog x 20, 40 columns, full height (the WordFinder option windows: Anagram, Find close matches, Crossword).
dl EC71 open_dialog_right
rem EC71 < Titled dialog x 40, 35 columns, rows 1-7 (Browse).
dl E375 next_section_letters
dl E39A prev_section_letters
dl E3BF draw_browse_page
dl E433 print_current_word
dl E447 browse_next_word
dl E4D3 browse_prev_word
dl E62E browse_seek_prefix
dl E6E1 toggle_reverse
dl E5DB no_user_word
rem E5DB < Stands in for the user dictionary lookups of the bank 62 Browse (L_F9DF, L_FADE): clears $1FB3 bit 1 and returns carry (no user word). WordFinder has no user dictionary.
rem E203 < Option 1 is the bank 62 Browse (browse_dictionary) almost instruction for instruction: same keys, same routines (names as in bank 62),
rem E203 < except that it starts at 'AA' instead of the typed word and calls no_user_word where QuickEdit looks in the user dictionary.
rem C506 < Option 4: the pattern may use letters, an apostrophe, '#' (any one letter) and '*' (any run of letters, including none). Other characters: 'Bad character in word'.
rem C506 < If the pattern starts with letters only the matching sections are searched. Matching backtracks to the last '*' on a mismatch (line_rec_ptr, $1FEB, $1FBC, $1FBD).
rem C506 < Unlike Find anagrams this search does not stop for a key press; only the 'Press SPACE' page prompt can end it early.
rem DCFE < Option 3 uses the same test as Guess correct word (section_could_match, is_one_edit_away) over the whole ROM dictionary, without the user dictionary and without stopping for a key press.
dl D008 far_call_table
rem D008 < Far-call table: 11 words, indexed by the value in A when QuickEdit (bank 62) calls far_call_bank63.
rem D008 < Index 1 ($D54F) and index 5 ($DB25) are not used by any caller in bank 62.
dl CD87 far_information
rem CD87 < Far-call table entry 0.
rem CD87 < Called from the QuickEdit handler for Information (command $1A).
rem CD87 < Shows the Information window ('Currently editing', number of lines, memory, word count, user dictionary).
dl D498 far_search_for_string
rem D498 < Far-call table entry 2.
rem D498 < Called from the QuickEdit handler for Search for string (command $25).
dl D19D far_search_and_replace
rem D19D < Far-call table entry 3.
rem D19D < Called from the QuickEdit handler for Search and Replace (command $26).
dl D909 far_load_text_at_cursor
rem D909 < Far-call table entry 4.
rem D909 < Called from the QuickEdit handler for Merge text at cursor (command $27).
dl D880 far_append_guess
rem D880 < Far-call table entry 6.
rem D880 < Called from append_guess (bank 62 $E076) by Guess correct word, once for each dictionary or user word that is one edit away from the typed word.
rem D880 < Allocates a record of (word length + 7) bytes and appends it to the guess list: byte 0 = word length, bytes 1-3 = previous guess, bytes 4-6 = next guess (0), then the whole word from buffer C - 2.
rem D880 < The first guess becomes the list head (guess_list_ptr/bank); $1FBC/$1FBE hold the last guess, $1FBF/$1FC1 the new one. Carry set if there is no room.
dl C799 far_redraw_text_window
rem C799 < Far-call table entry 7.
rem C799 < Called by draw_text_window (bank 62), which redraw_screen calls. Draws the text in window 1: the cursor line from the edit buffer,
rem C799 < then the rows above and below it by following the line records, then the End of text marker and blank rows.
dl D01E far_tab
rem D01E < Far-call table entry 8.
rem D01E < Called from the QuickEdit handler for Tab (command $29).
dl D479 far_next_match
rem D479 < Far-call table entry 9.
rem D479 < Called from the QuickEdit handler for Next Match (command $2C).
dl D100 far_print_text
rem D100 < Far-call table entry 10.
rem D100 < Called from the QuickEdit handler for Print out text (command $2E).
rem D100 < Shows the 'Printing' window and sends the text to the printer.
dl C03B read_dictionary_record
rem C03B < Copy of bank 62 read_dictionary_record (see there).
dl C070 skip_to_next_letter_group
rem C070 < Copy of bank 62 skip_to_next_letter_group.
dl CB05 expand_word
rem CB05 < Copy of bank 62 expand_word, with append_token inline (its own token table at $CC73).
dl CC73 token_pointer_table
rem CC73 < Bank 63 copy of the 128-word token pointer table (bank 62: $C4A4).
dl C0BF bind_dictionary_bank
rem C0BF < Same routine as in bank 62: bind one dictionary bank into segment 2 (see bank 62 for the description).
rem C0BF < BANK-ADDRESSING SITE 1 (patched, copy in this bank): ADD A,D / SUB $3F, where D = $38 + index. The ORIGINAL ROM had AND $C0 / OR D.
rem C1D1 < WordFinder entry point (WordFinder DOR: entry $C1D1, segment 3 = bank $3F = SPELL.63).
dl C1D6 wf_start
rem C1D6 < WordFinder start-up: creates pools, allocates buffers, then falls into the menu.
dl C24B wf_show_menu
rem C24B < Draws the WordFinder window and menu ('Browse through dictionary', 'Find anagrams', 'Find close matches', 'Solve crossword').
dl C267 wf_menu_loop
rem C267 < WordFinder menu loop: reads keys. Keys 1 to 4 choose an option, Cursor up/down moves wf_menu_sel,
rem C267 < Enter runs the selected option, Escape frees the pools and exits (OS_Bye).
dl C2C7 wf_menu_key
rem C2C7 < Handles a key typed in the WordFinder menu.
dl E203 wf_option_1_browse_dictionary
rem E203 < Menu option 1: Browse through dictionary.
dl C62D wf_option_2_find_anagrams
rem C62D < Menu option 2: Find anagrams (window title 'Anagram'). Asks for a word, checks it is letters only, then searches.
dl DCFE wf_option_3_find_close_matches
rem DCFE < Menu option 3: Find close matches (window title 'Find close matches').
dl C506 wf_option_4_solve_crossword
rem C506 < Menu option 4: Solve crossword (window title 'Crossword').
dl CFE6 far_call_dispatch
rem CFE6 < Runs far-call routine number A: pops the index, looks it up in far_call_table, calls it, then returns to bank 62.
rem CFE6 < Entered from the stub at $7F80 with this bank bound into segment 3.
rem FF80 < STUB entered from bank 62 (far_call_bank63): copies the bank bound in segment 1 (this bank) into segment 3
rem FF80 < and jumps to far_call_dispatch.
rem FF8B < STUB used on the way back: re-binds bank 62 into segment 3, restores the registers saved on the stack, RET.
rem FF8B < BANK-ADDRESSING SITE 3 (patched): bank 62 is the bank before bank 63, so DEC A replaces the original AND $C0 / OR $3E. Shown here as raw bytes:
rem FF8B < $0E,$01 LD C,1 / $E7,$5A OS_Mgb / $78 LD A,B / $3D DEC A / $00,$00,$00 NOPs (ORIGINAL: $E6,$C0 AND $C0 / $F6,$3E OR $3E) / $47 LD B,A / $0E,$03 LD C,3 / $E7,$5D OS_Mpb / POPs / RET.
rem E6EB < QuickEdit menu topics ('Blocks', 'Cursor', 'Edit', 'Files', 'SPELLING') - kept as raw bytes.
rem E728 < QuickEdit menu commands: 46 commands, each [length][code][key bytes][0][name][0][length]. See NOTES.md for the full table.
rem EBAE < Menu commands for the Correction/spelling menu.
dl C7C5 draw_cursor_line
dl C948 put_text_char
dl C96D draw_end_of_text_marker
dl C992 clear_remaining_rows
dl C93D redraw_done
dl C9D9 reverse_on
dl C9E5 reverse_off
dl C9F8 str_cursor_to_prefix
dl C9BC str_end_of_text
dl C9F3 str_reverse_on
dl C9EE str_reverse_off
dl C9FC order_block_markers
dl CA36 highlight_block_on_row
dl C191 str_cursor_to_prefix_b
dl CACB str_toggle_over_n
rem C7C5 < Draw the cursor line at row cursor_row in window 1, straight from the edit buffer (line_buffer).
rem C7C5 < First works out the horizontal scroll: if cursor_index is at or beyond cursor_col_limit the line is shifted left
rem C7C5 < by cursor_index - cursor_col_limit characters. Then prints the visible part and pads the row with spaces.
rem C948 < Print one text character in window 1. Printable characters go straight out with OS_Out.
rem C948 < A control character (below 32) is shown as the matching letter (code + 64) in reverse video.
rem C96D < Draw the End of text marker row in reverse video ( End of text ), then fall into clear_remaining_rows.
rem C992 < Blank every remaining row of the text window below the End of text marker, up to row 7.
rem C93D < Redraw finished: set the redraw state in edit_flags to 4.
rem C9D9 < Turn reverse video on.
rem C9E5 < Turn reverse video off.
rem C9FC < Put the block markers in order: if both markers are set and the end comes before the start, swap start and end.
rem C9FC < marker_flags bit 0 = start set, bit 1 = end set; the markers are a line number plus a column.
rem CA36 < Highlight the part of the marked block that falls on the row just drawn, using the toggle-over-N sequence with reverse video.
rem C799 < Redraw the text window (far-call routine 7). The text is a chain of line records in banked memory:
rem C799 <   +0 = record length (text length + LINE_HDR_SIZE), +1..+3 = previous line (bank, offset low, offset high),
rem C799 <   +4..+6 = next line (bank, offset low, offset high), +7 = the text.
rem C799 < The cursor line itself is in the edit buffer. top_line = cursor_line - cursor_row.
rem C799 < Algorithm: 1) draw the cursor line; 2) walk back from it row by row to find the line for row 0;
rem C799 < 3) draw rows 0 to 7 in order, copying each line to the window and padding with spaces, following the next-line pointers;
rem C799 < 4) after the last line draw the End of text marker and blank any rows that remain.
rem C799 < It appears to check for a waiting key with OS_Xin and stop early if there is one, so typing is not held up by a redraw.
de C7CF "SD_COORD"
de C7D6 "SD_COORD"
de C808 "SD_COORD"
de C890 "SD_COORD"
de C897 "SD_COORD"
de C8B1 "LINE_HDR_SIZE"
de C8D2 "SD_COORD"
de C912 "TEXT_ROWS"
de C91E "TEXT_ROWS-1"
de C971 "TEXT_ROWS"
de C97B "SD_COORD"
de C982 "SD_COORD"
de C99A "TEXT_ROWS"
de C9A5 "SD_COORD"
de C9AC "SD_COORD"
de C9B4 "SD_COORD"
de CA56 "SD_COORD"
de CA5D "SD_COORD"
de CA80 "SD_COORD"
de CA87 "SD_COORD"
de CA9F "SD_COORD"
de CAFA "SD_COORD"
de CB01 "SD_COORD"
de CDB6 "NQ_Mfs"
dl DAD1 check_free_memory
rem DAD1 < Same routine as check_free_memory in bank 62: carry set when memory is nearly full.
de DAD2 "NQ_Mfs"
ca
