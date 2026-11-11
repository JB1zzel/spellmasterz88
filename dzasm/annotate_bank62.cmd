; Spell-Master annotation commands for DZasm (bank 62)
di "spell_names.def"
dm defm D137 D14C
dm defm D155 D170
dm defm DAF2 DB09
dm defm E7CB E7EC
dm defm F04E F070
dm defm F880 F88B
dm defm FE75 FE96
rem C000 < Spell-Master for the Cambridge Z88 - bank 62 ($3E, SPELL.62). Mostly the QuickEdit application (a text editor with spell checking).
rem C000 < Annotated disassembly made with DZasm; the names, comments and constants are in the DZasm project (spell62.clt). It assembles to bytes IDENTICAL to bank_files/spell62.bin (the original ROM bank with the bank-addressing fix: 7 bytes changed).
rem C000 < Names and comments are inferred from what the code does, not original. See docs/notes.md for the method, the evidence and what is still unknown.
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
dc 1F95 buffers_binding
dc 1F97 file_handle
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
dc 1FAF browse_pos
dc 1FB1 typing_word_pending
dc 1FB3 misc_flags
dc 1FB4 saved_word_bank
dc 1FB5 saved_word_ptr
dc 1FB7 scan_chars_left
dc 1FB8 scan_ptr
dc 1FBC temp_ptr
dc 1FBE temp_bank
dc 1FBF temp2_ptr
dc 1FC1 temp2_bank
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
dc 1FD4 text_name_ptr
dc 1FD6 text_name_bank
dc 1FD7 user_dict_name_ptr
dc 1FD9 user_dict_name_bank
dc 1FDA ignore_list_ptr
dc 1FDC ignore_list_bank
dc 1FE3 own_header_flag
dc 1FE4 char_scratch
dc 1FE5 line_counter
dc 1FE7 pull_count
dc 1FE8 line_rec_ptr
dc 1FEA line_rec_bank
dc 1FEB link_ptr
dc 1FED link_binding
dc 1FF3 saved_letter
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
dl DC74 typing_check_command
rem DC74 < Check as you type, command hook: called by the main loop with the dispatch code in A before every command (A preserved). Does nothing unless EF_CHECK_ON is set.
rem DC74 < Rubout ($0B) and Delete character ($14) mark the word as pending (it is being edited). If a word is pending, the cursor movements
rem DC74 < (codes $01-$0A: screen/cursor up, down, left, right, top/bottom of text, start/end of line; $16/$17: next/previous word) check it first (typing_check_word).
dl DCA2 typing_check_char
rem DCA2 < Check as you type, character hook: called after a typed character has been put in the line (A = the character, from $1FE4). Does nothing unless EF_CHECK_ON is set.
rem DCA2 < A letter or apostrophe sets typing_word_pending; any other character (space, punctuation, digit) ends the word and checks it (typing_check_word).
rem DCA2 < Enter ($0D) does not come here: the main loop sends it straight to the new-line code at $C756, so the word before an Enter is not checked.
dl DCBD typing_check_word
rem DCBD < If typing_word_pending is set: clears it, finds the word before the cursor (find_word_start_at_cursor), copies it to buffer A in upper case,
rem DCBD < drops a final 'S or apostrophe, and looks it up (dictionary_lookup, which also tries the user dictionary and the ignored words).
rem DCBD < Words of fewer than 3 letters are not checked. If the word is not found the only response is a beep (BEL, 7, through OS_Out): no menu is shown.
dl DD22 find_word_start_at_cursor
rem DD22 < Like find_word_start but without clamping cursor_index: moves back from the character before the cursor to the start of that word.
rem DD22 < Returns at once (Z) if cursor_index is 0, leaving HL unchanged.
dl D8C4 next_word_to_buffer_b
rem D8C4 < next_word_from_text, but the word goes to buffer B. Used by replace_word_everywhere to find later copies of the word.
rem D643 < Correction menu option 4 'Change word'.
dl D64A change_word
rem D64A < Opens 'Replace with', puts the word as it stands in the text into buffer C (leaving out a final 'S or apostrophe, which stays in the text)
rem D64A < and edits it with GN_Sip (40 bytes, 20 columns). Enter: letters are made upper case (is_word_char) and replace_word_everywhere runs. Escape: back to the menu.
dl D6D8 replace_word_everywhere
rem D6D8 < Shows 'Replacing...' and replaces the word just checked (buffer A, dict_target_length letters, ending at scan_ptr) with the word in buffer C (dict_word_length letters).
rem D6D8 < Also used when a guess is chosen with Enter. Closes or opens the gap in the line and moves the block markers on this line to match.
rem D6D8 < Each letter takes its case from the letter at the same position in the old word ($D7A5: AND $20 of the old character, OR the new upper-case letter), so 'teh' -> 'the', 'Teh' -> 'The'.
rem D6D8 < It then carries on to the end of the text ($D7BD), replacing every later word that matches the old one (compared in upper case, so in any capitalisation),
rem D6D8 < counting the lines it moves forward in line_counter, and finally walks back to the original line.
dl DA65 save_typed_word
rem DA65 < Copies the word in buffer A (dict_target_length letters) into a small record from pool_main (saved_word_ptr/bank), so Browse can use buffer A. Carry set if no room.
dl DA91 restore_typed_word
rem DA91 < Copies the saved word back into buffer A and dict_target_length, and frees the record.
rem D5E0 < Correction menu option 5 'Browse through dictionary': save_typed_word, browse_dictionary, restore_typed_word.
dl F399 browse_dictionary
rem F399 < Browse through dictionary (Correction menu option 5). Window 'Browse'. The typed word (up to 64 letters) is copied to a work record ($1FBF/$1FC1)
rem F399 < and its length kept in wf_menu_sel (borrowed); browse_seek_prefix finds the first dictionary word at or after it and draw_browse_page shows the words around it.
rem F399 < Plain keys: a letter (or an apostrophe after the first letter) is added to the prefix and the list seeks again; Enter takes the highlighted word; any other key clears the prefix.
rem F399 < Extended keys (0 then a code) first clear the prefix: up/down ($FF/$FE) move one word (browse_prev_word, browse_next_word); $01/$02 (Screen up/down) = previous/next
rem F399 < two-letter section; $07/$08 (Top/Bottom of text) = previous/next first letter (wrapping Z/A); $1B and $FC cancel (edit_flags bit 6 = nothing chosen).
rem F399 < A $7F code (at $F4FD) would remove the last prefix letter, but the prefix has already been cleared on that path, so it appears to do nothing.
dl F518 next_section_letters
rem F518 < Steps dict_letter1/dict_letter2 to the next two-letter section (second letter apostrophe, A-Z; then the next first letter, Z wraps to A).
dl F53D prev_section_letters
rem F53D < Steps dict_letter1/dict_letter2 back to the previous two-letter section (A wraps to Z).
dl F562 draw_browse_page
rem F562 < Clears the window and draws the five words after the current one, then walks back so the current word is highlighted with its neighbours around it.
dl F5D6 print_current_word
rem F5D6 < Prints the whole current word (buffer C - 2, dict_word_length letters) and a CR.
dl F5EA browse_next_word
rem F5EA < Moves to the next word for Browse: the next ending of the current stem, or the next record, with any user dictionary word that falls in between (L_F9DF).
rem F5EA < browse_pos keeps the dictionary position of the current word. $1FB3 bit 1 is set while the current word comes from the user dictionary.
dl F676 browse_prev_word
rem F676 < Moves to the previous word for Browse (previous ending, or back one record from browse_pos), with any user dictionary word in between (L_FADE).
dl F7D1 browse_seek_prefix
rem F7D1 < Finds the first word at or after the typed prefix: its first two letters select the section (stepping back with prev_section_letters if there is none), then words are read forward.
dl CD44 wrap_from_cursor_line
rem CD44 < Clears line_counter, then wrap_cursor_line. Called by Format paragraph, by the main loop when typing takes the line past wrap_column (word wrap as you type),
rem CD44 < after Search and Replace (which rewraps every line from the top, $DBD3), and after Copy and Delete marked block.
dl CD49 wrap_cursor_line
rem CD49 < If the cursor line, ignoring trailing spaces, is longer than wrap_column, splits it at the last space at or before that column (or at the column if there is no space):
rem CD49 < the first part becomes a new line record above (alloc_line_record), the rest stays in the edit buffer, block markers move with the text, line_counter and cursor_line go up by one, and it repeats.
rem CD49 < If the line fits ($CE14), it pulls up the next line, or as many words of it as fit, unless the next line is empty or starts with a space (the end of the paragraph).
rem CCF6 < Format paragraph: rewraps the cursor line and each following line (store, take the next, wrap again) until a line that is empty or starts with a space.
rem CCF6 < line_counter counts the lines moved down; cursor_row is moved down by that much (back to row 3 if it would leave the window).
rem F77E < $F77E-$F787 are code left as data, and nothing calls them: LD A,($1FB3) / AND $FD / LD ($1FB3),A / SCF / RET.
rem F77E < The same bytes are the no_user_word stub of the WordFinder Browse in bank 63 ($E5DB); here they are unused.
rem EC30 < Save text writes the text as plain characters, each line followed by a CR ($0D). The first line of the file is the PipeDream option
rem EC30 < '%CO:A,72,72%' (str_pipedream_header: column A, width 72, right margin 72) unless own_header_flag is set because the loaded file began with its own %...% line.
rem EC30 < The filename is offered from text_name_ptr and kept there afterwards; the leaf name becomes the activity name in the Index (name_activity).
dl EC38 save_or_export
rem EC38 < Shared by Save text and Export text (edit_flags bit 7 set = Export). Export writes no header, does not keep the filename,
rem EC38 < and leaves out the CR after any line that ends in a space, so the lines of a word-wrapped paragraph are joined into one line.
rem EC26 < Sets edit_flags bit 7 (Export) and goes to save_or_export.
dl F284 open_output_file
rem F284 < Opens the file named in buffer A for writing (GN_Opf). If it already exists, asks 'Overwrite text? (Y/N)'; carry set if the answer is not Y. Out: IX = handle.
dl F139 name_activity
rem F139 < Passes the filename just opened (buffer C), without its path, to DC_Nam so the activity is shown under that name in the Index.
dl F38C str_pipedream_header
rem F38C < '%CO:A,72,72%': the PipeDream option line written at the start of a saved text and recognised (and dropped) when a text is loaded.
dl EDF7 load_text_file
rem EDF7 < Load text: asks for the filename, opens it, frees the whole current text (free_all_lines), then reads the file a byte at a time.
rem EDF7 < A first line that is exactly '%CO:A,72,72%' is dropped. A first line that starts with some other %...% option (up to 15 characters) is kept as text and own_header_flag is set,
rem EDF7 < so Save will not add a second header. Lines end at CR only: a LF is kept as a character (a file with CR LF line ends shows ^J at the start of each line after the first).
rem EDF7 < A line longer than 239 characters is cut into pieces of 239. The lines are not rewrapped. Reading stops at end of file (RC_Eof) or Escape (RC_Esc);
rem EDF7 < other read errors make it read again ($EF7E).
dl EE61 free_all_lines
rem EE61 < Frees every line record before the cursor line (the prev_line chain) and after it (the next_line chain).
dl EFF5 finish_load
rem EFF5 < Closes the file, stores the last line and makes the first line the cursor line.
dl F01C return_to_editor
rem F01C < Redefines window 1, asks for a full redraw and goes back to the main loop.
rem F16F < Save marked block writes only the marked text, from the start marker column to the end marker column, as plain lines ending in CR, with no header.
de CA63 "block_start_line+1"
de CA81 "block_end_line+1"
de E14D "cursor_line+1"
dl D0B4 quit_quickedit
rem D0B4 < RC_Quit: closes the three memory pools and leaves QuickEdit with OS_Bye.
dl CA49 join_markers
rem CA49 < Before the next line is joined onto the cursor line: a block marker on the next line moves up to this line, its column increased by line_length.
dl D1D7 markers_line_removed
rem D1D7 < A line has been removed above or at a marker: block_start_line and block_end_line after the cursor line go down by one.
dl D20C markers_line_inserted
rem D20C < A line has been inserted at the cursor line (word wrap): block_start_line and block_end_line after the cursor line go up by one.
dl E4DC markers_after_new_line
rem E4DC < As markers_line_inserted, used by the block commands.
dl E501 join_markers_b
rem E501 < As join_markers, used by join_next_line.
dl E541 join_next_line
rem E541 < Takes the line at line_rec as the cursor line and appends the next line to it if the result stays below 240 characters, moving markers to match.
dl D496 show_check_context
rem D496 < In the checking window: clears it and prints the part of the line around the word being checked, as much as fits in cursor_col_limit.
dl D506 open_correction_menu
rem D506 < Shows the checking window and the 'Correction menu' dialog with its five options (str at $D9B2).
dl DABC mark_menu_line
rem DABC < In: A = menu line, C = character. Prints C at the start of that line in reverse video: used to move the '#' pointer in the Correction menu.
dl DADE quit_on_rc_quit
rem DADE < After an OS_In error: RC_Quit ('g') leaves QuickEdit; any other error returns.
dl DB2E split_at_cursor
rem DB2E < Moves the text from the cursor to the end of the line into a new line record after the cursor line (Split line, Enter, block commands), moving markers to match.
dl DB85 compare_marker_with_cursor
rem DB85 < In: HL = a marker's line, A = its column. Used by split_at_cursor to decide whether the marker is after the split point.
dl DE15 guess_cancelled
rem DE15 < Guess correct word ended without a choice: sets edit_flags bit 6, frees the guess list, rebinds the line buffer, A = 1.
dl E04F guess_os_error
rem E04F < OS_In error while the guesses are shown: RC_Quit leaves QuickEdit, RC_Draw redraws the guess list.
dl E171 order_block_markers
rem E171 < If both markers are set and the end comes before the start, swaps them (lines and columns). Same as order_block_markers in bank 63.
dl E1B1 test_block_start_line
rem E1B1 < is_block_start_line without preserving BC.
dl E1D1 test_block_end_line
rem E1D1 < is_block_end_line without preserving BC.
dl E1DC remove_start_marker
rem E1DC < Removes the start marker: the end marker (if set) becomes the start marker. Z if no marker is left.
dl E1F1 shift_marker_flags
rem E1F1 < marker_flags shifted right by one bit (end marker flag becomes start marker flag).
dl E1FA drop_markers_at_cursor
rem E1FA < Removes any block marker that is exactly at the cursor (used when the character there is deleted).
dl E249 check_block_marked
rem E249 < Carry set (and Z) if no block is marked (end marker not set); otherwise continues with the block command.
dl E5A7 is_at_cursor
rem E5A7 < Z if line HL equals line BC and column D equals cursor_index.
dl E7ED delete_block_os_error
rem E7ED < OS_In error during Delete marked block's 'Are you sure' question: RC_Quit leaves, RC_Draw asks again.
dl E80D print_decimal
rem E80D < Prints HL in decimal (leading zeros suppressed), using the table of powers of ten at $E842. Same as print_decimal in bank 63. Used for the line number in the status panel.
dl F2C9 save_os_error
rem F2C9 < OS_In error during the 'Overwrite text?' question: RC_Quit leaves, RC_Draw redraws the question.
dl F586 browse_os_error
rem F586 < OS_In error in Browse: RC_Quit leaves, RC_Draw redraws the Browse window.
dl F6F6 dict_back_one_record
rem F6F6 < Moves dict_pos back to the start of the previous dictionary record (the first byte below $10). Carry set if that is the start of the section ($0F).
dl F74D browse_reexpand
rem F74D < Records are packed against the word before them, so to show the previous word Browse goes back to the start of the section and reads forward until it reaches browse_pos again.
dl F7B9 copy_stem_to_buffer_a
rem F7B9 < Copies the current word's stem (buffer C - 2, dict_stem_length letters) to buffer A and sets dict_target_length to its length.
dl F9DF browse_user_next
rem F9DF < Browse: finds a user dictionary word that comes between the current dictionary word and the next one. Carry set if there is none (or no user dictionary).
dl FADE browse_user_prev
rem FADE < Browse: as browse_user_next, going backwards.
dl FB53 compare_word_with_stem
rem FB53 < Compares the current dictionary word (buffer C - 2, dict_stem_length) with buffer A (dict_target_length): Z = equal, NZ at the first difference.
rem D0CA < $D0CA-$D0D5 follow OS_Bye and nothing jumps to them, so they are never run (tools/reach.py). They look like the tail of a backwards scan.
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
rem C1B6 < The ORIGINAL ROM had AND $C0 / OR D (the slot bits of the running bank OR the fixed number), which only works when the eight banks are the top of a slot. See docs/notes.md section 4.
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
rem C38A < See docs/notes.md section 2 and docs/dictionary.md for the dictionary format.
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
