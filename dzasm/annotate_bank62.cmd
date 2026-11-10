; Spell-Master annotation commands for DZasm (bank 62)
di "spell_names.def"
rem C000 < Spell-Master for the Cambridge Z88 - bank 62 ($3E, SPELL.62). Mostly the QuickEdit application (a text editor with spell checking).
rem C000 < Annotated disassembly made with DZasm; the names, comments and constants are in the DZasm project (spell62.clt). It assembles to bytes IDENTICAL to bank_files/spell62.bin (the original ROM bank with the bank-addressing fix: 7 bytes changed).
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
dc 1F9C prev_line_ptr
dc 1F9E prev_line_bank
dc 1F9F next_line_ptr
dc 1FA1 next_line_bank
dc 1FA2 cursor_row
dc 1FA4 cursor_col_limit
dc 1FA5 cursor_index
dc 1FA6 line_length
dc 1FA7 pool_main
dc 1FA9 pool_second
dc 1FAB edit_flags
dc 1FAC user_dict_ptr
dc 1FAE user_dict_bank
dc 1FB7 scan_chars_left
dc 1FBA word_start_ptr
dc 1FC2 guess_list_ptr
dc 1FC4 guess_list_bank
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
dc 1FE8 line_rec_ptr
dc 1FEA line_rec_bank
rem F88C < Word lists. The user dictionary (user_dict_ptr/bank) and the ignored words (ignore_list_ptr/bank) have the same structure:
rem F88C < a 78-byte ($4E) table of 26 three-byte heads (bank, offset low, offset high), one per letter A-Z, each the start of a linked list of word records in alphabetical order.
rem F88C < A word record is: byte 0 = n, the number of letters stored; bytes 1-3 = next record (bank, offset low, offset high; offset 0 = end of list); then the n letters.
rem F88C < The first letter is not stored (it is given by the table slot), so n is the word length minus one. Records come from pool_main.
rem F88C < The routines always work on the user dictionary pointer; swap_word_lists exchanges the two so the same code serves the ignored words.
dl F88C word_list_add
rem F88C < Adds the word in buffer A (dict_target_length letters, first letter A-Z) to the list, in alphabetical order. Allocates and clears the table on first use.
rem F88C < Returns Z if the word is already there; carry set if the first character is not a letter A-Z. No memory -> show_no_room_error.
rem F88C < $1FEB and $1FED hold the link to be patched (its address and the OS_Mpb binding) while the list is searched.
dl FBE3 word_list_lookup
rem FBE3 < Looks the word in buffer A up in the list. Carry clear = found. Called from dictionary_lookup after dict_target_length has had 2 subtracted, hence the +1.
dl FC71 swap_word_lists
rem FC71 < Exchanges user_dict_ptr/bank with ignore_list_ptr/bank, so the word list routines act on the ignored words. Always called in pairs.
dl FEC1 word_list_clear
rem FEC1 < Frees every word record in the list and clears the 26 heads (the table itself is kept).
dl FBC6 word_list_select_letter
rem FBC6 < In: A = letter 'A'-'Z'. Binds the table, saves the letter in $1FE4 and points line_rec_ptr at that letter's head.
dl FB81 word_list_first_from
rem FB81 < In: A = letter. Finds the first word record at or after that letter (line_rec). Carry set if there is none.
dl FB7B word_list_next
rem FB7B < Moves line_rec to the next word record, going on to the following letters at the end of a list. Carry set at the end of the table.
rem C083 < Not in the ROM dictionary: try the user dictionary, then (swapping the lists) the ignored words.
rem D467 < End of the check: the ignored words are only for this check. Swap the lists, free every ignored word and the table, swap back.
rem D5CA < Correction menu option 2 'Add word to user dictionary': word_list_add. Option 1 'Ignore word' (below) adds it to the ignored words instead.
dl D264 clamp_cursor_index
rem D264 < If cursor_index is beyond line_length, sets it to line_length. Out: A = C = cursor_index. BC preserved apart from C.
dl D988 toggle_reverse
rem D988 < Prints the 'toggle reverse video' sequence (1 R). HL preserved.
dl E1AB is_block_start_line
rem E1AB < Carry clear if the start marker is set and is on the cursor line; carry set otherwise. BC preserved.
dl E1CB is_block_end_line
rem E1CB < Carry clear if both markers are set and the end marker is on the cursor line; carry set otherwise. BC preserved.
dl E5D2 check_free_memory
rem E5D2 < OS_Nq NQ_Mfs (free memory) for pool_main. Carry set when the high byte returned in A is 0 and B is below 5, i.e. memory is nearly full; callers then refuse the command.
de E5D3 "NQ_Mfs"
dl F02C redefine_window1
rem F02C < Prints str_define_window1: redefines and selects the text window, which closes any dialog drawn over it.
dl F0A8 input_to_buffer_a
rem F0A8 < GN_Sip line input into buffer A (buffer size 50, 30 columns shown). Used for filenames. Out: A = the key that ended the input.
dl F0F9 free_sized_record
rem F0F9 < In: HL = offset, A = bank of a record whose byte 0 is its size. Frees it to pool_main; does nothing if HL = 0.
dl F10E store_filename_record
rem F10E < In: C = length of the explicit filename that GN_Opf left in buffer C. Allocates a record of C+2 bytes (line_rec), byte 0 = its size, then copies the name and its terminator.
rem F10E < Keeps the filename of the text or user dictionary just loaded or saved. Carry set if there is no room.
dl C2AE next_word_form
rem C2AE < Puts the next accepted word form in buffer C: the next ending of the current stem's inflection class if there is one, otherwise the next record of the section, expanded.
rem C2AE < Carry set at the end of the section (from read_dictionary_record).
dl F788 next_full_word
rem F788 < next_word_form, then writes the two section letters (dict_letter1, dict_letter2) just before buffer C and adds 2 to dict_word_length and dict_stem_length,
rem F788 < so the whole word starts two bytes before buffer C. Returns the flags of next_word_form (carry = end of section).
dl FC44 word_list_compare
rem FC44 < Compares the word at HL (A letters, first letter included) with the list word at line_rec, whose first letter is in $1FE4.
rem FC44 < Flags as for CP at the first difference: Z = equal, carry = the word comes first.
dl FF46 open_dialog_centre
rem FF46 < open_dialog_with_title with the centre geometry: x 25, 30 columns, full height (title on row 0).
dl FF4B open_dialog_right
rem FF4B < open_dialog_with_title with the right-hand geometry: x 38, 35 columns, rows 1-7. (open_dialog_default is the same on the left, x 1.)
dl D8CA next_word_from_text
rem D8CA < In: HL -> text, scan_chars_left = characters left to scan. Skips to the next word character, then copies the word into buffer A through is_word_char,
rem D8CA < so every letter is upper case: capital letters make no difference to the check. A leading apostrophe is dropped.
rem D8CA < The length goes to dict_target_length, leaving out a final apostrophe and a final 'S (JOHN'S is checked as JOHN). word_start_ptr = where the word starts.
rem D8CA < Z set if no word is left; NZ when a word was found.
dl DD33 find_word_start
rem DD33 < From cursor_index, moves back to the start of the word at or before the cursor. Out: HL -> that character in line_buffer, C = its index. Z if at the start of the line.
dl DDBD guess_correct_word
rem DDBD < Correction menu option 3 'Guess correct word'. The word is in buffer A (dict_target_length letters).
rem DDBD < Scans every section of the ROM dictionary (first letters A-Z, second letters apostrophe and A-Z) that section_could_match allows, every word form (next_word_form),
rem DDBD < then every word of the user dictionary. Each word that is_one_edit_away accepts is appended to the guess list (append_guess).
rem DDBD < A key pressed during the scan stops it (checked with OS_Xin after each first letter). The guesses are then shown six at a time in the right-hand dialog:
rem DDBD < up and down move the highlight, Enter puts the chosen word in buffer C and returns, 1-5 go to that Correction menu option, Escape cancels.
rem DDBD < Out: A = 1, or the menu key pressed. edit_flags bit 6 ($40) is set when no word was chosen. top_line is borrowed as a row counter while the list is drawn.
dl E063 section_could_match
rem E063 < Z set if the section's first letter (dict_letter1) or second letter (dict_letter2) equals the first or the second letter of the typed word.
rem E063 < Only those sections are searched, so a guess must share one of its first two letters with the typed word.
dl E076 append_guess
rem E076 < Far call 6 (far_append_guess in bank 63): appends the word in buffer C - 2 to the guess list. Carry set if there is no room.
dl E090 is_one_edit_away
rem E090 < Compares the word being scanned (buffer C - 2, dict_word_length + 2 letters) with the typed word (buffer A, dict_target_length letters).
rem E090 < Z set (a guess) when they differ by one edit: same length with one letter different, or with two adjacent letters swapped ($E0C0);
rem E090 < typed word one letter shorter, i.e. a letter missing ($E0EF); typed word one letter longer, i.e. an extra letter ($E10F). Lengths further apart are rejected.
dl DFF5 free_guess_list
rem DFF5 < Frees every record of the guess list and clears guess_list_ptr.
dl D922 is_word_char
rem D922 < Z set if A is a letter or an apostrophe. A letter is returned in upper case (AND $DF); an apostrophe is returned unchanged.
rem FE15 < Load user dictionary: each run of word characters (is_word_char, at most 64) is one word; any other byte ends it. Words of fewer than 3 characters are skipped.
rem FE15 < The words are added with word_list_add, so the file needs no particular order; a word starting with an apostrophe is rejected by word_list_add.
dl CFE9 alloc_line_record
rem CFE9 < In: A = text length. Allocates a line record of A+7 bytes from pool_main and points line_rec_ptr/line_rec_bank at it.
rem CFE9 < Links it between prev_line and next_line: prev's next link (+4) and next's prev link (+1) are set to it, and its own header gets the length and both links.
rem CFE9 < Out: carry set if OS_Mal failed. E = text length on exit.
dl CCA2 store_cursor_line
rem CCA2 < Writes the cursor line (line_buffer, line_length characters) into a new line record linked between prev_line and next_line. Carry set if there is no room.
dl CCBC load_line_record
rem CCBC < Makes the record at line_rec the cursor line: copies its text into line_buffer (copy_record_to_line_buffer) and takes its previous and next links as prev_line and next_line.
dl CCE2 take_line_record
rem CCE2 < load_line_record, then frees the record (free_line_record): the line now exists only in the edit buffer.
dl CCE5 free_line_record
rem CCE5 < Frees the record at line_rec back to pool_main (OS_Mfr, size from its length byte).
dl E5B4 copy_record_to_line_buffer
rem E5B4 < Binds the record's bank into segment 1, sets line_length = record length - 7 and copies the text into line_buffer.
dl ED76 step_to_prev_record
rem ED76 < Follows the previous link (+1..+3) of the record at line_rec. Z set (line_rec unchanged) if there is no previous line; otherwise line_rec = previous record, bound into segment 1, NZ.
dl ED9C step_to_next_record
rem ED9C < Follows the next link (+4..+6) of the record at line_rec. Z set (line_rec unchanged) if there is no next line; otherwise line_rec = next record, bound into segment 1, NZ.
dl E7BB dec_cursor_line
dl E7C3 inc_cursor_line
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
rem C1B6 < BANK-ADDRESSING SITE 1 (patched, as patters): the bank is worked out relative to the running bank: ADD A,D / SUB $3E, where D = $38 + index.
rem C1B6 < The ORIGINAL ROM had AND $C0 / OR D (the slot bits of the running bank OR the fixed number), which only works when the eight banks are the top of a slot. See NOTES.md 'Bank addressing'.
dl C1E2 qe_start
rem C1E2 < QuickEdit start-up: creates memory pools (OS_Mop), allocates buffers (OS_Mal), sets the error handler,
rem C1E2 < clears working variables, draws the window, then enters qe_main_loop.
dl C286 far_call_bank63
rem C286 < Call a routine in bank 63 (SPELL.63) from this bank.
rem C286 < IN: A = index into the far-call table in bank 63 (far_call_table, 11 entries).
rem C286 < Binds bank 63 into segment 1 and jumps to the stub at $7F80 (file offset $3F80 of SPELL.63).
rem C286 < BANK-ADDRESSING SITE 2 (patched): INC A after OS_Mgb gives the bank after the running one, bank 63. The ORIGINAL ROM had AND $C0 / OR $3F.
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
