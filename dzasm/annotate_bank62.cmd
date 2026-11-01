; Spell-Master annotation commands for DZasm (bank 62)
di "spell_names.def"
rem C000 < Spell-Master for the Cambridge Z88 - bank 62 ($3E, SPELL.62). Mostly the QuickEdit application (a text editor with spell checking).
rem C000 < Annotated disassembly made with DZasm; the names, comments and constants are in the DZasm project (spell62.clt). It assembles to bytes IDENTICAL to the original bank.
rem C000 < Names and comments are inferred from what the code does, not original. See NOTES.md for the method, the evidence and what is still unknown.
rem C000 < Hex digits are written with a leading dollar sign; the equates used here are in spell_names.def.
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
dc 1FA2 cursor_row
dc 1FA4 cursor_col_limit
dc 1FA5 cursor_index
dc 1FA6 line_length
dc 1FA7 pool_main
dc 1FA9 pool_second
dc 1FAB edit_flags
dc 1FC8 block_start_line
dc 1FCA block_start_col
dc 1FCB block_end_line
dc 1FCD block_end_col
dc 1FCE marker_flags
dc 1FCF cursor_line
dc 1FD1 top_line
dc 1FD3 wf_menu_sel
dl C5B2 qe_main_loop
rem C5B2 < QuickEdit main loop (entry 0 of the command table: 'no command', just reads the next key).
dl CB7A cmd_screen_up
rem CB7A < Command handler: 'Screen up' - dispatch code $01
dl CBAF cmd_screen_down
rem CBAF < Command handler: 'Screen down' - dispatch code $02
dl CC47 cmd_cursor_left
rem CC47 < Command handler: 'Cursor left' - dispatch code $03
dl CBE5 cmd_cursor_right
rem CBE5 < Command handler: 'Cursor right' - dispatch code $04
dl CBD0 cmd_cursor_down
rem CBD0 < Command handler: 'Cursor down' - dispatch code $05
dl CBDA cmd_cursor_up
rem CBDA < Command handler: 'Cursor up' - dispatch code $06
dl CB53 cmd_top_of_text
rem CB53 < Command handler: 'Top of text' - dispatch code $07
dl CB1B cmd_bottom_of_text
rem CB1B < Command handler: 'Bottom of text' - dispatch code $08
dl CB0A cmd_start_of_line
rem CB0A < Command handler: 'Start of line' - dispatch code $09
dl CB12 cmd_end_of_line
rem CB12 < Command handler: 'End of line' - dispatch code $0A
dl C93F cmd_rubout
rem C93F < Command handler: 'Rubout' - dispatch code $0B
dl CAE0 cmd_swap_case
rem CAE0 < Command handler: 'Swap case' - dispatch code $0C
dl CA1E cmd_join_lines
rem CA1E < Command handler: 'Join lines' - dispatch code $0D
dl CCF6 cmd_format_paragraph
rem CCF6 < Command handler: 'Format paragraph' - dispatch code $0E
dl D931 cmd_check_this_word_or_escape
rem D931 < Command handler: 'Check this word' - dispatch code $0F
rem D931 < Command handler: 'Escape' - dispatch code $1B
rem D931 < Two dispatch codes share this handler.
dl EDC5 cmd_load_text
rem EDC5 < Command handler: 'Load text' - dispatch code $10
dl EC30 cmd_save_text
rem EC30 < Command handler: 'Save text' - dispatch code $11
dl D3D5 cmd_check_all_text
rem D3D5 < Command handler: 'Check all text' - dispatch code $12
dl DB17 cmd_split_line
rem DB17 < Command handler: 'Split line' - dispatch code $13
dl C920 cmd_delete_character
rem C920 < Command handler: 'Delete character' - dispatch code $14
dl C896 cmd_delete_line
rem C896 < Command handler: 'Delete line' - dispatch code $15
dl C81D cmd_next_word
rem C81D < Command handler: 'Next word' - dispatch code $16
dl C79E cmd_previous_word
rem C79E < Command handler: 'Previous word' - dispatch code $17
dl E5E2 cmd_delete_marked_block
rem E5E2 < Command handler: 'Delete marked block' - dispatch code $18
dl DD59 cmd_check_as_you_type
rem DD59 < Command handler: 'Check as you type' - dispatch code $19
dl E802 cmd_information
rem E802 < Command handler: 'Information' - dispatch code $1A
dl D991 cmd_insert_over
rem D991 < Command handler: 'Insert/Over' - dispatch code $1C
dl D2A0 cmd_check_from_cursor
rem D2A0 < Command handler: 'Check from cursor' - dispatch code $1D
dl E131 cmd_insert_marker
rem E131 < Command handler: 'Insert marker' - dispatch code $1E
dl E22D cmd_copy_marked_block
rem E22D < Command handler: 'Copy marked block' - dispatch code $1F
dl E169 cmd_remove_markers
rem E169 < Command handler: 'Remove markers' - dispatch code $20
dl E225 cmd_move_marked_block
rem E225 < Command handler: 'Move marked block' - dispatch code $21
dl FC8E cmd_save_user_dictionary
rem FC8E < Command handler: 'Save user dictionary' - dispatch code $22
dl FD99 cmd_load_user_dictionary
rem FD99 < Command handler: 'Load user dictionary' - dispatch code $23
dl F167 cmd_save_marked_block
rem F167 < Command handler: 'Save marked block' - dispatch code $24
dl DBFD cmd_search_for_string
rem DBFD < Command handler: 'Search for string' - dispatch code $25
dl DB9F cmd_search_and_replace
rem DB9F < Command handler: 'Search and Replace' - dispatch code $26
dl DC12 cmd_merge_text_at_cursor
rem DC12 < Command handler: 'Merge text at cursor' - dispatch code $27
dl D2B9 cmd_check_marked_block
rem D2B9 < Command handler: 'Check marked block' - dispatch code $28
dl DC61 cmd_tab
rem DC61 < Command handler: 'Tab' - dispatch code $29
dl F337 cmd_change_name
rem F337 < Command handler: 'Change name' - dispatch code $2A
dl EC26 cmd_export_text
rem EC26 < Command handler: 'Export text' - dispatch code $2B
dl DBF6 cmd_next_match
rem DBF6 < Command handler: 'Next Match' - dispatch code $2C
dl C610 cmd_insert_real_tab
rem C610 < Command handler: 'Insert real tab' - dispatch code $2D
dl D1CF cmd_print_out_text
rem D1CF < Command handler: 'Print out text' - dispatch code $2E
rem C000 < Application entry point (set in the QuickEdit DOR: entry $C000, segment 3 = bank $3E = SPELL.62).
rem C000 < Immediately jumps to qe_start.
dl C1B6 bind_dictionary_bank
rem C1B6 < Bind one dictionary bank into segment 2.
rem C1B6 < IN: IX -> a 3-byte dictionary index entry. Bits 7-5 of (IX+0) select the dictionary bank 0..5 (SPELL.56 to SPELL.61);
rem C1B6 <     (IX+1),(IX+2) = offset within that bank.
rem C1B6 < OUT: dict_bank = absolute bank number bound into segment 2, dict_pos = offset.
rem C1B6 < BANK-ADDRESSING SITE 1: the ORIGINAL code builds the bank as (running slot bits) OR ($38 + index), i.e. it assumes the
rem C1B6 < eight banks occupy the top of the slot. See NOTES.md 'Bank addressing' (patters' fix makes this relative).
dl C1E2 qe_start
rem C1E2 < QuickEdit start-up: creates memory pools (OS_Mop), allocates buffers (OS_Mal), sets the error handler,
rem C1E2 < clears working variables, draws the window, then enters qe_main_loop.
dl C286 far_call_bank63
rem C286 < Call a routine in bank 63 (SPELL.63) from this bank.
rem C286 < IN: A = index into the far-call table in bank 63 (far_call_table, 11 entries).
rem C286 < Binds bank 63 into segment 1 and jumps to the stub at $7F80 (file offset $3F80 of SPELL.63).
rem C286 < BANK-ADDRESSING SITE 2: the ORIGINAL code computes bank 63 as (running slot bits) OR $3F.
rem D171 < Command jump table: 47 words, indexed by dispatch code 0..46. See cmd_* handlers.
rem D171 < The main loop does: HL = table + 2*code; JP (HL).
dl D276 translate_key_code
rem D276 < Maps raw command codes to dispatch codes: $C3 Delete line -> $15, $D3 Delete character -> $14,
rem D276 < $F4 Start of line -> $09, $F5 End of line -> $0A, $F8 Previous word -> $17, $F9 Next word -> $16.
dl D0DC show_no_room_error
rem D0DC < Displays 'No Room!' (QuickEdit reports this when it cannot get more memory for the text).
dl C355 append_token
rem C355 < IN: A = token number (bit 7 of the packed byte is ignored), HL = where to append.
rem C355 < Looks up the token string through token_pointer_table and copies it to HL, clearing bit 7 of its characters, until the next
rem C355 < token begins (a byte with bit 7 set). Used by expand_word to turn a packed byte of $80 or more into letters.
rem C38A < The token strings: common groups of letters that the dictionary stores as a single byte ($80 to $FF) to save space.
rem C38A < Each token starts with a letter that has bit 7 set, followed by the rest of its letters ('TION', then 3-letter tokens such as WAY, ITY,
rem C38A < IES, MAN, IAN, ISM, FUL, IAL, ING, then 2-letter tokens). They are not only word endings: AR, OL, BL and so on are used as well.
rem C38A < See NOTES.md section 13 for the dictionary format.
dl C4A4 token_pointer_table
rem C4A4 < 128 words: token number -> address of its string. Token 0 (TION) has four letters, tokens 1 to 35 three letters, 36 to 121 two letters;
rem C4A4 < 122 to 127 are not used.
rem C4F0 < Pointers for the later tokens (the 2-letter tokens, $C3F7 onward); the last six words (tokens 122 to 127) are unused.
dl C005 read_dictionary_record
rem C005 < Copy the next packed dictionary record from segment 2 (at dict_pos) into buffer B.
rem C005 < A record is: one byte (bits 0-3 = how many letters to keep from the previous word, bit 5 = the word takes -S), then the letters
rem C005 < (plain letters, tokens of $80 or more, and optionally one inflection class byte $10-$16), up to the first byte that starts the next record
rem C005 < (a byte whose value, ignoring bit 5, is below $10). The byte $0F where a record should start marks the end of the section.
rem C005 < The apostrophe is stored as $40 and is converted to $27. If bit 5 of the first byte is set it is cleared and the word is given inflection class $11 (-S).
dl C03A skip_to_next_letter_group
rem C03A < Advance dict_pos to the next record whose first byte is 0 (a word sharing no letters with the previous one),
rem C03A < which is the start of the next group of words with a different third letter. Lets the lookup skip words quickly.
dl C051 dictionary_lookup
rem C051 < Look a word up in the dictionary. The word is in buffer A. Takes its first two letters, finds that section with find_dictionary_section,
rem C051 < then reads the records of the section in order, expanding each (expand_word) and comparing it with the rest of the word.
rem C051 < Because the words are sorted it stops as soon as a word is greater than the target. Returns carry clear if found.
dl C093 compare_expanded_word
rem C093 < Compare the expanded dictionary word (buffer C) with the target.
rem C093 < If the stem carries an inflection class (dict_word_flags bit 7) the endings of that class are appended one at a time and compared
rem C093 < as well (see inflection_class_table). A bare stem is only accepted when its class is below $13.
dl C17E find_dictionary_section
rem C17E < IN: dict_letter1 and dict_letter2 = the first two letters of the word.
rem C17E < Looks up the first letter in first_letter_index, then searches that letter's list of 3-byte entries for the second letter.
rem C17E < OUT: IX = the entry, dict_bank and dict_pos set by bind_dictionary_bank. Carry set if there are no words with that prefix.
dl C336 expand_word
rem C336 < Expand the packed record in buffer B into the full word in buffer C.
rem C336 < The first byte of buffer B says how many letters to keep from the word already in buffer C; the rest is added after them.
rem C336 < Bytes of $80 or more are tokens (append_token). A byte below $10 ends the word; $10 to $1F also ends it and is the inflection class
rem C336 < (saved with bit 7 set in dict_word_flags). Sets dict_word_length.
dl E84E first_letter_index
rem E84E < 26 words, one per first letter A to Z: the address of that letter's list of 3-byte section entries.
rem E84E < Each entry is [bank*32 + second letter (0 = apostrophe, 1 to 26 = A to Z)] [offset low] [offset high]; offsets are in segment 2 ($8000-$BFFF).
rem E84E < A list ends with $FF. There are 302 sections in all.
dl DDAF inflection_class_table
rem DDAF < 7 words: inflection class $10 to $16 -> list of endings. The list holds endings each starting with a letter that has bit 7 set, ending with $80.
rem DDAF < $10 = ED ING S;  $11 = S;  $12 = ED ES ING;  $13 = E ED ES ING (the stem has lost its final E);  $14 = IES Y;  $15 = E Y;
rem DDAF < $16 = ISE ISED ISES ISING IZE IZED IZES IZING.
dl D241 redraw_screen
dl D247 place_cursor
dl D06F draw_text_window
dl D0F7 draw_status_line
dl D089 handle_os_error
dl FF50 dialog_window_right
dl FF57 dialog_window_left
dl FF5E open_dialog_default
dl FF61 open_dialog_with_title
dl C315 str_define_window1
dl C328 str_define_window2
dl D137 str_select_window1
dl D13C str_status_row7
dl D146 str_insert
dl D14D str_overtype
dl D156 str_status_row6_check
dl D166 str_off
dl D16A str_on
dl D16D str_cursor_to_prefix
dl FF8C str_dialog_type_83
dl FF96 str_dialog_title_bar
dl FFAB str_define_window3_prefix
dl FFB0 str_dialog_type_81
dl FFD4 str_dialog_window_right
dl FFE2 str_dialog_window_left
rem D241 < Redraw the whole screen: the text window (far call 7 into bank 63), then the status line, then place the cursor.
rem D247 < Position the cursor in window 1: x = the smaller of cursor_col_limit and cursor_index, y = cursor_row.
rem D247 < Both are sent as the coordinate plus SD_COORD (32), after the cursor-to prefix string.
rem D06F < Draw the text window. This is only: A = 7, call far_call_bank63. The work is done by far_redraw_text_window in bank 63.
rem D0F7 < Draw the status line in window 2 (the 19-column panel at the right of the screen).
rem D0F7 < Redefines and clears window 2, prints the cursor line number, then in tiny type: row 7 = Insert or Overtype (edit_flags bit 0),
rem D0F7 < row 6 = Check: On or Off (edit_flags bit 4). Finally selects window 1 again (str_select_window1).
rem D089 < Called after every key read (carry set when the read returned an OZ error, A = error code).
rem D089 < RC_Draw: the screen was corrupted by another application - redefine window 1 and redraw.
rem D089 < RC_Quit: free the three memory pools and leave with OS_Bye.
rem D089 < Other codes are passed back to the caller.
rem C315 < Window 1, the text window: x=0 y=0, 74 columns by 8 rows, type $81 (bars). Selected and cleared, vertical scroll and cursor on.
rem C328 < Window 2, the side panel: x=75 y=0, 19 columns by 8 rows, type $80. Selected and cleared.
rem D13C < Cursor to column 0, row 7 of window 2, tiny type on. Followed by str_insert or str_overtype.
rem D156 < Cursor to column 0, row 6 of window 2, tiny type on, then the text Check: (followed by str_off or str_on).
rem D16D < Cursor-to prefix: SOH, 3, @. The caller sends the column and row, each plus 32.
rem FF50 < Opens dialog window 3 in the RIGHT half of the screen (x=37, 37 columns, 7 rows). Called from several routines (menus and lists).
rem FF57 < Opens dialog window 3 in the LEFT half of the screen (x=0, 37 columns, 7 rows). Called from one place only.
rem FF61 < Open a dialog box with a title bar in window 3.
rem FF61 < IN: HL = the title text, BC = the window description (the outer x,y,w,d, a NUL, then the inner x,y,w,d).
rem FF61 < Draws the outer window (type $83), prints the title centred, makes the title line reverse across 75 characters,
rem FF61 < then redefines window 3 as the inner window (type $81) below the title and selects it.
de D096 "RC_Draw"
de D09A "RC_Quit"
de D10E "EF_OVERTYPE"
de D127 "EF_CHECK_ON"
de D259 "SD_COORD"
de D260 "SD_COORD"
ca
