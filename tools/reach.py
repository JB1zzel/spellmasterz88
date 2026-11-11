#!/usr/bin/env python3
"""Reachability check for the Spell-Master code banks.

Follows every path the Z80 can take from the known entry points and reports
  - areas DZasm treats as code that no path reaches (dead code, or data decoded as code),
  - entry points or jump targets that land inside areas DZasm treats as data.

Usage:  python3 tools/reach.py            (run from the repository root)

It reads bank_files/spell62.bin and spell63.bin and the area lists in dzasm/spell6x.clt.
Every entry of the jump tables is followed, including far-call entry 5, which nothing
calls; without it a further 496 bytes of bank 63 are unreachable ($DB25-$DCFD and $C070-$C086).
Indirect jumps are handled through the jump tables listed below; OS_Bye is treated as
not returning. OZ calls are RST $20 followed by one byte, or two when the first byte is
$06, $09 or $0C (OS two-byte, GN and DC calls).
"""
import re, sys, os

ORG = 0xC000

# Entry points and jump tables, per bank. Tables are (address, number of words).
BANKS = {
    62: dict(entries=[0xC000],               # QuickEdit entry (DOR)
             tables=[(0xD171, 47)]),          # command dispatch table
    63: dict(entries=[0xC1D1,                 # WordFinder entry (DOR)
                      0xFF80],                # far-call stub (bank 63 offset $3F80)
             tables=[(0xD008, 11)]),          # far-call table
}

def load_areas(clt):
    """Return [(start, end, type)] from a DZasm collect file."""
    txt = open(clt, encoding='latin-1').read()
    areas = []
    for a, e, t in re.findall(r'\(\$([0-9A-Fa-f]{4}),\s*\$([0-9A-Fa-f]{4})\s+(\w+)\)', txt):
        areas.append((int(a, 16), int(e, 16), t.lower()))
    return areas

def length_and_flow(m, pc):
    """Decode one instruction at pc. Returns (length, [targets], falls_through)."""
    b = m(pc)
    w = lambda o: m(pc + o) | (m(pc + o + 1) << 8)
    rel = lambda o: (pc + o + 1 + ((m(pc + o) ^ 0x80) - 0x80)) & 0xFFFF
    if b == 0xE7:                                   # RST $20 = OZ call
        n = m(pc + 1)
        if n in (0x06, 0x09, 0x0C):
            return 3, [], True
        return 2, [], n != 0x21                     # OS_Bye does not return
    if b in (0xCB,):
        return 2, [], True
    if b in (0xDD, 0xFD):
        b2 = m(pc + 1)
        if b2 == 0xE9:                              # JP (IX)/(IY)
            return 2, [], False
        if b2 == 0xCB:
            return 4, [], True
        if b2 in (0x21, 0x22, 0x2A, 0x36):          # LD IX,nn / LD (nn),IX / LD IX,(nn) / LD (IX+d),n
            return 4, [], True
        if b2 in (0x34, 0x35, 0x46, 0x4E, 0x56, 0x5E, 0x66, 0x6E, 0x7E,
                  0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x77,
                  0x86, 0x8E, 0x96, 0x9E, 0xA6, 0xAE, 0xB6, 0xBE):
            return 3, [], True
        return 2, [], True
    if b == 0xED:
        b2 = m(pc + 1)
        if b2 in (0x43, 0x4B, 0x53, 0x5B, 0x63, 0x6B, 0x73, 0x7B):
            return 4, [], True
        if b2 in (0x45, 0x4D):                      # RETN / RETI
            return 2, [], False
        return 2, [], True
    # unprefixed
    if b in (0xC3,):                                # JP nn
        return 3, [w(1)], False
    if b in (0xC2, 0xCA, 0xD2, 0xDA, 0xE2, 0xEA, 0xF2, 0xFA):
        return 3, [w(1)], True                      # JP cc,nn
    if b == 0xCD:
        return 3, [w(1)], True                      # CALL nn
    if b in (0xC4, 0xCC, 0xD4, 0xDC, 0xE4, 0xEC, 0xF4, 0xFC):
        return 3, [w(1)], True                      # CALL cc,nn
    if b == 0x18:
        return 2, [rel(1)], False                   # JR e
    if b in (0x20, 0x28, 0x30, 0x38, 0x10):
        return 2, [rel(1)], True                    # JR cc,e / DJNZ
    if b == 0xC9:
        return 1, [], False                         # RET
    if b in (0xC0, 0xC8, 0xD0, 0xD8, 0xE0, 0xE8, 0xF0, 0xF8):
        return 1, [], True                          # RET cc
    if b == 0xE9:
        return 1, [], False                         # JP (HL)
    if b in (0xC7, 0xCF, 0xD7, 0xDF, 0xEF, 0xF7, 0xFF):
        return 1, [], True                          # other RSTs: assume they return
    if b in (0x01, 0x11, 0x21, 0x31, 0x22, 0x2A, 0x32, 0x3A):
        return 3, [], True
    if b in (0x06, 0x0E, 0x16, 0x1E, 0x26, 0x2E, 0x36, 0x3E,
             0xC6, 0xCE, 0xD6, 0xDE, 0xE6, 0xEE, 0xF6, 0xFE, 0xD3, 0xDB):
        return 2, [], True
    return 1, [], True

def trace(bank):
    data = open(f'bank_files/spell{bank}.bin', 'rb').read()
    m = lambda a: data[a - ORG] if ORG <= a < ORG + len(data) else 0
    cfg = BANKS[bank]
    starts = list(cfg['entries'])
    for t, n in cfg['tables']:
        starts += [m(t + 2 * i) | (m(t + 2 * i + 1) << 8) for i in range(n)]
    reached = set()          # every byte covered by a reached instruction
    insn = set()             # instruction start addresses
    outside = set()
    todo = [a for a in starts]
    while todo:
        pc = todo.pop()
        while True:
            if not (ORG <= pc < ORG + len(data)):
                outside.add(pc); break
            if pc in insn:
                break
            insn.add(pc)
            n, targets, fall = length_and_flow(m, pc)
            reached.update(range(pc, pc + n))
            for t in targets:
                if ORG <= t < ORG + len(data):
                    todo.append(t)
                else:
                    outside.add(t)
            if not fall:
                break
            pc += n
    return data, reached, insn, outside

def report(bank):
    data, reached, insn, outside = trace(bank)
    areas = load_areas(f'dzasm/spell{bank}.clt')
    print(f'== bank {bank}: {len(insn)} instructions reached, {len(reached)} bytes')
    for a, e, t in sorted(areas):
        span = set(range(a, e + 1))
        hit = span & reached
        if t == 'program' and len(hit) < len(span):
            # list the unreached runs inside this code area
            runs, cur = [], None
            for x in range(a, e + 1):
                if x not in reached:
                    if cur and cur[1] == x - 1:
                        cur[1] = x
                    else:
                        cur = [x, x]; runs.append(cur)
            for r0, r1 in runs:
                print(f'  code not reached: ${r0:04X}-${r1:04X} ({r1 - r0 + 1} bytes) in program area ${a:04X}-${e:04X}')
        if t != 'program' and hit:
            print(f'  {t} area ${a:04X}-${e:04X} is reached as code at {len(hit)} bytes (first ${min(hit):04X})')
    if outside:
        print('  targets outside the bank:', ' '.join(f'${x:04X}' for x in sorted(outside)))
    # every name given with 'dl' to an address in a code area should be a reached instruction
    cmd = open(f'dzasm/annotate_bank{bank}.cmd', encoding='latin-1').read()
    for a, name in re.findall(r'^dl ([0-9A-F]{4}) (\S+)$', cmd, re.M):
        a = int(a, 16)
        kind = [t for x, e, t in areas if x <= a <= e]
        if kind and kind[0] == 'program' and a not in insn:
            print(f'  name {name} (${a:04X}) is in a code area but no path reaches it')

if __name__ == '__main__':
    os.chdir(os.path.dirname(os.path.abspath(__file__)) + '/..')
    for b in (62, 63):
        report(b)
