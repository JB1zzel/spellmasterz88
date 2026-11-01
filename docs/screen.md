# Screen strings

Every string the code prints with GN_Sop that contains a screen-driver sequence, decoded. SOH ($01) starts a sequence; coordinates are sent plus 32. Window types: $80 plain, $81 with bars, $83 with bars and brackets.

## Bank 62

| address | printed by | decoded |
|---|---|---|
| $C315 str_define_window1 | L_D09F, L_F02C, qe_start | <define window 1: x=0 y=0 w=74 d=8 type=$81 (bars)> <select+clear window 1> <set cursor+vscroll> |
| $C328 str_define_window2 | draw_status_line, show_no_room_error | <define window 2: x=75 y=0 w=19 d=8 type=$80> <select+clear window 2> |
| $CC24 L_CC24 | L_CBFC | <cursor to x=0,y=7> down |
| $CC94 L_CC94 | L_CC6C | <cursor to x=0,y=0> up |
| $D137 str_select_window1 | L_D12D | <select (hold) window 1> |
| $D13C str_status_row7 | draw_status_line | <cursor to x=0,y=7> <set tiny> |
| $D156 str_status_row6_check | L_D117 | <cursor to x=0,y=6> <set tiny> "Check:" |
| $D16D str_cursor_to_prefix | L_DABC, place_cursor | <cursor-to prefix: caller sends x+32, y+32> |
| $D983 L_D983 | L_D4FF | <clear reverse> |
| $D9A1 L_D9A1 | L_D988 | <toggle reverse> |
| $D9A4 L_D9A4 | L_D506, L_D542 | <cursor-to prefix: caller sends x+32, y+32> |
| $D9B2 L_D9B2 | L_D506, L_D557, L_D61E | <justify centre> "1: Ignore word                " down "2: Add word to user dictionary" down "3: Guess correct word   " |
| $DAD6 L_DAD6 | L_DABC | <set reverse> <toggle-over-N prefix: caller sends N+32> |
| $DAFF L_DAFF | L_D64A, L_D6B6 | CLS down <set cursor+vscroll> "  :" |
| $E085 L_E085 | L_DEAE | <set vscroll> |
| $E08A L_E08A | L_DF09 | <cursor to x=0,y=0> |
| $E7D3 L_E7D3 | L_E602 | down <justify centre> "Are you sure ? (Y/N)" |
| $F033 L_F033 | L_EDE0 | down <justify centre> "Overwrite text? (Y/N) " <justify normal> |
| $F067 L_F067 | L_EC73, L_EE02, L_F177, L_F33F | <set cursor> <cursor to x=2,y=1> |
| $F0B6 L_F0B6 | L_EED4, L_FDD1 | CLS down down <set reverse+flash> <clear cursor> <justify centre> "Loading " <clear reverse+flash> <justify normal> |
| $F0D8 L_F0D8 | L_ECAF, L_F198, L_F2B0, L_FCD6 | CLS down down <set reverse+flash> <clear cursor> <justify centre> "Saving " <clear reverse+flash> <justify normal> |
| $F2E1 L_F2E1 | L_F284, L_F2C9 | CLS down down <justify centre> "File exists - Replace ? (Y/N) " <justify normal> |
| $F5CC L_F5CC | L_D6D8, L_F5B6 | <select+clear window 1> <set cursor+vscroll> |
| $F887 L_F887 | L_F3CA, L_F586 | <set vscroll> |
| $FE62 L_FE62 | cmd_load_user_dictionary | down <justify centre> "Delete current" down "dictionary? (Y/N) " <justify normal> |
| $FE8D L_FE8D | L_FCC0, L_FDBB | <set cursor> <cursor to x=2,y=1> |
| $FF8C str_dialog_type_83 | open_dialog_with_title | $83 <select+clear window 3> <justify centre> |
| $FF96 str_dialog_title_bar | open_dialog_with_title | <justify normal> <cursor to x=0,y=0> <set reverse> <apply toggles over 75 chars> <clear reverse> <define-window prefix: caller sends x,y,w,d> |
| $FFAB str_define_window3_prefix | open_dialog_with_title | <define-window prefix: caller sends x,y,w,d> |
| $FFB0 str_dialog_type_81 | open_dialog_with_title | $81 <select+clear window 3> |
| $FFD4 str_dialog_window_right | dialog_window_right | <define window 3: x=37 y=1 w=37 d=7 type=$80> <select+clear window 3> |
| $FFE2 str_dialog_window_left | dialog_window_left | <define window 3: x=0 y=1 w=37 d=7 type=$80> <select+clear window 3> |
## Bank 63

| address | printed by | decoded |
|---|---|---|
| $C191 str_cursor_to_prefix_b | L_C777, L_CA4F, L_CA67 | <cursor-to prefix: caller sends x+32, y+32> |
| $C344 L_C344 | wf_show_menu | CLS <justify centre> "Browse through dictionary" down "Find anagrams            " down "Find close matches       " down "Solve c" |
| $C485 L_C485 | L_C448, L_C6F4 | down CR <justify centre> <toggle reverse> "Press SPACE to continue " <toggle reverse> <justify normal> |
| $C4E4 L_C4E4 | L_C4DB | CLS down CR <justify centre> "Bad character in word " <justify normal> |
| $C75C L_C75C | wf_option_2_find_anagrams, wf_option_3_find_close_matches, w | <set cursor> <cursor to x=2,y=1> ": " |
| $C791 L_C791 | L_C777 | <set reverse> <toggle-over-N prefix: caller sends N+32> |
| $C9BC str_end_of_text | draw_end_of_text_marker | <set reverse> " End of text " <toggle reverse> |
| $C9EE str_reverse_off | reverse_off | <clear reverse> |
| $C9F3 str_reverse_on | reverse_on | <set reverse> |
| $C9F8 str_cursor_to_prefix | L_C881, L_CAE8, clear_remaining_rows, draw_cursor_line, draw | <cursor-to prefix: caller sends x+32, y+32> |
| $CACB str_toggle_over_n | L_CA93 | <toggle-over-N prefix: caller sends N+32> |
| $CF53 L_CF53 | L_CE47 | <cursor to x=19,y=1> |
| $CF59 L_CF59 | L_CE47 | <cursor to x=19,y=3> |
| $CF7E L_CF7E | far_information | <tab to x=19> |
| $D17A L_D17A | far_print_text | CLS down down <set reverse+flash> <clear cursor> <justify centre> "Printing " <clear reverse+flash> <justify normal> |
| $D52C L_D52C | L_D1FD, L_D215, L_D4A5, L_D4B9 | <set cursor> <cursor to x=2,y=1> "Find :" |
| $D53C L_D53C | L_D1FD, L_D23D, L_D24B | <set cursor> <cursor to x=2,y=3> "Replace :" |
| $D766 L_D766 | L_D32C | <cursor to x=30,y=7> <set reverse> "Replace ? (Y/N)" <clear reverse> |
| $D783 L_D783 | L_D1B7 | <justify centre> down down "Global or selective ? (G/S) " <justify normal> |
| $D87A L_D87A | far_information | <cursor to x=0,y=0> |
| $DA05 L_DA05 | L_D925, far_load_text_at_cursor | <set cursor> <cursor to x=2,y=1> |
| $DA31 L_DA31 | L_D939 | CLS <cursor to x=0,y=2> <set reverse+flash> <clear cursor> <justify centre> "Loading " <clear reverse+flash> <justify normal> |
| $DB0D L_DB0D | L_DB06 | <select (hold) window 1> <set cursor+vscroll> |
| $E429 L_E429 | L_E413 | <select+clear window 1> <set cursor+vscroll> |
| $E6DC L_E6DC | L_E3E3, wf_option_1_browse_dictionary | <set vscroll> |
| $E6E8 L_E6E8 | L_E6E1 | <toggle reverse> |
| $ECBB L_ECBB | L_EC9C | $83 <select+clear window 3> <justify centre> |
| $ECC5 L_ECC5 | L_ECAA | <justify normal> <cursor to x=0,y=0> <set reverse> <apply toggles over 75 chars> <clear reverse> <define-window prefix: caller sends x,y,w,d> |
| $ECDA L_ECDA | L_EC91 | <define-window prefix: caller sends x,y,w,d> |
| $ECDF L_ECDF | L_ECAA | $81 <select+clear window 3> |
| $ED3D L_ED3D | L_EC82 | <define window 3: x=4 y=0 w=72 d=8 type=$80> <select+clear window 3> |
| $ED4B L_ED4B | wf_show_menu | <define window 3: x=0 y=0 w=92 d=8 type=$80> <select+clear window 3> |
