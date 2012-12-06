	.file "obr.S"
#include <boot/start.ash>
.text
.code16
.globl start
#ifndef BUFFER
#define BUFFER 0x0800
#endif
#ifndef BOOT
#define BOOT 0x0600
#endif
#ifndef STACK
#define STACK 0x8000
#endif
#ifndef LOADER
#define LOADER 0x1000
#endif
#ifndef MAGIC
#define MAGIC 0xAA55
#endif
/*	Operating System Boot Record [FAT32]	OS's bootstrap ****************
* PROGRAM STRUCTURE:
* -----------------------------------------------------------------
* | START | SIZE | DESCRIPTION |
* |---------------------------------------------------------------|
* | start | 3 | short jmp to code |
* |---------------------------------------------------------------|
* | BPB_BLOCK| 90 | BIOS PARAMETERS BLOCK |
* |---------------------------------------------------------------|
* | code | 446 | boot strap code to invoke the OS loader |
* |---------------------------------------------------------------|
* | BOOT_SIGN| 2 | BOOT SIGN |
* ----------------------------------------------------------------- */
start:
BS_jmpBoot:
jmp code
nop
BPB:.=0x03
/* BPB BIOS PARAMETER BLOCK *********************************
* -----------------------------------------------------------------
* | NAME | VALUE | OFFSET | SIZE |
* -----------------------------------------------------------------*/
#define FILE_NAME_LEN 0x0B
#define END_OF_CLUS 0x0FFFFFFF
BPB_OEMName: .ascii "YOSFAT32" // 0x03 8
#define OFF_BytsPerSec 0x0B
BPB_BytsPerSec: .word 0x0200 // 0x0B 2
#define OFF_SecPerClus 0x0D
BPB_SecPerClus: .byte 0x08 // 0x0D 1
#define OFF_RsvdSecCnt 0x0E
BPB_RsvdSecCnt: .word 0x0020 // 0x0E 2
#define OFF_FATNum 0x10
BPB_NumFATs: .byte 0x02 // 0x10 1
BPB_RootEntCnt: .word 0x0000 // 0x11 2
BPB_TotSec16: .word 0x0000 // 0x13 2
BPB_Media: .byte 0xF8 // 0x15 1
BPB_FATSz16: .word 0x0000 // 0x16 2
BPB_SecPerTrk: .word 0x0020 // 0x18 2
BPB_NumHeads: .word 0x0040 // 0x1A 2
#define OFF_FATStartSec 0x1C
BPB_HiddSec: .long 0x00000000 // 0x1C 4
BPB_TotSec32: .long 0x001FFE00 // 0x20 4
#define OFF_FATSz32 0x24
BPB_FATSz32: .long 0x00000800 // 0x24 4
BPB_ExtFlags: .word 0x0000 // 0x28 2
BPB_FSVer: .word 0x0000 // 0x2A 2
#define OFF_RootClus 0x2C
BPB_RootClus: .long 0x00000002 // 0x2C 4
BPB_FSInfo: .word 0x0001 // 0x30 2
BPB_BkpBootSec: .word 0x0006 // 0x32 2
BPB_Reserved: // 0x34 12
#define OFF_BytsPerClus 0x34
.word 0x0000 // 0x34 4
#define OFF_LoadAddr 0x36
.word 0x0000
#define OFF_DataStartSec 0x38
DATA_START_SECT:.long 0x00000000 // 0x38 4
#define OFF_CurClus 0x3C
CUR_CLUS: .long 0x00000000 // 0x3C 4
BS:
BS_DrvNum: .byte 0x00 // 0x40 1
BS_Reserved1: .byte 0x00 // 0x41 1
BS_BootSig: .byte 0x29 // 0x42 1
#define OFF_CurSec 0x43
BS_VolID: .long 0xC13D7B16 // 0x43 4
BS_VolLab: .ascii "Y-OS BS 0.1" // 0x47 11
BS_FilSysType: .ascii "FAT32 " // 0x52 8
BPB_END:.=0x5A
code:
cli
cld
xorl %eax, %eax
movw %ax, %ds
movw %ax, %es
movw %ax, %ss
movw $STACK, %sp
pushw %dx
sti
move_self:
movw $0x7C00,%si
movw $BOOT, %di
movw %di, %bp
movw $0x0100,%cx
rep
movsw
jmp main-start+BOOT
main:
/*
* compute the FAT Start Sector
* BPB_RsvdCnt + BPB_HiddSec
* store the value in FATStartSec
*/
movzwl OFF_RsvdSecCnt(%bp), %eax
addl %eax, OFF_FATStartSec(%bp)
/*
* compute the Data Start Sector
* BPB_FATSz32*BPB_NumFATs+FATStartSector
* store the value in DataStartSec
*/
movl OFF_FATSz32(%bp), %eax
mull OFF_FATNum(%bp)
addl OFF_FATStartSec(%bp), %eax
movl %eax, OFF_DataStartSec(%bp)
/*
* compute Bytes Per Cluster
* BPB_BytsPerSec*BPB_SecPerClus
* store the value in BytsPerClus
* BTW, sub Loader Addr by BytsPerClus, so
* when we come to read the loader, we could
* direct add BytsPerClus to Loader ignore
* the first loop exception.
*/
movw OFF_BytsPerSec(%bp), %ax
movzbw OFF_SecPerClus(%bp), %bx
mulw %bx
movw $LOADER, %bx
subw %ax, %bx
movw %bx, OFF_LoadAddr(%bp)
movw %ax, OFF_BytsPerClus(%bp)
/*
* prepare for the clus2sect call
*/
movl OFF_RootClus(%bp), %eax
call clus2sect
movw $BOOT_DIR_NAME, %si
call search
movw $LOADER_NAME, %si
call search
rloader:
/*
* read the loader to addr: loader
*/
movw OFF_LoadAddr(%bp), %bx
call lread
call get_next_clus
cmpl $END_OF_CLUS, %eax
jne rloader
go:
movw $0x1000,%bx
jmpw *%bx
get_next_clus:
/*
* use the current cluster number to get
* the next cluster number and save it
* in CurClus, additionally, this would
* also compute the first sector number
* of the next cluster and store it in
* CurSec as well as in %eax. if we reach
* the last cluster, just simply skip compute
* the sector number of the non-exist cluster
* (CurClus*4) mod BytsPerSec = eax...edx
* afterwards, eax hold the sector offset by
* FATStartSect, edx holds the offset by start
* of the sector. so we finally got the right
* value from sector eax + FATStartSec among
* sector and edx + Buffer in sector.
*/
movl OFF_CurClus(%bp), %eax
#ifdef debug
pushal
shrl $0x10, %eax
movb %ah, %al
call putx
popal
#endif
shll $0x02, %eax
movzwl OFF_BytsPerSec(%bp), %ecx
xorl %edx, %edx
divl %ecx
addl OFF_FATStartSec(%bp), %eax
movw $BUFFER,%bx
xorw %cx, %cx
incb %cl
call read
addw %dx, %bx
movl (%bx), %eax
movl %eax, OFF_CurClus(%bp)
#ifdef debug
call putx
#endif
cmpl $END_OF_CLUS, %eax
je 1f
clus2sect:
subl $0x02, %eax
xorl %ecx, %ecx
movb OFF_SecPerClus(%bp), %cl
mull %ecx
addl OFF_DataStartSec(%bp),%eax
movl %eax, OFF_CurSec(%bp)
1:
retw
missing_loader:
/*
* if boor directory or loader can't be
*	located in the disk, we come here to
*	warn the user of the error(s) by print
*	an 'M' to screen and halt
*/
movb $0x4D,	%al
jmp 1f
err:
/*
*	no matter when a disk read error or some
*	other cirtical problem(s) occured, we come
*	here, print charcter 'D' and halt
*/
movb $44,	%al
1:
/*
*	we push the address of function halt
*	to the stack, so when we execute all
*	the way down to retw in putch, we would
*	return to the address of halt and hang
*	up
*/
pushw $halt
putch:
pushaw
movb $0x0E,	%ah
int $0x10
popaw
retw
halt:
/*
*	hang up, got no response
*/
jmp .
search:
/*
*	search the entry name specified in %si
*	cause we are in real mode and as the os
*	bootstrap, so if we could not find any
*	loader, we could do nothing but hang up
*	to wait user to come up with a solution
*	if the specified entry name was found, jmp
*	to clus2sect, otherwise jmp to missing_loader
*/
movb OFF_SecPerClus(%bp),	%dl
next_sect:
movw $BUFFER,%bx // off
movw $0x01,	%cx // count
call read
movb $0x10,	%ch // dir per sect
next_entry:
cmpb $0x00,	(%bx)	// END OF ENTRY?
jz missing_loader
pushaw
movw $FILE_NAME_LEN,	%cx
movw %bx,	%di
repe cmpsb
jcxz found
popaw
addw $0x20,	%bx // entry size
decb %ch // dir items count -1
jnz next_entry
decb %dl
jz next_clus
incl %eax
jmp next_sect
next_clus:
/*
*	if not found in current cluster
*	we would looking for the next cluster
*	and if we reach the end of the cluster,
*	just hang up, if it was found, jmp to
*	next_sect and continue searching
*/
call get_next_clus
cmpl $END_OF_CLUS,	%eax
je missing_loader
jmp next_sect
found:
/*
*	got it!
*	here we jmp to clus2sect and
*	return from clus2sect with the
*	appropriate sector number
*/
popaw
movw 0x14(%bx),	%ax
shll $0x10,	%eax
movw 0x1A(%bx),	%ax
movl %eax,	OFF_CurClus(%bp)
jmp clus2sect
/*
*	NOTE: we needn't a ret code here cause there's no
*	pass we could got here, so just comment it to
*	save space
retw
*/
#ifdef debug
/*
*	print %al in hex
*/
putx:
pushaw
movb %al,	%bl
movb $0x02,	%cl
shrb $0x04,	%al
1:
andb $0x0F,	%al
addb $0x30,	%al
cmpb $0x3A,	%al
jb 2f
addb $0x07,	%al
2:
movb $0x0E,	%ah
int $0x10
movb %bl,	%al
decb %cl
jnz 1b
popaw
retw
#endif
lread:
/*
*	loader read function
*	in order to save time and the disk
*	read times, we read SecPerClus's
* sectors once a time. and every time
* we increase %bx by BytsPerClus so
* the loader would be in right order
* NOTE: the LoadAddr should be updated
* for the next loop, otherwise we would
* overwrite the last read content
*/
movw OFF_BytsPerClus(%bp), %dx
addw %dx, %bx
movw %bx, OFF_LoadAddr(%bp)
movzbw OFF_SecPerClus(%bp), %cx
read:
/*
* do the extended read sectors from drive
* Registers:
* %eax hold the absolute number of the
* start of the sectors to be read
* (1st sector of drive has number 0)
* %es:%bx hold the segment:offset pointer
* to the memory buffer to which sectors
* would be transferred
* NOTE: x86 is little-endian, if declaring
* the segment and offset seperately, the
* offset must be declared before the segment
* Changed Reg(s):
* %ah = 0x42 function specify
* %dl = 0x80 hard disk specify
* %ds:%si segment:offset pointer to the DAP
* Return Value(s):
* CF: set on error, clear if no error
* %ah: return code
* if an error occured, we jmp to err and hang up
*
DAP:
* Disk Address Packet ***********************************************
* Offset |size| description
* -----------------------------------------------------------------------
* 0 1 size of DAP 0x10 = 16
* -----------------------------------------------------------------------
* 1 1 unused, shoud be zero
* -----------------------------------------------------------------------
* 2 2 number of sectors to be read
* -----------------------------------------------------------------------
* 4 4 segment:offset point to the memory buffer
* -----------------------------------------------------------------------
* 8 8 absolute number of the start sectors to be read
* ----------------------------------------------------------------------*/
pushaw
movw %sp, %di
pushl $0x0
pushl %eax
#ifdef debug
shrl $0x10, %eax
movb %ah, %al
call putx
#endif
pushw %es // base
pushw %bx // off
pushw %cx // read count
pushw $0x0010 // size
movb $0x42, %ah
movb $0x80, %dl
movw %sp, %si
int $0x13
jc err
movw %di, %sp
popaw
retw
.=0x01E8-2*FILE_NAME_LEN
/*
* here are the Directory name 'BOOT' in which
* lay the loader, followed by 7 spaces to make
* an FILE_NAME_LEN's entry
*/
BOOT_DIR_NAME:
.ascii "BOOT"
.byte 0x20,	0x20,	0x20,	0x20,	0x20,	0x20,	0x20
LOADER_NAME:
.ascii "LOADER16BIN"
.=0x01E8
BootFlag:
.word MAGIC 
