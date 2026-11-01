; **************************************************************************************************
; standard elf header for command binaries
;
; This file is part of the Z88 operating system, OZ.
;
; OZ is free software; you can redistribute it and/or modify it under the terms of the GNU General
; Public License as published by the Free Software Foundation; either version 2, or (at your option)
; any later version. OZ is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY
; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
; See the GNU General Public License for more details.
;
; (C) Thierry Peycru, 2021
;
; ***************************************************************************************************
;
; NOTES:
; ------
;
; contains the elf header (EH) and the program header tables (PHT)
;
; EXEC_ORG is defined by command definition, when null, elf is relocatable
;
; SIZEOF_Workspace, PRG_BEGIN, PRG_END, DYN_BEGIN and DYN_END
; are defined by specific application that performs final linking
;

include "elf.def"

IF EXEC_ORG

; static elf executable

.ELFHDR_START
        defm    $7F, "ELF"
        defb    ELFCLASS32                      ; 32-bit objects        e_ident[EI_CLASS]
        defb    ELFDATA2LSB                     ; little endian         e_ident[EI_DATA]
        defb    EV_CURRENT                      ; always                e_ident[EI_VERSION]
        defb    ELFOSABI_OZ                     ; OZ                    e_ident[EI_OSABI]
        defb    ELFABIVERSION                   ; unspecified
        defs    7 (0)

        defw    ET_EXEC                         ; elf type
        defw    EM_Z80                          ; machine architecture
        defl    EV_CURRENT                      ; always CURRENT
        defl    EXEC_ORG                        ; entry address
        defl    PHT_START - ELFHDR_START        ; program header offset
        defl    0                               ; section header offset
        defl    0                               ; processor specific flags
        defw    EH_SIZEOF                       ; elf header size in bytes (52)
        defw    PHT_SIZEOF                      ; program header entry size (32)
        defw    1                               ; number of program header entries
        defw    SHT_SIZEOF                      ; section header entry size (40)
        defw    0                               ; number of section header entries
        defw    0                               ; section name string index

.PHT_START

; PHT1 : text (code)

        defl    PT_LOAD                         ; type
        defl    PRG_BEGIN - ELFHDR_START        ; p_offset
        defl    EXEC_ORG                        ; virtual address
        defl    0                               ; physical address
        defl    PRG_END - PRG_BEGIN             ; code size
        defl    PRG_END - PRG_BEGIN + SIZEOF_Workspace  ; memory size requested, up to 56K
        defl    PF_X | PF_R                     ; executable
        defl    $00010000                       ; 64K alignement

ELSE

; relocatable elf

.ELFHDR_START
        defm    $7F, "ELF"
        defb    ELFCLASS32                      ; 32-bit objects        e_ident[EI_CLASS]
        defb    ELFDATA2LSB                     ; little endian         e_ident[EI_DATA]
        defb    EV_CURRENT                      ; always                e_ident[EI_VERSION]
        defb    ELFOSABI_OZ                     ; OZ                    e_ident[EI_OSABI]
        defb    ELFABIVERSION                   ; unspecified
        defs    7 (0)

        defw    ET_DYN                          ; elf type : position independant executable
        defw    EM_Z80                          ; machine architecture
        defl    EV_CURRENT                      ; always CURRENT
        defl    0                               ; entry address (relocatable)
        defl    PHT_START - ELFHDR_START        ; program header offset
        defl    0                               ; section header offset
        defl    0                               ; processor specific flags
        defw    EH_SIZEOF                       ; elf header size in bytes (52)
        defw    PHT_SIZEOF                      ; program header entry size (32)
        defw    2                               ; number of program header entries
        defw    SHT_SIZEOF                      ; section header entry size (40)
        defw    0                               ; number of section header entries
        defw    0                               ; section name string index

.PHT_START

; PHT1 : relocation table, always before code

        defl    PT_DYNAMIC                      ; type
        defl    DYN_BEGIN - ELFHDR_START        ; p_offset
        defl    0                               ; virtual address
        defl    0                               ; physical address
        defl    DYN_END - DYN_BEGIN             ; reloc size
        defl    0                               ; memory size requested
        defl    PF_R                            ; read-only
        defl    0                               ; no alignement

; PHT2 : text (code), always last

        defl    PT_LOAD                         ; type
        defl    PRG_BEGIN - ELFHDR_START        ; p_offset
        defl    0                               ; virtual address (relocatable)
        defl    0                               ; physical address
        defl    PRG_END - PRG_BEGIN             ; code size
        defl    PRG_END - PRG_BEGIN + SIZEOF_Workspace  ; memory size requested, up to 56K
        defl    PF_X | PF_R                     ; executable
        defl    $00010000                       ; 64K alignement

ENDIF
