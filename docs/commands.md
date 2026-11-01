# QuickEdit commands

The menu in SPELL.63 lists each command with a command code. The main loop (qe_main_loop in SPELL.62) turns the code into a *dispatch code* (0..46) and jumps through the table at $D171.

Raw codes that are translated first: $C3 Delete line -> $15, $D3 Delete character -> $14, $F4 Start of line -> $09, $F5 End of line -> $0A, $F8 Previous word -> $17, $F9 Next word -> $16; cursor keys $FC-$FF -> 3-6; $7F (rubout) -> $0B.

| dispatch code | menu command | topic | menu code | key bytes | handler |
|---|---|---|---|---|---|
| $01 | Screen up | Cursor | $01 | FB (.) | cmd_screen_up ($CB7A) |
| $02 | Screen down | Cursor | $02 | FA (.) | cmd_screen_down ($CBAF) |
| $03 | Cursor left | Cursor | $FC | FC (.) | cmd_cursor_left ($CC47) |
| $04 | Cursor right | Cursor | $FD | FD (.) | cmd_cursor_right ($CBE5) |
| $05 | Cursor down | Cursor | $FE | FE (.) | cmd_cursor_down ($CBD0) |
| $06 | Cursor up | Cursor | $FF | FF (.) | cmd_cursor_up ($CBDA) |
| $07 | Top of text | Cursor | $07 | F7 (.) | cmd_top_of_text ($CB53) |
| $08 | Bottom of text | Cursor | $08 | F6 (.) | cmd_bottom_of_text ($CB1B) |
| $09 | Start of line | Cursor | $F4 | F4 (.) | cmd_start_of_line ($CB0A) |
| $0A | End of line | Cursor | $F5 | F5 (.) | cmd_end_of_line ($CB12) |
| $0B | Rubout | Edit | $7F | E3 (.) | cmd_rubout ($C93F) |
| $0C | Swap case | Edit | $0C | 53 (S) | cmd_swap_case ($CAE0) |
| $0D | Join lines | Edit | $0D | 45 4A 4C (EJL) | cmd_join_lines ($CA1E) |
| $0E | Format paragraph | Edit | $0E | 52 (R) | cmd_format_paragraph ($CCF6) |
| $0F | Check this word | SPELLING | $0F | 43 57 (CW) | cmd_check_this_word ($D931) |
| $10 | Load text | Files | $10 | 46 4C (FL) | cmd_load_text ($EDC5) |
| $11 | Save text | Files | $11 | 46 53 (FS) | cmd_save_text ($EC30) |
| $12 | Check all text | SPELLING | $12 | 43 41 (CA) | cmd_check_all_text ($D3D5) |
| $13 | Split line | Edit | $13 | 45 53 4C (ESL) | cmd_split_line ($DB17) |
| $14 | Delete character | Edit | $D3 | D3 (.) | cmd_delete_character ($C920) |
| $15 | Delete line | Edit | $C3 | C3 (.) | cmd_delete_line ($C896) |
| $16 | Next word | Cursor | $F9 | F9 (.) | cmd_next_word ($C81D) |
| $17 | Previous word | Cursor | $F8 | F8 (.) | cmd_previous_word ($C79E) |
| $18 | Delete marked block | Blocks | $18 | 42 44 (BD) | cmd_delete_marked_block ($E5E2) |
| $19 | Check as you type | SPELLING | $19 | 43 54 (CT) | cmd_check_as_you_type ($DD59) |
| $1A | Information | Edit | $1A | 49 (I) | cmd_information ($E802) |
| $1B | Escape | Cursor | $1B | 1B (.) | cmd_escape ($D931) |
| $1C | Insert/Over | Cursor | $1C | 56 (V) | cmd_insert_over ($D991) |
| $1D | Check from cursor | SPELLING | $1D | 43 43 (CC) | cmd_check_from_cursor ($D2A0) |
| $1E | Insert marker | Blocks | $1E | 5A (Z) | cmd_insert_marker ($E131) |
| $1F | Copy marked block | Blocks | $1F | 42 43 (BC) | cmd_copy_marked_block ($E22D) |
| $20 | Remove markers | Blocks | $20 | 51 (Q) | cmd_remove_markers ($E169) |
| $21 | Move marked block | Blocks | $21 | 42 4D (BM) | cmd_move_marked_block ($E225) |
| $22 | Save user dictionary | Files | $22 | 46 55 53 (FUS) | cmd_save_user_dictionary ($FC8E) |
| $23 | Load user dictionary | Files | $23 | 46 55 4C (FUL) | cmd_load_user_dictionary ($FD99) |
| $24 | Save marked block | Files | $24 | 46 4D 53 (FMS) | cmd_save_marked_block ($F167) |
| $25 | Search for string | Blocks | $25 | 42 53 45 (BSE) | cmd_search_for_string ($DBFD) |
| $26 | Search and Replace | Blocks | $26 | 42 53 52 (BSR) | cmd_search_and_replace ($DB9F) |
| $27 | Merge text at cursor | Files | $27 | 46 4D 4C (FML) | cmd_merge_text_at_cursor ($DC12) |
| $28 | Check marked block | SPELLING | $28 | 43 4D (CM) | cmd_check_marked_block ($D2B9) |
| $29 | Tab | Cursor | $29 | E2 (.) | cmd_tab ($DC61) |
| $2A | Change name | Files | $2A | 46 43 (FC) | cmd_change_name ($F337) |
| $2B | Export text | Files | $2B | 46 58 53 (FXS) | cmd_export_text ($EC26) |
| $2C | Next Match | Blocks | $2C | 42 4E 4D (BNM) | cmd_next_match ($DBF6) |
| $2D | Insert real tab | Cursor | $2D | 54 (T) | cmd_insert_real_tab ($C610) |
| $2E | Print out text | Files | $2E | 50 4F (PO) | cmd_print_out_text ($D1CF) |

