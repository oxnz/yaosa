	.file "bootsect.S"
#include <boot/boot.h>
.set KEY_F1,	0x3B
.set KEY_ENTER,	0x1C
.set PTBL_OFFSET,	0x1BE
.text
.code16
.globl start
start:
/*
*	here setup the environment
*	initialize the registers to know value
*/
xorw %ax,	%ax
movw %ax,	%ds
movw %ax,	%es
movw %ax,	%ss
movw $0x7C00,%sp
movw %sp,	%si
movw $0x0600,%di
xorw %cx,	%cx // This code could save one byte
movb $0x01,	%ch
cld
rep movsw
jmp main-0x7C00+0x0600
main:
/*
*	save the boot disk
*/
pushw %dx
movw %di,	%bp
movw $PTBL,	%bx
movw $F_KEY,	%si
read_ptbl:
/*	check if the current partition is bootable, if yes
*	check the konw OS File system list to print a appropriate
*	menu entry, if no, just simple jump to the next loop
*/
cmpb $0x80,	(%bx)
jne read_next
incb 1(%si)
movw $OS_NAMES,	%di
movb $(OS_NAMES_END-OS_NAMES+1),%cl
movb 4(%bx),	%al
repne scasb
pushw %si
call print_xos
popw %si
read_next:
/*	add 16 to partition pointer to point the
*	next partition entry, cause we initial %bx
*	point to 0x01BE, so %bl hold the value 0xBE,
*	if end four loops, here the %bl + 4*0x10 will
*	cause a carry bit
*/
addb $0x10,	%bl
jnc read_ptbl
print_prompt:
/*
*	print the prompt string: BOOT:
*/
movw $PROMPT,%si
call puts
/*
*	print the default boot parition which
*	was configured through bootcfg and stored
*	in the offset 0x01B8 in this file
*	if there's no one default parition
* set, use the first bootable one instead
*/
movb DEFAULT_BOOT, %al
addb $0x31, %al
call putch
jmp opt_input
beep:
movb $0x07, %al
call putch
opt_input:
/*
* get system time to set up the timer
*/
xorb %ah, %ah
int $0x1A
addw TIME_OUT, %dx
movw %dx, %di
read_key:
movb $0x01, %ah
int $0x16
jnz got_key
/*
* test if timer fired
*/
xorb %ah, %ah
int $0x1A
cmpw %di, %dx
jb read_key
use_default:
/*
* time out or KEY_ENTER was detected
*/
movb DEFAULT_BOOT, %al
jmp check_input
got_key:
/*
* opt the scan keystroke
*/
xorb %ah, %ah
int $0x16
movb %ah, %al
cmpb $KEY_ENTER, %al
je use_default
subb $KEY_F1, %al
check_input:
/*
* validate the user input
* if invalid, jump to beep to
* warn the user, then all the things
* was the same as before
*/
testb %al, %al
js beep
cmpb $0x03, %al
ja beep
shlb $0x04, %al
xorb %ah, %ah
addw $PTBL, %ax
xchgw %ax, %bx
pushw %bx
popw %si
read_obr:
/*
* read the specified Operating System
* Boot Record sector to 0x7C00
*/
movw $0x7C00,%bx
movb $0x02, %ah
chs_mode:
/*
* init the chs call
*/
popw %dx
movb 0x01(%si), %dh
movw 0x02(%si), %cx
movb $0x01, %al
// pushw %si
// movw %sp, %di
test_floppy:
/*
* test if the boot medium is a floppy,
* if yes, jump to read to fire the chs_mode
* read
*/
testb %dl, %dl
jz read
lba_mode:
andw $0x00FF,%dx
pushw %dx
pushl $0x0
pushl 0x8(%si)
pushw %es
pushw %bx
push $0x01
push $0x10
movw %sp, %si
decw %ax
orb $0x40, %ah
read:
int $0x13
// movw %di, %sp
// popw %si
/*
* ah, finally we got here
* for now, every thing was OK, and
* we could do a jump to 0x7C00, where
* the OBR was read in, give control to
* it
*/
jmp *%bx
print_xos:
call puts
movw %di, %si
call puts
movw $CRLF, %si
jmp puts
1:
callw putch
puts:
lodsb
testb $0x80, %al
jz 1b
andb $~0x80, %al
putch:
pushw %bx
movw $0x0C, %bx
movb $0x0E, %ah
int $0x10
popw %bx
retw
F_KEY:
.byte 'F'
.byte 0x30
.byte ':'|0x80
PROMPT:
.ascii "Boot"
.byte ':'|0x80
CRLF:
CR:
.byte '\r'
.byte '\n'|0x80
OS_NAMES:
.byte 0xAA
.ascii "Yaos"
.byte 'a'|0x80
.byte 0x07
.ascii "Window"
.byte 's'|0x80
.byte 0x83
.ascii "Linu"
.byte 'x'|0x80
OS_NAMES_END:
.=0x01B8
DEFAULT_BOOT:
.byte 0x00
.ascii "Mis"
.byte 'c'|0x80
.=0x01BD
TIME_OUT:
.byte 0xFF
.=0x01BE
PTBL:
.byte 0x80
.=0x01FE
BootFlag:
.word MAGIC 
