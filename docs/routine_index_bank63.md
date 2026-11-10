# Routine index - bank 63 (SPELL.63)

Every label in the source. 'callers' counts CALL instructions that name the label. Facts only.

| address | label | callers | OZ calls | text | lines |
|---|---|---|---|---|---|
| $C000 | QuickEdit_entry | 0 |  |  | 1 |
| $C001 | applDor_QuickEdit | 0 |  |  | 5 |
| $C00C | applDor_QuickEdit_Start | 0 |  |  | 23 |
| $C030 | applDor_QuickEdit_Name | 0 |  | QuickEdit | 1 |
| $C03A | applDor_QuickEdit_NameEnd | 0 |  |  | 1 |
| $C03B | applDor_QuickEdit_End | 0 |  |  | 0 |
| $C03B | read_dictionary_record | 4 |  |  | 6 |
| $C048 | L_C048 | 0 |  |  | 6 |
| $C051 | L_C051 | 0 |  |  | 15 |
| $C06B | L_C06B | 0 |  |  | 3 |
| $C06E | L_C06E | 0 |  |  | 2 |
| $C070 | skip_to_next_letter_group | 1 |  |  | 1 |
| $C073 | L_C073 | 0 |  |  | 8 |
| $C081 | L_C081 | 0 |  |  | 4 |
| $C087 | find_dictionary_section | 12 |  |  | 17 |
| $C0A8 | L_C0A8 | 0 |  |  | 1 |
| $C0AA | L_C0AA | 0 |  |  | 1 |
| $C0AB | L_C0AB | 0 |  |  | 9 |
| $C0BD | L_C0BD | 0 |  |  | 2 |
| $C0BF | bind_dictionary_bank | 0 | Os_mgb, Os_mpb |  | 25 |
| $C0EB | next_word_form | 4 |  |  | 27 |
| $C126 | L_C126 | 0 |  |  | 8 |
| $C138 | L_C138 | 0 |  |  | 7 |
| $C142 | L_C142 | 0 |  |  | 3 |
| $C149 | L_C149 | 0 |  |  | 7 |
| $C159 | L_C159 | 0 |  |  | 10 |
| $C191 | str_cursor_to_prefix_b | 0 |  |  | 2 |
| $C196 | applDor_WordFinder | 0 |  |  | 5 |
| $C1A1 | applDor_WordFinder_Start | 0 |  |  | 23 |
| $C1C5 | applDor_WordFinder_Name | 0 |  | WordFinder | 1 |
| $C1D0 | applDor_WordFinder_NameEnd | 0 |  |  | 1 |
| $C1D1 | applDor_WordFinder_End | 0 |  |  | 0 |
| $C1D1 | WordFinder_entry | 0 |  |  | 2 |
| $C1D6 | wf_start | 0 | Os_erh, Os_mal, Os_mop, Os_mpb |  | 51 |
| $C24B | wf_show_menu | 0 | Gn_sop |  | 12 |
| $C267 | wf_menu_loop | 0 | Os_in |  | 21 |
| $C291 | L_C291 | 0 |  |  | 10 |
| $C2A5 | L_C2A5 | 0 |  |  | 6 |
| $C2B1 | L_C2B1 | 0 | Os_bye, Os_mcl |  | 12 |
| $C2C7 | wf_menu_key | 0 |  |  | 4 |
| $C2D0 | L_C2D0 | 0 |  |  | 10 |
| $C2E4 | L_C2E4 | 0 |  |  | 2 |
| $C2EA | L_C2EA | 0 |  |  | 2 |
| $C2F0 | L_C2F0 | 0 |  |  | 2 |
| $C2F6 | L_C2F6 | 0 |  |  | 2 |
| $C2FC | L_C2FC | 0 | Os_mcl |  | 3 |
| $C302 | L_C302 | 0 | Os_mcl |  | 3 |
| $C308 | L_C308 | 0 | Os_mcl |  | 3 |
| $C30E | L_C30E | 0 | Os_bye |  | 3 |
| $C312 | L_C312 | 2 |  |  | 5 |
| $C31B | wf_quit | 0 | Os_bye, Os_mcl |  | 13 |
| $C332 | L_C332 | 0 |  |  | 2 |
| $C334 | L_C334 | 0 |  |  | 3 |
| $C339 | L_C339 | 0 |  | WordFinder | 2 |
| $C344 | L_C344 | 0 |  |  | 1 |
| $C346 | L_C346 | 0 |  | 2JCBrowse through dictionary | 2 |
| $C363 | L_C363 | 0 |  | Find anagrams             | 2 |
| $C37D | L_C37D | 0 |  | Find close matches        | 2 |
| $C397 | L_C397 | 0 |  | Solve crossword           | 2 |
| $C3B7 | L_C3B7 | 0 |  | Which category : | 2 |
| $C3CA | L_C3CA | 0 |  | Bad category! | 2 |
| $C3D8 | L_C3D8 | 0 | Os_bye, Os_mcl |  | 12 |
| $C3EE | show_found_word | 3 | Os_out |  | 17 |
| $C410 | L_C410 | 0 | Os_out |  | 16 |
| $C42A | L_C42A | 0 | Os_out |  | 7 |
| $C433 | L_C433 | 0 | Gn_nln |  | 10 |
| $C448 | L_C448 | 0 | Gn_sop, Os_in |  | 18 |
| $C469 | L_C469 | 0 |  |  | 2 |
| $C46E | check_quit | 4 |  |  | 5 |
| $C476 | open_words_found | 4 |  |  | 6 |
| $C485 | L_C485 | 0 |  |  | 1 |
| $C48C | L_C48C | 0 |  | RPress SPACE to continue  | 2 |
| $C4AC | L_C4AC | 0 |  | Words found | 2 |
| $C4B8 | input_wf_word | 3 | Gn_sip |  | 11 |
| $C4D0 | L_C4D0 | 0 | Gn_nln |  | 8 |
| $C4DB | bad_character | 0 | Gn_sop |  | 4 |
| $C4E4 | L_C4E4 | 0 |  |  | 1 |
| $C4E8 | L_C4E8 | 0 |  | 2JCBad character in word  | 2 |
| $C506 | wf_option_4_solve_crossword | 1 | Gn_sop |  | 12 |
| $C522 | L_C522 | 0 |  |  | 12 |
| $C539 | L_C539 | 0 |  |  | 7 |
| $C547 | L_C547 | 0 |  |  | 9 |
| $C55A | L_C55A | 0 |  |  | 9 |
| $C56B | L_C56B | 0 |  |  | 4 |
| $C576 | L_C576 | 0 |  |  | 17 |
| $C59D | L_C59D | 0 |  |  | 7 |
| $C5A9 | L_C5A9 | 0 |  |  | 6 |
| $C5B1 | L_C5B1 | 0 |  |  | 3 |
| $C5B7 | L_C5B7 | 0 |  |  | 2 |
| $C5BA | L_C5BA | 0 |  |  | 6 |
| $C5C4 | L_C5C4 | 0 |  |  | 14 |
| $C5E0 | L_C5E0 | 0 |  |  | 3 |
| $C5E4 | L_C5E4 | 0 |  |  | 7 |
| $C5F1 | L_C5F1 | 0 |  |  | 10 |
| $C607 | L_C607 | 0 |  |  | 4 |
| $C610 | L_C610 | 0 |  |  | 12 |
| $C62D | wf_option_2_find_anagrams | 1 | Gn_sop |  | 12 |
| $C649 | L_C649 | 0 |  |  | 17 |
| $C66E | L_C66E | 0 |  |  | 4 |
| $C678 | L_C678 | 0 |  |  | 16 |
| $C6A0 | L_C6A0 | 0 |  |  | 14 |
| $C6BF | L_C6BF | 0 |  |  | 10 |
| $C6CE | L_C6CE | 0 |  |  | 4 |
| $C6D7 | L_C6D7 | 0 | Os_xin |  | 14 |
| $C6F4 | end_of_search | 0 | Gn_sop, Os_in |  | 15 |
| $C712 | sort_letters | 2 |  |  | 6 |
| $C719 | L_C719 | 0 |  |  | 8 |
| $C722 | L_C722 | 0 |  |  | 19 |
| $C737 | L_C737 | 0 |  | Crossword | 2 |
| $C741 | L_C741 | 0 |  |  | 2 |
| $C749 | L_C749 | 0 |  | Find close matches | 2 |
| $C75C | L_C75C | 0 |  |  | 4 |
| $C777 | L_C777 | 4 | Gn_sop, Os_out |  | 18 |
| $C791 | L_C791 | 0 |  |  | 1 |
| $C799 | far_redraw_text_window | 1 |  |  | 11 |
| $C7B1 | L_C7B1 | 0 |  |  | 9 |
| $C7C5 | draw_cursor_line | 1 | Gn_sop, Os_out |  | 19 |
| $C7E7 | L_C7E7 | 0 |  |  | 9 |
| $C7F7 | L_C7F7 | 0 |  |  | 7 |
| $C802 | L_C802 | 0 |  |  | 4 |
| $C809 | L_C809 | 0 | Os_out |  | 4 |
| $C80E | L_C80E | 0 |  |  | 10 |
| $C822 | L_C822 | 0 |  |  | 8 |
| $C831 | L_C831 | 0 | Os_xin |  | 8 |
| $C83E | L_C83E | 0 |  |  | 10 |
| $C859 | L_C859 | 0 | Os_mpb |  | 17 |
| $C881 | L_C881 | 0 | Gn_sop, Os_mpb, Os_out |  | 30 |
| $C8B6 | L_C8B6 | 0 |  |  | 4 |
| $C8BF | L_C8BF | 0 |  |  | 9 |
| $C8CC | L_C8CC | 0 |  |  | 3 |
| $C8D1 | L_C8D1 | 0 | Os_out |  | 5 |
| $C8D8 | L_C8D8 | 0 | Os_xin |  | 23 |
| $C90A | L_C90A | 0 |  |  | 2 |
| $C90E | L_C90E | 0 |  |  | 8 |
| $C91F | L_C91F | 0 | Os_mpb |  | 15 |
| $C93D | redraw_done | 0 |  |  | 5 |
| $C948 | put_text_char | 2 | Os_out |  | 12 |
| $C959 | L_C959 | 0 | Os_out |  | 11 |
| $C968 | L_C968 | 0 |  |  | 1 |
| $C969 | L_C969 | 0 |  |  | 2 |
| $C96D | draw_end_of_text_marker | 0 | Gn_sop, Os_out |  | 19 |
| $C992 | clear_remaining_rows | 0 | Gn_sop, Os_out |  | 16 |
| $C9B2 | L_C9B2 | 0 |  |  | 2 |
| $C9B5 | L_C9B5 | 0 | Os_out |  | 5 |
| $C9BC | str_end_of_text | 0 |  |  | 1 |
| $C9BD | L_C9BD | 0 |  | 2+R End of text  | 3 |
| $C9D9 | reverse_on | 1 | Gn_sop |  | 7 |
| $C9E5 | reverse_off | 0 | Gn_sop |  | 6 |
| $C9EE | str_reverse_off | 0 |  |  | 1 |
| $C9F1 | L_C9F1 | 0 |  |  | 2 |
| $C9F3 | str_reverse_on | 0 |  |  | 3 |
| $C9F8 | str_cursor_to_prefix | 0 |  |  | 2 |
| $C9FC | order_block_markers | 1 |  |  | 15 |
| $CA19 | L_CA19 | 0 |  |  | 11 |
| $CA36 | highlight_block_on_row | 2 |  |  | 7 |
| $CA44 | L_CA44 | 0 |  |  | 5 |
| $CA4F | L_CA4F | 0 | Gn_sop, Os_out |  | 13 |
| $CA67 | L_CA67 | 0 | Gn_sop, Os_out |  | 21 |
| $CA8A | L_CA8A | 0 |  |  | 4 |
| $CA93 | L_CA93 | 0 | Gn_sop, Os_out |  | 10 |
| $CAA5 | L_CAA5 | 0 |  |  | 15 |
| $CAC0 | L_CAC0 | 0 |  |  | 5 |
| $CACB | str_toggle_over_n | 0 |  |  | 1 |
| $CACF | L_CACF | 1 |  |  | 4 |
| $CAD6 | L_CAD6 | 2 |  |  | 3 |
| $CADB | L_CADB | 0 |  |  | 6 |
| $CAE5 | L_CAE5 | 0 |  |  | 3 |
| $CAE8 | L_CAE8 | 1 | Gn_sop |  | 9 |
| $CAF9 | L_CAF9 | 0 | Os_out |  | 8 |
| $CB05 | expand_word | 4 |  |  | 6 |
| $CB11 | L_CB11 | 0 |  |  | 11 |
| $CB24 | L_CB24 | 0 |  |  | 12 |
| $CB34 | L_CB34 | 0 |  |  | 8 |
| $CB40 | L_CB40 | 0 |  |  | 2 |
| $CB45 | L_CB45 | 0 |  |  | 7 |
| $CB52 | L_CB52 | 0 |  |  | 26 |
| $CC0A | L_CC0A | 0 |  |  | 2 |
| $CC0E | L_CC0E | 0 |  |  | 9 |
| $CC36 | L_CC36 | 0 |  |  | 9 |
| $CC73 | token_pointer_table | 0 |  |  | 33 |
| $CD73 | L_CD73 | 0 |  | Into detokenising | 2 |
| $CD87 | far_information | 0 | Gn_nln, Gn_sop, Os_nq |  | 47 |
| $CDE6 | L_CDE6 | 0 |  |  | 4 |
| $CDF0 | L_CDF0 | 0 |  |  | 3 |
| $CDF7 | L_CDF7 | 0 |  |  | 5 |
| $CE05 | L_CE05 | 0 | Os_xin |  | 11 |
| $CE1D | L_CE1D | 0 |  |  | 10 |
| $CE33 | L_CE33 | 0 |  |  | 2 |
| $CE36 | L_CE36 | 0 |  |  | 5 |
| $CE43 | L_CE43 | 0 |  |  | 2 |
| $CE47 | L_CE47 | 0 | Gn_sop |  | 11 |
| $CE60 | L_CE60 | 0 |  |  | 8 |
| $CE6F | L_CE6F | 0 |  |  | 8 |
| $CE80 | L_CE80 | 0 |  |  | 3 |
| $CE88 | L_CE88 | 0 |  |  | 9 |
| $CE9B | L_CE9B | 0 | Os_in |  | 8 |
| $CEA7 | L_CEA7 | 0 |  |  | 1 |
| $CEA8 | L_CEA8 | 0 |  |  | 5 |
| $CEB4 | L_CEB4 | 2 | Gn_sop |  | 7 |
| $CEBF | L_CEBF | 0 | Os_mpb |  | 10 |
| $CECD | L_CECD | 0 | Os_out |  | 8 |
| $CED7 | L_CED7 | 1 |  |  | 7 |
| $CEE5 | L_CEE5 | 0 |  |  | 2 |
| $CEE8 | L_CEE8 | 0 |  |  | 2 |
| $CEEB | L_CEEB | 0 |  | Currently editing : | 2 |
| $CF00 | L_CF00 | 0 |  | Number of lines   : | 2 |
| $CF15 | L_CF15 | 0 |  | Memory free       : | 2 |
| $CF2A | L_CF2A | 0 |  | Word count        : | 2 |
| $CF3F | L_CF3F | 0 |  | User dictionary   : | 2 |
| $CF53 | L_CF53 | 0 |  |  | 1 |
| $CF59 | L_CF59 | 0 |  |  | 2 |
| $CF5F | L_CF5F | 0 |  |  | 2 |
| $CF64 | L_CF64 | 0 |  | Untitled | 2 |
| $CF6D | L_CF6D | 0 |  |  | 1 |
| $CF70 | L_CF70 | 0 |  |  | 2 |
| $CF72 | L_CF72 | 0 |  | Information | 2 |
| $CF7E | L_CF7E | 0 |  |  | 9 |
| $CF8B | L_CF8B | 1 |  |  | 1 |
| $CF8C | L_CF8C | 0 |  |  | 7 |
| $CF9A | L_CF9A | 1 |  |  | 4 |
| $CFA2 | L_CFA2 | 0 | Os_out |  | 3 |
| $CFA5 | L_CFA5 | 3 |  |  | 3 |
| $CFAD | L_CFAD | 0 |  |  | 11 |
| $CFBB | L_CFBB | 0 |  |  | 6 |
| $CFC8 | L_CFC8 | 0 |  |  | 4 |
| $CFCF | L_CFCF | 0 | Os_out |  | 4 |
| $CFD5 | L_CFD5 | 0 |  |  | 2 |
| $CFDA | L_CFDA | 0 |  |  | 2 |
| $CFE6 | far_call_dispatch | 0 | Os_mgb, Os_mpb |  | 23 |
| $D007 | L_D007 | 1 |  |  | 1 |
| $D008 | far_call_table | 0 |  |  | 11 |
| $D01E | far_tab | 0 |  |  | 6 |
| $D029 | L_D029 | 0 |  |  | 12 |
| $D03C | L_D03C | 0 |  |  | 12 |
| $D04F | L_D04F | 0 |  |  | 2 |
| $D052 | L_D052 | 0 |  |  | 16 |
| $D068 | L_D068 | 0 |  |  | 32 |
| $D09C | L_D09C | 0 |  |  | 12 |
| $D0B3 | L_D0B3 | 0 |  |  | 2 |
| $D0B5 | L_D0B5 | 0 |  |  | 4 |
| $D0BE | L_D0BE | 0 |  |  | 11 |
| $D0CF | L_D0CF | 1 |  |  | 4 |
| $D0D5 | L_D0D5 | 1 |  |  | 4 |
| $D0DE | L_D0DE | 0 |  |  | 10 |
| $D0ED | L_D0ED | 0 |  |  | 2 |
| $D0EF | L_D0EF | 1 |  |  | 4 |
| $D0F5 | L_D0F5 | 1 |  |  | 5 |
| $D100 | far_print_text | 0 | Gn_sop, Os_esc, Os_prt |  | 17 |
| $D121 | L_D121 | 0 |  |  | 2 |
| $D126 | L_D126 | 0 | Os_mpb |  | 12 |
| $D13B | L_D13B | 0 | Os_prt |  | 7 |
| $D144 | L_D144 | 0 | Os_prt |  | 10 |
| $D155 | L_D155 | 0 | Os_esc, Os_prt |  | 16 |
| $D174 | L_D174 | 0 | Os_out |  | 4 |
| $D17A | L_D17A | 0 |  |  | 2 |
| $D187 | L_D187 | 0 |  | 2JCPrinting  | 3 |
| $D19D | far_search_and_replace | 0 |  |  | 8 |
| $D1B7 | L_D1B7 | 0 | Gn_sop |  | 5 |
| $D1C3 | L_D1C3 | 0 | Os_in |  | 8 |
| $D1D2 | L_D1D2 | 0 |  |  | 7 |
| $D1E1 | L_D1E1 | 0 |  |  | 9 |
| $D1F5 | L_D1F5 | 0 |  |  | 3 |
| $D1FD | L_D1FD | 0 | Gn_sop, Os_out |  | 12 |
| $D215 | L_D215 | 0 | Gn_sip, Gn_sop |  | 14 |
| $D231 | L_D231 | 0 |  |  | 6 |
| $D23D | L_D23D | 0 | Gn_sop |  | 6 |
| $D24B | L_D24B | 0 | Gn_sip, Gn_sop |  | 14 |
| $D268 | L_D268 | 0 |  |  | 2 |
| $D26C | L_D26C | 0 |  |  | 2 |
| $D26E | L_D26E | 0 |  |  | 6 |
| $D27A | L_D27A | 0 |  |  | 2 |
| $D27F | L_D27F | 0 |  |  | 6 |
| $D288 | L_D288 | 0 |  |  | 6 |
| $D295 | L_D295 | 0 |  |  | 6 |
| $D29E | L_D29E | 0 |  |  | 24 |
| $D2E0 | L_D2E0 | 0 |  |  | 4 |
| $D2EB | L_D2EB | 0 |  |  | 6 |
| $D2F4 | L_D2F4 | 0 |  |  | 2 |
| $D2F9 | L_D2F9 | 0 |  |  | 6 |
| $D302 | L_D302 | 0 |  |  | 9 |
| $D313 | L_D313 | 0 |  |  | 10 |
| $D327 | L_D327 | 0 |  |  | 1 |
| $D329 | L_D329 | 0 |  |  | 1 |
| $D32C | L_D32C | 0 | Gn_sop |  | 10 |
| $D345 | L_D345 | 0 | Os_in |  | 8 |
| $D354 | L_D354 | 0 |  |  | 16 |
| $D375 | L_D375 | 0 |  |  | 1 |
| $D378 | L_D378 | 0 |  |  | 17 |
| $D399 | L_D399 | 0 |  |  | 11 |
| $D3B1 | L_D3B1 | 0 |  |  | 1 |
| $D3B3 | L_D3B3 | 0 |  |  | 8 |
| $D3BE | L_D3BE | 0 |  |  | 14 |
| $D3DD | L_D3DD | 0 |  |  | 7 |
| $D3EC | L_D3EC | 0 |  |  | 3 |
| $D3F3 | L_D3F3 | 0 |  |  | 35 |
| $D42E | L_D42E | 0 |  |  | 7 |
| $D438 | L_D438 | 0 |  |  | 9 |
| $D448 | L_D448 | 0 |  |  | 8 |
| $D454 | L_D454 | 0 |  |  | 7 |
| $D460 | L_D460 | 0 |  |  | 5 |
| $D466 | L_D466 | 0 |  |  | 9 |
| $D479 | far_next_match | 0 |  |  | 12 |
| $D495 | L_D495 | 0 |  |  | 1 |
| $D498 | far_search_for_string | 0 |  |  | 4 |
| $D4A5 | L_D4A5 | 0 | Gn_sop |  | 8 |
| $D4B9 | L_D4B9 | 0 | Gn_sip, Gn_sop |  | 14 |
| $D4D5 | L_D4D5 | 0 |  |  | 2 |
| $D4D8 | start_search | 0 |  |  | 14 |
| $D4FD | L_D4FD | 0 |  |  | 7 |
| $D50A | L_D50A | 0 |  |  | 1 |
| $D50C | L_D50C | 0 |  |  | 4 |
| $D512 | L_D512 | 0 |  |  | 1 |
| $D519 | L_D519 | 0 |  | Search and Replace | 2 |
| $D52C | L_D52C | 0 |  |  | 3 |
| $D53C | L_D53C | 0 |  |  | 3 |
| $D54F | find_next_match | 2 |  |  | 7 |
| $D55D | L_D55D | 0 |  |  | 12 |
| $D578 | L_D578 | 0 |  |  | 27 |
| $D5A9 | L_D5A9 | 0 |  |  | 5 |
| $D5B5 | L_D5B5 | 0 |  |  | 4 |
| $D5BB | L_D5BB | 0 |  |  | 12 |
| $D5D9 | L_D5D9 | 0 |  |  | 2 |
| $D5DB | back_to_start_line | 2 |  |  | 8 |
| $D5EB | L_D5EB | 0 |  |  | 12 |
| $D600 | store_cursor_line | 11 |  |  | 12 |
| $D617 | L_D617 | 0 |  |  | 3 |
| $D61A | load_line_record | 8 |  |  | 13 |
| $D640 | free_line_record | 8 |  |  | 3 |
| $D645 | L_D645 | 1 | Os_mfr |  | 6 |
| $D651 | alloc_line_record | 2 | Os_mal, Os_mpb |  | 27 |
| $D68A | L_D68A | 0 | Os_mpb |  | 15 |
| $D6AD | L_D6AD | 0 | Os_mpb |  | 23 |
| $D6E3 | step_to_prev_record | 5 | Os_mpb |  | 21 |
| $D704 | step_to_next_record | 6 | Os_mpb |  | 22 |
| $D728 | inc_cursor_line | 6 |  |  | 4 |
| $D730 | dec_cursor_line | 3 |  |  | 4 |
| $D738 | copy_record_to_line_buffer | 1 | Os_mpb |  | 18 |
| $D766 | L_D766 | 0 |  |  | 4 |
| $D783 | L_D783 | 0 |  |  | 2 |
| $D789 | L_D789 | 0 |  | Global or selective ? (G/S)  | 2 |
| $D7AA | save_string_record | 3 |  |  | 2 |
| $D7AD | L_D7AD | 0 | Os_mal, Os_mpb |  | 22 |
| $D7CE | L_D7CE | 0 |  |  | 9 |
| $D7DD | free_string_record | 3 | Os_mfr, Os_mpb |  | 16 |
| $D7F2 | load_string_record | 4 |  |  | 7 |
| $D7FB | L_D7FB | 0 | Os_mpb |  | 4 |
| $D800 | L_D800 | 0 |  |  | 7 |
| $D809 | L_D809 | 0 |  |  | 9 |
| $D84D | L_D84D | 0 |  |  | 2 |
| $D854 | L_D854 | 0 |  |  | 3 |
| $D862 | section_could_match | 1 |  |  | 14 |
| $D87A | L_D87A | 0 |  |  | 2 |
| $D880 | far_append_guess | 0 | Os_mal, Os_mpb |  | 36 |
| $D8C1 | L_D8C1 | 0 |  |  | 14 |
| $D8D5 | L_D8D5 | 0 | Os_mpb |  | 23 |
| $D8FA | L_D8FA | 0 |  |  | 7 |
| $D909 | far_load_text_at_cursor | 0 | Gn_sop, Os_out |  | 9 |
| $D91B | L_D91B | 0 |  |  | 5 |
| $D925 | L_D925 | 0 | Gn_sop |  | 9 |
| $D939 | L_D939 | 0 | Gn_opf, Gn_sop |  | 21 |
| $D96F | L_D96F | 0 |  |  | 5 |
| $D97D | L_D97D | 0 | Os_gb |  | 13 |
| $D996 | L_D996 | 0 |  |  | 8 |
| $D9AE | L_D9AE | 0 |  |  | 5 |
| $D9B9 | L_D9B9 | 0 | Os_out |  | 6 |
| $D9C4 | L_D9C4 | 0 | Gn_cl |  | 8 |
| $D9D8 | L_D9D8 | 0 |  |  | 1 |
| $D9DA | L_D9DA | 0 |  |  | 7 |
| $D9E5 | L_D9E5 | 0 |  |  | 8 |
| $D9F6 | L_D9F6 | 0 |  |  | 4 |
| $D9FE | L_D9FE | 0 |  |  | 3 |
| $DA05 | L_DA05 | 0 |  |  | 2 |
| $DA0F | L_DA0F | 0 |  | Load text at cursor | 2 |
| $DA23 | L_DA23 | 1 | Gn_sip |  | 7 |
| $DA31 | L_DA31 | 0 |  |  | 2 |
| $DA41 | L_DA41 | 0 |  | 2JCLoading  | 3 |
| $DA56 | L_DA56 | 1 |  |  | 8 |
| $DA68 | L_DA68 | 0 |  |  | 15 |
| $DA84 | L_DA84 | 0 |  |  | 19 |
| $DAB7 | L_DAB7 | 2 |  |  | 16 |
| $DACF | L_DACF | 0 |  |  | 2 |
| $DAD1 | check_free_memory | 1 | Os_nq |  | 9 |
| $DAE1 | L_DAE1 | 1 |  |  | 9 |
| $DAF2 | L_DAF2 | 0 |  |  | 2 |
| $DAF6 | L_DAF6 | 0 |  |  | 8 |
| $DB01 | L_DB01 | 0 |  |  | 3 |
| $DB06 | L_DB06 | 3 | Gn_sop |  | 4 |
| $DB0D | L_DB0D | 0 |  |  | 2 |
| $DB17 | L_DB17 | 0 |  | Opened file | 2 |
| $DB25 | L_DB25 | 0 |  |  | 11 |
| $DB3E | L_DB3E | 0 |  |  | 9 |
| $DB53 | L_DB53 | 0 |  |  | 14 |
| $DB71 | L_DB71 | 0 |  |  | 1 |
| $DB74 | L_DB74 | 0 |  |  | 10 |
| $DB88 | L_DB88 | 0 |  |  | 13 |
| $DBA2 | L_DBA2 | 0 |  |  | 7 |
| $DBB5 | L_DBB5 | 0 |  |  | 16 |
| $DBD6 | L_DBD6 | 0 |  |  | 7 |
| $DBE2 | L_DBE2 | 0 |  |  | 10 |
| $DBF5 | L_DBF5 | 0 |  |  | 13 |
| $DC0B | L_DC0B | 0 |  |  | 5 |
| $DC12 | L_DC12 | 0 |  |  | 2 |
| $DC17 | L_DC17 | 0 |  |  | 7 |
| $DC26 | L_DC26 | 0 |  |  | 19 |
| $DC4B | L_DC4B | 0 |  |  | 5 |
| $DC53 | L_DC53 | 0 |  |  | 4 |
| $DC5D | L_DC5D | 0 |  |  | 14 |
| $DC77 | L_DC77 | 0 |  |  | 11 |
| $DC87 | L_DC87 | 2 |  |  | 4 |
| $DC8E | L_DC8E | 0 |  |  | 2 |
| $DC90 | L_DC90 | 0 | Os_mpb |  | 15 |
| $DCA8 | L_DCA8 | 0 | Os_mpb |  | 25 |
| $DCD2 | L_DCD2 | 0 |  |  | 21 |
| $DCF8 | L_DCF8 | 0 |  |  | 3 |
| $DCFE | wf_option_3_find_close_matches | 1 | Gn_sop |  | 11 |
| $DD17 | L_DD17 | 0 |  |  | 14 |
| $DD35 | L_DD35 | 0 |  |  | 13 |
| $DD53 | L_DD53 | 0 |  |  | 7 |
| $DD64 | L_DD64 | 0 |  |  | 4 |
| $DD6D | L_DD6D | 0 |  |  | 12 |
| $DD8A | is_one_edit_away | 1 |  |  | 17 |
| $DDAD | L_DDAD | 0 |  |  | 5 |
| $DDB4 | L_DDB4 | 0 |  |  | 3 |
| $DDB8 | L_DDB8 | 0 |  |  | 2 |
| $DDBA | L_DDBA | 0 |  |  | 7 |
| $DDC9 | L_DDC9 | 0 |  |  | 3 |
| $DDCD | L_DDCD | 0 |  |  | 4 |
| $DDD3 | L_DDD3 | 0 |  |  | 13 |
| $DDE4 | L_DDE4 | 0 |  |  | 3 |
| $DDE9 | L_DDE9 | 0 |  |  | 7 |
| $DDF8 | L_DDF8 | 0 |  |  | 7 |
| $DE02 | L_DE02 | 0 |  |  | 4 |
| $DE09 | L_DE09 | 0 |  |  | 8 |
| $DE19 | L_DE19 | 0 |  |  | 7 |
| $DE24 | L_DE24 | 0 |  |  | 4 |
| $DE2B | L_DE2B | 0 |  |  | 123 |
| $E203 | wf_option_1_browse_dictionary | 1 | Gn_sop, Os_mal, Os_mpb |  | 25 |
| $E237 | L_E237 | 0 |  |  | 1 |
| $E23A | L_E23A | 0 |  |  | 1 |
| $E23D | L_E23D | 0 |  |  | 3 |
| $E246 | L_E246 | 0 | Os_in, Os_out |  | 20 |
| $E26D | L_E26D | 0 | Os_out |  | 8 |
| $E27D | L_E27D | 0 |  |  | 2 |
| $E281 | L_E281 | 0 |  |  | 4 |
| $E28C | L_E28C | 0 |  |  | 9 |
| $E2A0 | L_E2A0 | 0 |  |  | 5 |
| $E2AA | L_E2AA | 0 |  |  | 3 |
| $E2B1 | L_E2B1 | 0 | Os_mpb |  | 17 |
| $E2D0 | L_E2D0 | 0 |  |  | 9 |
| $E2E3 | L_E2E3 | 0 |  |  | 2 |
| $E2E8 | L_E2E8 | 0 |  |  | 1 |
| $E2EB | L_E2EB | 0 |  |  | 3 |
| $E2F3 | L_E2F3 | 0 |  |  | 9 |
| $E30D | L_E30D | 0 |  |  | 9 |
| $E320 | L_E320 | 0 |  |  | 2 |
| $E325 | L_E325 | 0 |  |  | 3 |
| $E32C | L_E32C | 0 |  |  | 9 |
| $E33A | L_E33A | 0 |  |  | 1 |
| $E33D | L_E33D | 0 |  |  | 4 |
| $E348 | L_E348 | 0 |  |  | 2 |
| $E34C | L_E34C | 0 |  |  | 5 |
| $E35A | L_E35A | 0 |  |  | 8 |
| $E36D | L_E36D | 0 |  |  | 3 |
| $E375 | next_section_letters | 3 |  |  | 4 |
| $E37E | L_E37E | 0 |  |  | 14 |
| $E39A | prev_section_letters | 2 |  |  | 4 |
| $E3A3 | L_E3A3 | 0 |  |  | 14 |
| $E3BF | draw_browse_page | 3 | Os_out |  | 4 |
| $E3C5 | L_E3C5 | 0 | Os_out |  | 10 |
| $E3D6 | L_E3D6 | 0 | Os_out |  | 9 |
| $E3E3 | L_E3E3 | 2 | Gn_sop |  | 11 |
| $E3FC | L_E3FC | 0 |  |  | 2 |
| $E3FE | L_E3FE | 0 |  |  | 9 |
| $E40C | L_E40C | 0 |  |  | 6 |
| $E413 | L_E413 | 0 | Gn_sop, Os_mfr |  | 10 |
| $E429 | L_E429 | 0 |  |  | 2 |
| $E433 | print_current_word | 4 |  |  | 5 |
| $E43C | L_E43C | 0 | Os_out |  | 9 |
| $E447 | browse_next_word | 4 |  |  | 8 |
| $E459 | L_E459 | 0 |  |  | 7 |
| $E468 | L_E468 | 0 |  |  | 5 |
| $E476 | L_E476 | 0 |  |  | 9 |
| $E48B | L_E48B | 0 |  |  | 3 |
| $E492 | L_E492 | 0 |  |  | 4 |
| $E49B | L_E49B | 0 |  |  | 11 |
| $E4B3 | L_E4B3 | 0 |  |  | 5 |
| $E4C0 | L_E4C0 | 0 |  |  | 7 |
| $E4D3 | browse_prev_word | 2 |  |  | 5 |
| $E4E0 | L_E4E0 | 0 |  |  | 5 |
| $E4E8 | L_E4E8 | 0 |  |  | 13 |
| $E502 | L_E502 | 0 |  |  | 2 |
| $E508 | L_E508 | 0 |  |  | 7 |
| $E51B | L_E51B | 0 |  |  | 11 |
| $E537 | L_E537 | 0 |  |  | 4 |
| $E540 | L_E540 | 0 |  |  | 5 |
| $E547 | L_E547 | 0 |  |  | 6 |
| $E553 | L_E553 | 2 |  |  | 1 |
| $E556 | L_E556 | 0 |  |  | 10 |
| $E567 | L_E567 | 0 |  |  | 4 |
| $E570 | L_E570 | 0 |  |  | 13 |
| $E58D | L_E58D | 0 |  |  | 3 |
| $E595 | L_E595 | 0 |  |  | 4 |
| $E59B | L_E59B | 0 |  |  | 8 |
| $E5AA | L_E5AA | 1 |  |  | 5 |
| $E5B4 | L_E5B4 | 0 |  |  | 8 |
| $E5C3 | L_E5C3 | 0 |  |  | 11 |
| $E5D9 | L_E5D9 | 0 |  |  | 2 |
| $E5DB | no_user_word | 2 |  |  | 5 |
| $E5E5 | next_full_word | 6 |  |  | 16 |
| $E603 | L_E603 | 0 |  |  | 9 |
| $E616 | L_E616 | 2 |  |  | 12 |
| $E62E | browse_seek_prefix | 2 | Os_mpb |  | 14 |
| $E649 | L_E649 | 0 |  |  | 4 |
| $E653 | L_E653 | 0 |  |  | 8 |
| $E669 | L_E669 | 0 |  |  | 5 |
| $E674 | L_E674 | 0 |  |  | 8 |
| $E685 | L_E685 | 0 |  |  | 10 |
| $E692 | L_E692 | 0 |  |  | 2 |
| $E695 | L_E695 | 0 |  |  | 6 |
| $E6A0 | L_E6A0 | 0 |  |  | 9 |
| $E6AC | L_E6AC | 0 |  |  | 2 |
| $E6AF | L_E6AF | 0 |  |  | 15 |
| $E6D0 | L_E6D0 | 0 |  |  | 2 |
| $E6D5 | L_E6D5 | 0 |  |  | 1 |
| $E6DC | L_E6DC | 0 |  |  | 2 |
| $E6E1 | toggle_reverse | 2 | Gn_sop |  | 4 |
| $E6E8 | L_E6E8 | 0 |  |  | 1 |
| $E6EB | QuickEdit_topics | 0 |  |  | 1 |
| $E6EC | QuickEdit_tpc1 | 0 |  |  | 2 |
| $E6F7 | QuickEdit_tpc1_end | 0 |  |  | 1 |
| $E6F8 | QuickEdit_tpc2 | 0 |  |  | 2 |
| $E703 | QuickEdit_tpc2_end | 0 |  |  | 1 |
| $E704 | QuickEdit_tpc3 | 0 |  |  | 2 |
| $E70D | QuickEdit_tpc3_end | 0 |  |  | 1 |
| $E70E | QuickEdit_tpc4 | 0 |  |  | 2 |
| $E718 | QuickEdit_tpc4_end | 0 |  |  | 1 |
| $E719 | QuickEdit_tpc5 | 0 |  |  | 1 |
| $E71A | L_E71A | 0 |  | SPELLING | 2 |
| $E726 | QuickEdit_tpc5_end | 0 |  |  | 1 |
| $E728 | QuickEdit_commands | 0 |  |  | 1 |
| $E729 | QuickEdit_cmd1 | 0 |  |  | 2 |
| $E72D | L_E72D | 0 |  | Insert marker | 2 |
| $E73B | QuickEdit_cmd1_end | 0 |  |  | 1 |
| $E73C | QuickEdit_cmd2 | 0 |  |  | 1 |
| $E741 | L_E741 | 0 |  | Copy marked block | 2 |
| $E753 | QuickEdit_cmd2_end | 0 |  |  | 1 |
| $E754 | QuickEdit_cmd3 | 0 |  |  | 1 |
| $E759 | L_E759 | 0 |  | Move marked block | 2 |
| $E76B | QuickEdit_cmd3_end | 0 |  |  | 1 |
| $E76C | QuickEdit_cmd4 | 0 |  |  | 1 |
| $E771 | L_E771 | 0 |  | Delete marked block | 2 |
| $E785 | QuickEdit_cmd4_end | 0 |  |  | 1 |
| $E786 | QuickEdit_cmd5 | 0 |  |  | 1 |
| $E78C | L_E78C | 0 |  | Search for string | 2 |
| $E79E | QuickEdit_cmd5_end | 0 |  |  | 1 |
| $E79F | QuickEdit_cmd6 | 0 |  |  | 1 |
| $E7A5 | L_E7A5 | 0 |  | Next Match | 2 |
| $E7B0 | QuickEdit_cmd6_end | 0 |  |  | 1 |
| $E7B1 | QuickEdit_cmd7 | 0 |  |  | 1 |
| $E7B7 | L_E7B7 | 0 |  | Search and Replace | 2 |
| $E7CA | QuickEdit_cmd7_end | 0 |  |  | 1 |
| $E7CB | QuickEdit_cmd8 | 0 |  |  | 1 |
| $E7CF | L_E7CF | 0 |  | Remove markers | 2 |
| $E7DE | QuickEdit_cmd8_end | 0 |  |  | 1 |
| $E7E0 | QuickEdit_cmd9 | 0 |  |  | 1 |
| $E7E4 | L_E7E4 | 0 |  | Screen up | 2 |
| $E7EE | QuickEdit_cmd9_end | 0 |  |  | 1 |
| $E7EF | QuickEdit_cmd10 | 0 |  |  | 1 |
| $E7F3 | L_E7F3 | 0 |  | Screen down | 2 |
| $E7FF | QuickEdit_cmd10_end | 0 |  |  | 1 |
| $E800 | QuickEdit_cmd11 | 0 |  |  | 1 |
| $E804 | L_E804 | 0 |  | Cursor  | 1 |
| $E80B | L_E80B | 0 |  | left | 2 |
| $E810 | QuickEdit_cmd11_end | 0 |  |  | 1 |
| $E811 | QuickEdit_cmd12 | 0 |  |  | 1 |
| $E815 | L_E815 | 0 |  | Cursor right | 2 |
| $E822 | QuickEdit_cmd12_end | 0 |  |  | 1 |
| $E823 | QuickEdit_cmd13 | 0 |  |  | 1 |
| $E827 | L_E827 | 0 |  | Cursor up | 2 |
| $E831 | QuickEdit_cmd13_end | 0 |  |  | 1 |
| $E832 | QuickEdit_cmd14 | 0 |  |  | 1 |
| $E836 | L_E836 | 0 |  | Cursor down | 2 |
| $E842 | QuickEdit_cmd14_end | 0 |  |  | 1 |
| $E843 | QuickEdit_cmd15 | 0 |  |  | 1 |
| $E847 | L_E847 | 0 |  | Top of text | 2 |
| $E853 | QuickEdit_cmd15_end | 0 |  |  | 1 |
| $E854 | QuickEdit_cmd16 | 0 |  |  | 1 |
| $E858 | L_E858 | 0 |  | Bottom of text | 2 |
| $E867 | QuickEdit_cmd16_end | 0 |  |  | 1 |
| $E868 | QuickEdit_cmd17 | 0 |  |  | 1 |
| $E86C | L_E86C | 0 |  | Start of line | 2 |
| $E87A | QuickEdit_cmd17_end | 0 |  |  | 1 |
| $E87B | QuickEdit_cmd18 | 0 |  |  | 1 |
| $E87F | L_E87F | 0 |  | End of line | 2 |
| $E88B | QuickEdit_cmd18_end | 0 |  |  | 1 |
| $E88C | QuickEdit_cmd19 | 0 |  |  | 1 |
| $E890 | L_E890 | 0 |  | Next word | 2 |
| $E89A | QuickEdit_cmd19_end | 0 |  |  | 1 |
| $E89B | QuickEdit_cmd20 | 0 |  |  | 1 |
| $E89F | L_E89F | 0 |  | Previous word | 2 |
| $E8AD | QuickEdit_cmd20_end | 0 |  |  | 1 |
| $E8AE | QuickEdit_cmd21 | 0 |  |  | 1 |
| $E8B2 | L_E8B2 | 0 |  | Insert/Over | 2 |
| $E8BE | QuickEdit_cmd21_end | 0 |  |  | 1 |
| $E8BF | QuickEdit_cmd22 | 0 |  |  | 2 |
| $E8CA | QuickEdit_cmd22_end | 0 |  |  | 1 |
| $E8CB | QuickEdit_cmd23 | 0 |  |  | 2 |
| $E8D3 | QuickEdit_cmd23_end | 0 |  |  | 1 |
| $E8D4 | QuickEdit_cmd24 | 0 |  |  | 2 |
| $E8D8 | L_E8D8 | 0 |  | Insert real tab | 2 |
| $E8E8 | QuickEdit_cmd24_end | 0 |  |  | 1 |
| $E8EA | QuickEdit_cmd25 | 0 |  |  | 2 |
| $E8F5 | QuickEdit_cmd25_end | 0 |  |  | 1 |
| $E8F6 | QuickEdit_cmd26 | 0 |  |  | 2 |
| $E8FA | L_E8FA | 0 |  | Delete character | 2 |
| $E90B | QuickEdit_cmd26_end | 0 |  |  | 1 |
| $E90C | QuickEdit_cmd27 | 0 |  |  | 1 |
| $E90D | L_E90D | 0 |  |  | 1 |
| $E910 | L_E910 | 0 |  | Delete line | 2 |
| $E91C | QuickEdit_cmd27_end | 0 |  |  | 1 |
| $E91D | QuickEdit_cmd28 | 0 |  |  | 1 |
| $E921 | L_E921 | 0 |  | Swap case | 2 |
| $E92B | QuickEdit_cmd28_end | 0 |  |  | 1 |
| $E92C | QuickEdit_cmd29 | 0 |  |  | 1 |
| $E932 | L_E932 | 0 |  | Join lines | 2 |
| $E93D | QuickEdit_cmd29_end | 0 |  |  | 1 |
| $E93E | QuickEdit_cmd30 | 0 |  |  | 1 |
| $E944 | L_E944 | 0 |  | Split line | 2 |
| $E94F | QuickEdit_cmd30_end | 0 |  |  | 1 |
| $E950 | QuickEdit_cmd31 | 0 |  |  | 1 |
| $E954 | L_E954 | 0 |  | Format paragraph | 2 |
| $E965 | QuickEdit_cmd31_end | 0 |  |  | 1 |
| $E966 | QuickEdit_cmd32 | 0 |  |  | 1 |
| $E96A | L_E96A | 0 |  | Information | 2 |
| $E976 | QuickEdit_cmd32_end | 0 |  |  | 1 |
| $E978 | QuickEdit_cmd33 | 0 |  |  | 1 |
| $E97D | L_E97D | 0 |  | Load text | 2 |
| $E987 | QuickEdit_cmd33_end | 0 |  |  | 1 |
| $E988 | QuickEdit_cmd34 | 0 |  |  | 1 |
| $E98D | L_E98D | 0 |  | Save text | 2 |
| $E997 | QuickEdit_cmd34_end | 0 |  |  | 1 |
| $E998 | QuickEdit_cmd35 | 0 |  |  | 1 |
| $E99E | L_E99E | 0 |  | Save marked block | 2 |
| $E9B0 | QuickEdit_cmd35_end | 0 |  |  | 1 |
| $E9B1 | QuickEdit_cmd36 | 0 |  |  | 1 |
| $E9B7 | L_E9B7 | 0 |  | Merge text at cursor | 2 |
| $E9CC | QuickEdit_cmd36_end | 0 |  |  | 1 |
| $E9CD | QuickEdit_cmd37 | 0 |  |  | 1 |
| $E9D3 | L_E9D3 | 0 |  | Load user dictionary | 2 |
| $E9E8 | QuickEdit_cmd37_end | 0 |  |  | 1 |
| $E9E9 | QuickEdit_cmd38 | 0 |  |  | 1 |
| $E9EF | L_E9EF | 0 |  | Save user dictionary | 2 |
| $EA04 | QuickEdit_cmd38_end | 0 |  |  | 1 |
| $EA05 | QuickEdit_cmd39 | 0 |  |  | 1 |
| $EA0A | L_EA0A | 0 |  | Change name | 2 |
| $EA16 | QuickEdit_cmd39_end | 0 |  |  | 1 |
| $EA17 | QuickEdit_cmd40 | 0 |  |  | 1 |
| $EA1D | L_EA1D | 0 |  | Export text | 2 |
| $EA29 | QuickEdit_cmd40_end | 0 |  |  | 1 |
| $EA2A | QuickEdit_cmd41 | 0 |  |  | 1 |
| $EA2F | L_EA2F | 0 |  | Print out text | 2 |
| $EA3E | QuickEdit_cmd41_end | 0 |  |  | 1 |
| $EA40 | QuickEdit_cmd42 | 0 |  |  | 1 |
| $EA45 | L_EA45 | 0 |  | Check all text | 2 |
| $EA54 | QuickEdit_cmd42_end | 0 |  |  | 1 |
| $EA55 | QuickEdit_cmd43 | 0 |  |  | 1 |
| $EA5A | L_EA5A | 0 |  | Check from cursor | 2 |
| $EA6C | QuickEdit_cmd43_end | 0 |  |  | 1 |
| $EA6D | QuickEdit_cmd44 | 0 |  |  | 1 |
| $EA72 | L_EA72 | 0 |  | Check this word | 2 |
| $EA82 | QuickEdit_cmd44_end | 0 |  |  | 1 |
| $EA83 | QuickEdit_cmd45 | 0 |  |  | 1 |
| $EA88 | L_EA88 | 0 |  | Check marked block | 2 |
| $EA9B | QuickEdit_cmd45_end | 0 |  |  | 1 |
| $EA9C | QuickEdit_cmd46 | 0 |  |  | 1 |
| $EAA1 | L_EAA1 | 0 |  | Check as you type | 2 |
| $EAB3 | QuickEdit_cmd46_end | 0 |  |  | 1 |
| $EAB5 | QuickEdit_help | 0 |  | for the Z88 | 2 |
| $EAC1 | L_EAC1 | 0 |  | Written by James Lynn | 2 |
| $EAF7 | L_EAD7 | 0 |  | Copyright (C) 1988 Computer Co | 2 |
| $EB01 | L_EB01 | 0 |  | Cartridge version 1.05 | 4 |
| $EB29 | QuickEdit_help_page2 | 0 |  | Cursor movement commands | 2 |
| $EB42 | QuickEdit_help_page3 | 0 |  | Text manipulation commands | 2 |
| $EB5D | QuickEdit_help_page4 | 0 |  | Filing system commands | 2 |
| $EB74 | QuickEdit_help_page5 | 0 |  | Spelling check commands | 2 |
| $EB8C | QuickEdit_help_page1 | 0 |  | Block move commands | 2 |
| $EBA0 | WordFinder_topics | 0 |  |  | 1 |
| $EBA1 | WordFinder_tpc1 | 0 |  |  | 2 |
| $EBAC | WordFinder_tpc1_end | 0 |  |  | 1 |
| $EBAE | WordFinder_commands | 0 |  |  | 1 |
| $EBAF | WordFinder_cmd1 | 0 |  |  | 2 |
| $EBB3 | L_EBB3 | 0 |  | Cu | 1 |
| $EBB5 | L_EBB5 | 0 |  | rso | 1 |
| $EBB8 | L_EBB8 | 0 |  | r | 1 |
| $EBB9 | L_EBB9 | 0 |  |  left | 2 |
| $EBBF | WordFinder_cmd1_end | 0 |  |  | 1 |
| $EBC0 | WordFinder_cmd2 | 0 |  |  | 1 |
| $EBC4 | L_EBC4 | 0 |  | Cursor righ | 1 |
| $EBCF | L_EBCF | 0 |  | t | 2 |
| $EBD1 | WordFinder_cmd2_end | 0 |  |  | 1 |
| $EBD2 | WordFinder_cmd3 | 0 |  |  | 1 |
| $EBD6 | L_EBD6 | 0 |  | Cu | 1 |
| $EBD8 | L_EBD8 | 0 |  | rsor up | 2 |
| $EBE0 | WordFinder_cmd3_end | 0 |  |  | 1 |
| $EBE1 | WordFinder_cmd4 | 0 |  |  | 1 |
| $EBE5 | L_EBE5 | 0 |  | Cu | 1 |
| $EBE7 | L_EBE7 | 0 |  | rsor down | 2 |
| $EBF1 | WordFinder_cmd4_end | 0 |  |  | 1 |
| $EBF2 | WordFinder_cmd5 | 0 |  |  | 1 |
| $EBF6 | L_EBF6 | 0 |  | Up a  | 1 |
| $EBFB | L_EBFB | 0 |  | categ | 1 |
| $EC00 | L_EC00 | 0 |  | ory | 2 |
| $EC04 | WordFinder_cmd5_end | 0 |  |  | 1 |
| $EC05 | WordFinder_cmd6 | 0 |  |  | 1 |
| $EC09 | L_EC09 | 0 |  | Down a category | 2 |
| $EC19 | WordFinder_cmd6_end | 0 |  |  | 1 |
| $EC1A | WordFinder_cmd7 | 0 |  |  | 1 |
| $EC1E | L_EC1E | 0 |  | Previous  | 1 |
| $EC27 | L_EC27 | 0 |  | initial letter | 2 |
| $EC36 | WordFinder_cmd7_end | 0 |  |  | 1 |
| $EC37 | WordFinder_cmd8 | 0 |  |  | 1 |
| $EC3B | L_EC3B | 0 |  | Nex | 1 |
| $EC3E | L_EC3E | 0 |  | t initial letter | 2 |
| $EC4F | WordFinder_cmd8_end | 0 |  |  | 1 |
| $EC50 | WordFinder_cmd9 | 0 |  |  | 1 |
| $EC51 | L_EC51 | 0 |  |  | 1 |
| $EC53 | L_EC53 | 0 |  |  | 2 |
| $EC5B | WordFinder_cmd9_end | 0 |  |  | 1 |
| $EC5D | open_dialog_centre | 3 |  |  | 2 |
| $EC62 | open_dialog_wide | 1 |  |  | 2 |
| $EC67 | open_dialog_mid | 3 |  |  | 2 |
| $EC6C | open_dialog_wf | 4 |  |  | 2 |
| $EC71 | open_dialog_right | 1 |  |  | 1 |
| $EC74 | L_EC74 | 0 |  |  | 3 |
| $EC82 | L_EC82 | 1 | Gn_sop |  | 5 |
| $EC90 | open_dialog_with_title | 0 |  |  | 1 |
| $EC91 | L_EC91 | 0 | Gn_sop |  | 7 |
| $EC9C | L_EC9C | 0 | Gn_sop |  | 10 |
| $ECAA | L_ECAA | 0 | Gn_sop |  | 10 |
| $ECBB | L_ECBB | 0 |  |  | 2 |
| $ECC5 | L_ECC5 | 0 |  |  | 3 |
| $ECDA | L_ECDA | 0 |  |  | 2 |
| $ECDF | L_ECDF | 0 |  |  | 3 |
| $ECEF | L_ECEF | 0 |  |  | 2 |
| $ECF9 | L_ECF9 | 0 |  |  | 2 |
| $ED03 | L_ED03 | 0 |  |  | 2 |
| $ED0D | L_ED0D | 0 |  |  | 2 |
| $ED17 | L_ED17 | 0 |  |  | 6 |
| $ED3D | L_ED3D | 0 |  |  | 2 |
| $ED4B | L_ED4B | 0 | Os_mgb, Os_mpb |  | 14 |
| $FFC0 | frontdor | 0 |  | APPL | 9 |
| $FFD3 | frontdor_end | 0 |  |  | 5 |
| $FFF8 | romhdr | 0 |  | OZ | 7 |
