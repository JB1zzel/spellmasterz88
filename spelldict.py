#!/usr/bin/env python3
"""
spelldict.py - read the Spell-Master (Cambridge Z88) dictionary from the ROM bank files.

Usage:  python3 spelldict.py DIR [--stems | --forms | --stats] [--section XY]

DIR must contain the original bank files SPELL.56 to SPELL.62 (the dictionary is in 56-61,
the index and the tables it needs are in SPELL.62). Output goes to standard output.

  (default)  one headword per line (the stored word; stems such as SIZZL are shown as stored)
  --stems    headword, inflection class and the -S flag
  --forms    every word the checker accepts: stored words that stand alone, plus each
             inflected form
  --stats    counts only
  --section  only the section for a two-letter prefix, e.g. --section AA

The format is described in NOTES.md (section 13) of the annotated source.
"""
import sys, os, collections

def load(d):
    rd=lambda n: open(os.path.join(d,'SPELL.%d'%n),'rb').read()
    return rd(62),[rd(56+k) for k in range(6)]

def le(b,a): return b[a-0xC000]|(b[a-0xC000+1]<<8)

class Dictionary:
    TOKEN_TABLE=0xC4A4      # 128 words -> token strings in SPELL.62
    INDEX=0xE84E            # 26 words -> lists of section entries in SPELL.62
    CLASS_TABLE=0xDDAF      # 7 words -> inflection endings in SPELL.62
    def __init__(self,d):
        self.rom,self.banks=load(d)
        r=self.rom
        self.tokens={}
        for i in range(128):
            a=le(r,self.TOKEN_TABLE+2*i); s=[]; first=True
            while True:
                b=r[a-0xC000]
                if not first and b>=0x80: break
                s.append(chr(b&0x7F)); first=False; a+=1
            self.tokens[i]=''.join(s)
        self.classes={}
        for c in range(7):
            a=le(r,self.CLASS_TABLE+2*c); ends=[]; cur=''
            while True:
                b=r[a-0xC000]; a+=1
                if b==0x80:
                    if cur: ends.append(cur)
                    break
                if b>=0x80:
                    if cur: ends.append(cur)
                    cur=chr(b&0x7F)
                else: cur+=chr(b)
            self.classes[0x10+c]=ends
        self.sections=[]
        for L in range(26):
            p=le(r,self.INDEX+2*L)
            while r[p-0xC000]!=0xFF:
                b0=r[p-0xC000]
                self.sections.append((chr(65+L),b0&0x1F,b0>>5,le(r,p+1))); p+=3
    def section(self,sec):
        letter,key,bank,off=sec
        data=self.banks[bank]; pos=off-0x8000
        prefix=letter+("'" if key==0 else chr(64+key))
        prev=''
        while True:
            b0=data[pos]
            if b0==0x0F: return
            pref=b0&0x0F; takes_s=bool(b0&0x20)
            i=pos+1; body=[]
            while (data[i]&0xDF)>=0x10: body.append(data[i]); i+=1
            txt=prev[:pref]; cls=None
            for b in body:
                if b>=0x80: txt+=self.tokens[b&0x7F]
                elif b==0x40: txt+="'"
                elif b<0x20: cls=b; break
                else: txt+=chr(b)
            yield prefix+txt,cls,takes_s
            prev=txt; pos=i
    def records(self,only=None):
        for sec in self.sections:
            if only and (sec[0]+("'" if sec[1]==0 else chr(64+sec[1])))!=only: continue
            yield from self.section(sec)
    def forms(self,word,cls,takes_s):
        out=[]
        if cls is None:
            out.append(word)
            if takes_s: out.append(word+'S')
        else:
            if cls<0x13: out.append(word)          # a bare stem is only a word for classes below $13
            out += [word+e for e in self.classes[cls]]
        return out

def main(argv):
    if len(argv)<2: print(__doc__); return 1
    dic=Dictionary(argv[1]); mode='words'; only=None
    a=argv[2:]
    for i,x in enumerate(a):
        if x in('--stems','--forms','--stats'): mode=x[2:]
        if x=='--section': only=a[i+1].upper()
    if mode=='stats':
        n=0; cls=collections.Counter(); forms=set()
        for w,c,s in dic.records(only):
            n+=1; cls[(c,s if c is None else None)]+=1; forms.update(dic.forms(w,c,s))
        print("sections:",len(dic.sections)); print("stored words:",n); print("distinct accepted forms:",len(forms))
        for k,v in sorted(cls.items(),key=lambda kv:(kv[0][0] or 0,kv[0][1] or False)):
            c,s=k; print("  class", "none" if c is None else f"${c:02X}", ("(takes -S)" if s else "") if c is None else "", v)
        for c,e in dic.classes.items(): print(f"  class ${c:02X} endings:",' '.join(e))
        return 0
    for w,c,s in dic.records(only):
        if mode=='words': print(w)
        elif mode=='stems': print(f"{w}\t{'' if c is None else format(c,'02X')}\t{'S' if s else ''}")
        else:
            for f in dic.forms(w,c,s): print(f)
    return 0
if __name__=='__main__':
    try: sys.exit(main(sys.argv))
    except BrokenPipeError: pass
