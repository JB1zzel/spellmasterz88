# The Spell-Master dictionary format

This describes how the word list is stored in banks SPELL.56 to SPELL.61, and how the code reads it. It was worked out from the code (`read_dictionary_record`, `expand_word`, `find_dictionary_section`, `dictionary_lookup`) and checked by decoding the whole dictionary: all sections decode, every section ends exactly where the next one starts, and the words come out in alphabetical order. `tools/spelldict.py` reads the ROM files using this description.

## In numbers

- 302 sections (one for each two-letter start that occurs), 32,497 stored words, **57,971** distinct words once inflected forms are added.
- Longest accepted form: 29 letters; 10690 words are marked 'takes -S', 5274 stored words carry an inflection class.
- The six dictionary banks hold about 94,840 bytes of the 98,304 available (bank SPELL.61 has 3,461 bytes free at its end).

## 1. Where things are

| item | where |
|---|---|
| the six dictionary banks | SPELL.56 to SPELL.61 (bank numbers $38-$3D); one is bound into segment 2 ($8000-$BFFF) at a time |
| first-letter index | SPELL.62 at $E84E (`first_letter_index`) |
| token strings and their pointer table | SPELL.62 at $C38A and $C4A4 (bank 63 has a copy at $CC73) |
| inflection class endings | SPELL.62, table at $DDAF (`inflection_class_table`) |

## 2. The index

`first_letter_index` has 26 words, one for each first letter A to Z. Each points to a list of three-byte entries for that letter, ending with $FF. An entry is:

| byte | meaning |
|---|---|
| 0 | bits 0-4: the second letter (0 = apostrophe, 1 to 26 = A to Z); bits 5-7: which dictionary bank (0 to 5 = SPELL.56 to SPELL.61) |
| 1, 2 | offset of the section within the bank, low byte first, as an address in segment 2 ($8000 to $BFFF) |

Example: the first entry for A is `01 01 80`: second letter A, bank 0 (SPELL.56), offset $8001, the section for words starting AA. The next entry `02 0C 80` is for AB at $800C. The first letter is not stored, and the two letters are not repeated in the words that follow.

## 3. A section

A section is a run of records for the words that start with the two letters, in alphabetical order, ending with a single byte $0F where the next record would start.

A **record** is a first byte followed by the letters of the word. The record ends where the next record's first byte begins: that is any byte whose value, ignoring bit 5, is below $10.

| first byte | meaning |
|---|---|
| bits 0-3 | how many letters to keep from the previous word (not counting the two-letter start) |
| bit 5 ($20) | the word also takes -S (it is accepted with an S added) |

The bytes after it:

| byte | meaning |
|---|---|
| $41-$5A | a letter A to Z |
| $40 | an apostrophe |
| $80-$FF | a token: bits 0-6 index the token table, and the token's letters are added |
| $10-$1F | an inflection class; ends the word (see section 5) |

**Worked example, the section AA in SPELL.56 from offset $8001:**

```
20 52 44 56 BB 4B 02 57 E1 46 0F
```

- `20`: keep 0 letters, bit 5 set (takes -S).
- `52 44 56`: R D V. `BB`: token number $3B = 59, which is `AR`. `4B`: K. The word is AA + RDV + AR + K = AARDVARK, and AARDVARKS.
- `02`: the next record starts here: keep 2 letters (`RD`).
- `57 E1 46`: W, token $61 = 97 = `OL`, F: AA + RD + WOLF = AARDWOLF.
- `0F`: end of the section. The next section (AB) starts at the next byte, $800C.

**A word with an inflection class, section DA in SPELL.57 from offset $8D59:**

```
20 42   01 F0 13   23 A4
```

- `20 42`: DAB (takes -S).
- `01 F0 13`: keep 1 letter (B), token $70 = `BL`, then the class byte $13: DABBL. Class $13 means DABBLE, DABBLED, DABBLES, DABBLING.
- `23 A4`: keep 3 letters (BBL), token $24 = `ER`: DABBLER (takes -S).

## 4. Tokens

A byte of $80 or more stands for a short group of letters. The table of pointers is at $C4A4 and the strings are stored from $C38A, each beginning with a letter that has bit 7 set. Tokens 0 to 121 are used: token 0 is TION (four letters), tokens 1 to 35 have three letters and tokens 36 to 121 have two. Numbers 122 to 127 are not used (their pointers lead to meaningless bytes). The groups were chosen to shorten the dictionary; they are not only word endings.

| number | string | number | string | number | string | number | string |
|---|---|---|---|---|---|---|---|
| 0 | TION | 31 | ICA | 62 | SE | 93 | TH |
| 1 | WAY | 32 | TOR | 63 | TA | 94 | HE |
| 2 | ITY | 33 | GHT | 64 | LL | 95 | LY |
| 3 | IES | 34 | ALI | 65 | RO | 96 | DI |
| 4 | MAN | 35 | LIN | 66 | CE | 97 | OL |
| 5 | IAN | 36 | ER | 67 | DE | 98 | UR |
| 6 | ISM | 37 | IN | 68 | SI | 99 | AC |
| 7 | FUL | 38 | TE | 69 | LA | 100 | MI |
| 8 | IAL | 39 | TI | 70 | ME | 101 | OO |
| 9 | ING | 40 | AT | 71 | VE | 102 | EA |
| 10 | ION | 41 | ON | 72 | US | 103 | CK |
| 11 | ATI | 42 | LE | 73 | NI | 104 | AS |
| 12 | ATE | 43 | EN | 74 | IA | 105 | RT |
| 13 | MIN | 44 | ES | 75 | ND | 106 | AB |
| 14 | ENT | 45 | AN | 76 | ET | 107 | AD |
| 15 | TER | 46 | NG | 77 | SS | 108 | AG |
| 16 | NCE | 47 | ED | 78 | TO | 109 | AI |
| 17 | MEN | 48 | NT | 79 | NA | 110 | FF |
| 18 | TIC | 49 | ST | 80 | OU | 111 | BE |
| 19 | TIN | 50 | RI | 81 | CH | 112 | BL |
| 20 | ESS | 51 | AL | 82 | TR | 113 | BO |
| 21 | INE | 52 | IS | 83 | GE | 114 | CI |
| 22 | OUS | 53 | IC | 84 | PE | 115 | CO |
| 23 | TED | 54 | RE | 85 | EL | 116 | CU |
| 24 | BLE | 55 | RA | 86 | IL | 117 | EC |
| 25 | RAT | 56 | LI | 87 | LO | 118 | EE |
| 26 | ISE | 57 | IO | 88 | NS | 119 | EM |
| 27 | IVE | 58 | OR | 89 | NC | 120 | FI |
| 28 | ANT | 59 | AR | 90 | MA | 121 | SH |
| 29 | IST | 60 | IT | 91 | CA |  |  |
| 30 | ABL | 61 | NE | 92 | CT |  |  |

## 5. Inflection classes

A class byte ($10 to $16) says which endings may be added to the stored stem. A stem with a class below $13 is also accepted by itself; classes $13 and above are not words on their own (SIZZL is not a word, SIZZLE is).

| class | endings added | stored words | example |
|---|---|---|---|
| (bit 5 only) | S | 10,690 | AARDVARK |
| $10 | ED ING S | 2,007 | SKIRT (SKIRT, SKIRTED, SKIRTING, SKIRTS) |
| $11 | S | 0 |  |
| $12 | ED ES ING | 265 | SQUELCH (SQUELCH, SQUELCHED, SQUELCHES, SQUELCHING) |
| $13 | E ED ES ING | 1,889 | SIZZL (SIZZLE, SIZZLED, SIZZLES, SIZZLING) |
| $14 | IES Y | 622 | LULLAB (LULLABIES, LULLABY) |
| $15 | E Y | 293 | HOSPITABL (HOSPITABLE, HOSPITABLY) |
| $16 | ISE ISED ISES ISING IZE IZED IZES IZING | 198 | LOCAL (LOCALISE, LOCALISED, LOCALISES, LOCALISING) |

Class $11 (S only) is never stored as a byte: it is what bit 5 of the first byte becomes when the record is read. Class $16 accepts both -ISE and -IZE spellings.

## 6. How a word is looked up

`dictionary_lookup` (bank 62 $C051):

1. Take the first two letters of the word and find their section with `find_dictionary_section`: index by the first letter, then search that list for the second letter. If there is no entry, the word is not in the dictionary. `bind_dictionary_bank` binds the section's bank into segment 2.
2. Read the first record (`read_dictionary_record`) and expand it (`expand_word`): keep the stated number of letters from the previous word and add the new letters and tokens. This is front coding.
3. Compare the first letter after the two-letter start with the word's third letter. Equal: compare the rest (`compare_expanded_word`), trying each ending of the stem's inflection class as well. Greater: the word is not in the dictionary (the words are sorted, so it cannot appear later). Less: `skip_to_next_letter_group` jumps to the next record whose first byte is 0 (a word sharing no letters with its predecessor) and tries again.
4. A $0F where a record should start ends the section: not found.

The lookup is a straight scan through the section, which is short (the 302 sections average about 108 words).

## 7. Words with an apostrophe

The dictionary holds 45 contractions, for example AREN'T, CAN'T, COULD'VE, COULDN'T, DIDN'T, DOESN'T, DON'T, HASN'T. An apostrophe is stored as $40. Only two sections use an apostrophe as the second letter: I' (I'D, I'LL, I'M, I'VE) and O' (O'CLOCK); for the others the apostrophe comes later in the word.

## 8. What is not yet known

- The user dictionary format (saved and loaded by the QuickEdit commands) was not examined.
- The meaning of every flag was inferred from the endings in each class and from the lookup code; no program was run.
- Whether capitalised and lower-case forms are handled elsewhere was not examined; the dictionary itself holds capital letters only.

