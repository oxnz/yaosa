#include <boot/boot.h>
#include <boot/loader.h>
/*
* Yaosa Operating System Loader
* --------------------------------------------------------------------------
* Version: 0.01
* Revision:
* Last Modified: 2011.3.26
* E-mail: yunxinyi@gmail.com
* To make further coding and bugfix easy, this piece of file
* is heavily commented.
* Loader was readed in to mem addr at: 0x1000 by YOSBOOT which
* was written at the very first sector of the disk, and then jmp
* to 0x1000, i.e.: start was the entry of this loader.
* then, this loader set up the registers needed by later code
* and searching for the kernel. If kernel was found, then read it
* into memory at 0x8000 as default, before this, if any error occurs,
* the machine would hang up and printing "press any key to reboot".
* if all the things goes right, then we dectect the CPU family and
* addressable memory. further may also read some graphic card informations.
* at last, load the Global Descriptor Tables and jmp into the kernel at
* 0x8000, after that, things was out of this file could control.
****************************************************************************/
//#define debug
#ifdef FAT32
#define FILE_NAME_LEN 0x0B
#define END_OF_CLUS 0x0FFFFFFF
#define OFF_BootDirClus 0x00
#define OFF_BytsPerSec 0x0B
#define OFF_SecPerClus 0x0D
#define OFF_FATStartSec 0x1C
#define OFF_RootClus 0x2C
#define OFF_BytsPerClus 0x34
#define OFF_LoadAddr 0x36
#define OFF_DataStartSec 0x38
#define OFF_CurClus 0x3C
#define OFF_CurSec 0x43
#endif
.text
.code16
.globl start
start:
/*
*	cause we define some variable here, so just jmp to skip
*	those data definitions.
*/
jmp main
#ifdef FAT32
/*
*	FAT file system use a 8.3 name space to store file names
*	so our kernel 'KERNEL00.YOS' became 'KERNEL00YOS'
*/
KERN_NAME: .ascii "KERNEL00YOS"
#endif
/*
*	some constant strings used for echo the user what happens
*	NOTE: all the strings ended with the eighth byte set, which
*	indicate a string was end and also save one byte if we use
*	other end sign
*/
LOAD_MSG: .ascii "Loadin"
.byte 'g'|0x80
MIS_KERN: .ascii "Missing Kerne"
.byte 'l'|0x80
READ_ERR: .ascii "Read Erro"
.byte 'r'|0x80
REBOOT_MSG: .ascii "\r\nPress any key to reboo"
.byte 't'|0x80
OK: .ascii "[OK]\r"
.byte '\n'|0x80
MEM_MSG: .ascii "\nMemory"
CRLF: .byte 0x0A
.byte 0x0D|0x80
CPUID: .ascii "CPU:\txxxxxxxxxxxx"
.byte '\r'|0x80
GDT:
/*
*	Globl descriptors
*	NOTE: the first one is all zero is a dummy descriptor which
*	is needed by INTEL cpus
*/
DUMMY_DESC: .quad 0x0000000000000000
CODE32_DESC: .quad 0x00CF98000000FFFF
DATA32_DESC: .quad 0x00CF92000000FFFF
GDT_PTR: .word .-GDT-1
.long GDT
.set CODE32_SEL,	CODE32_DESC-GDT
.set DATA32_SEL,	DATA32_DESC-GDT
main:
xorl %eax,	%eax
movw %ax,	%ds
movw %ax,	%es
movw %ax,	%ss
movw $STACK,	%sp
/*
*	we set %bp = BOOT to use the variable defined in
*	YOSBoot.
*/
movw $BOOT,	%bp
loader_echo:
movw $LOAD_MSG,	%si
call puts
search_kern:
movw $KERNSEG,	%ax
/*
*	NOTE: here we use LoadAddr defined in
*	YOSBOOT to store kernel segement other
*	than loader address in YOSBOOT
*	in order to make the loop read simple,
*	we first sub kernel segement by bytes
*	per clus >> 4
*/
shrw $0x04,	OFF_BytsPerClus(%bp)
subw OFF_BytsPerClus(%bp),	%ax
movw %ax,	OFF_LoadAddr(%bp)
movl OFF_BootDirClus(%bp),	%eax
movl %eax,	OFF_CurClus(%bp)
call clus2sect
movw $KERN_NAME,	%si
call search
rkernel:
/*
*	read the loader to addr: loader
*	and put a point to screen after
*	each cluster was successfully read
*	in
*/
call kread
movb $'.',	%al
call putch
call get_next_clus
cmpl $END_OF_CLUS,	%eax
jne rkernel
read_ok:
movw $OK,	%si
call puts
cpu_id:
xorl %eax,	%eax
cpuid
movw $CPUID,	%si
movl %ebx,	5(%si)
movl %edx,	9(%si)
movl %ecx,	13(%si)
call puts
smap:
/*
*	Get System Memory Map
*	Format of BIOS system memory map address range descriptor:
*	0-------------------------------------0
*	|Offset| Size |	Description |
*	|-------------------------------------|
*	| 0x00 | quad |	base address |
*	|-------------------------------------|
*	| 0x08 | quad | length in bytes |
*	|-------------------------------------|
*	| 0x10 | long | type of address range |
*	0-------------------------------------0
*	values for System Memory Map address type:
*	0x01 memory avaliable to OS
*	0x02 reserved, not avaliable(e.g. system ROM, memory-mapped device
*	0x03 ACPI Reclaim Memory (usable by OS after reading ACPI tables)
*	0x04 ACPI NVS Memory (OS is required to save this memory between NVS
*	sessions)
*	other not defined yet -- treat as Reserved
*/
xorl %ebx,	%ebx
movw $0x0600,%di
movw $MEM_MSG,	%si
call puts
/*
*	the following 3 lines are parts of
*	function cal_mem
*/
pushl $0x0
pushl $0x0
movw %sp,	%si
next_mem_item:
movl $0x0000E820,	%eax
movl $0x534D4150,	%edx
xorl %ecx,	%ecx
movb $0x14,	%cl
int $0x15
jc mem_end
addw %cx,	%di
cal_mem:
/*
*	compute all the addressable memory and store it
*	for paging use
*/
cmpl $0x00000001,	-0x04(%di)
jne mem_skip
movl -0x14(%di),	%eax
addl -0x0C(%di),	%eax
movl -0x10(%di),	%edx
adcl -0x08(%di),	%edx
cmpl %edx,	4(%si)
jb 1f
ja mem_skip
cmpl %eax,	(%si)
ja mem_skip
1:
addl %eax,	(%si)
addl %edx,	4(%si)
mem_skip:
disp_mem:
/*
*	display the memory info to screen
*	in format: type + length + base addr
*/
pushaw
2:
decw %di
movb (%di),	%al
call putx
decw %cx
jnz 2b
movw $CRLF,	%si
call puts
popaw
// end of disp_mem
movl %eax,	%edx
testl %ebx,	%ebx
jnz next_mem_item
subw %cx,	%di
pushw %di
// end of smap
mem_end:
svga:
/*
*	check the superVGA card
*	ax = 0x4F00 Get SuperVGA information
*	format of SuperVGA information:
*	0-------------------------------------------------------------------0
*	|Offset|Size|	Description |
*	|-------------------------------------------------------------------|
*	| 0x00 |0x04|	signature ("VESA")	|
*	|-------------------------------------------------------------------|
*	| 0x04 |0x02| VESA version number (one-digit minor version) 1.2=0102|
*	|-------------------------------------------------------------------|
*	| 0x06 |0x04|	pointer to OEM name '761295520' for ATI |
*	|-------------------------------------------------------------------|
*	| 0x0A |0x04|	capabilities flags |
*	|-------------------------------------------------------------------|
*	| 0x0E |0x04| pointer to list of supported VESA and OEM video modes |
*	|-------------------------------------------------------------------|
*	| 0x12 |0x02|	total amount of video memory in 64K blocks |
*	|-------------------------------------------------------------------|
*	| 0x14 |0xEC|(VBE v1.x)	Reserved |
*	| 0x14 |0x02|(VBE v2.x)	OEM software version (BCD)	|
*	|-------------------------------------------------------------------|
*	| 0x16 |0x04|	pointer to vender name |
*	|-------------------------------------------------------------------|
*	| 0x1A |0x04|	pointer to product name |
*	|-------------------------------------------------------------------|
*	| 0x1E |0x04|	pointer to product revision string |
*	|-------------------------------------------------------------------|
*	| 0x22 |0x02|	(if capabilities bit 3 set) VBE/AF version (BCD) |
*	|-------------------------------------------------------------------|
*	| 0x24 |0x04|	(if capabilities bit 3 set) pointer to list of |
*	|	supported accelerated video modes (list of words |
*	|	terminated with 0xFFFF)	|
*	|-------------------------------------------------------------------|
*	| 0x28 |0xD8|	reserved for VBE implementation |
*	|-------------------------------------------------------------------|
*	|0x100|0x100|	OEM scratchpad (for OEM strings, etc.)	|
*	0-------------------------------------------------------------------0 */
movw $0x4F00,%ax
int $0x10
cmpb $0x4F,	%al
je 1f
/*
*	we do this jmp if SVGA is not supported
*/
jmp svga_err
1:
addw $0x0100,%di
pushw %di
pre_pm:
/*
*	do some prepare jobs for entering the
*	protect mode
*/
load_gdt:
lgdt GDT_PTR
close_int:
cli
a20:
inb $0x92,	%al
orb $0x02,	%al
outb %al,	$0x92
enable_pm:
movl %cr0,	%eax
orl $0x0001,%eax
movl %eax,	%cr0
go_pm:
jmpl $CODE32_SEL,$pm
get_next_clus:
/*
*	use the current cluster number to get
*	the next cluster number and save it
*	in CurClus, additionally, this would
*	also compute the first sector number
*	of the next cluster and store it in
*	CurSec as well as in %eax. if we reach
*	the last cluster, just simply skip compute
*	the sector number of the non-exist cluster
*	(CurClus*4) mod BytsPerSec = eax...edx
*	afterwards, eax hold the sector offset by
*	FATStartSect, edx holds the offset by start
*	of the sector. so we finally got the right
*	value from sector eax + FATStartSec among
*	sector and edx + Buffer in sector.
*/
movl OFF_CurClus(%bp),	%eax
#ifdef debug
pushal
shrl $0x10,	%eax
movb %ah,	%al
call putx
popal
#endif
shll $0x02,	%eax
movzwl OFF_BytsPerSec(%bp),	%ecx
xorl %edx,	%edx
divl %ecx
addl OFF_FATStartSec(%bp),	%eax
movw $BUFFER,%bx
xorw %cx,	%cx
incb %cl
call read
addw %dx,	%bx
movl (%bx),	%eax
movl %eax,	OFF_CurClus(%bp)
#ifdef debug
pushaw
movb %ah,	%al
call putx
popaw
#endif
cmpl $END_OF_CLUS,	%eax
je 1f
clus2sect:
subl $0x02,	%eax
xorl %ecx,	%ecx
movb OFF_SecPerClus(%bp),	%cl
mull %ecx
addl OFF_DataStartSec(%bp),%eax
movl %eax,	OFF_CurSec(%bp)
1:
retw
missing_kernel:
/*
*	if boor directory or loader can't be
* located in the disk, we come here to
* let the user know what'g going wrong
*/
movw $MIS_KERN,	%si
jmp 1f
read_err:
/*
*	show 'read error'
*/
movw $READ_ERR,	%si
svga_err:
1:
/*
*	we push the address of function halt
*	to the stack, so when we execute all
*	the way down to retw in putch, we would
*	return to the address of halt and hang
*	up
*/
pushw $halt
jmp puts
1:
call putch
puts:
lodsb
testb $0x80,	%al
jz 1b
andb $~0x80,	%al
putch:
pushaw
movb $0x0E,	%ah
movw $0x0007,%bx
int $0x10
popaw
retw
halt:
/*
*	here we got loose limit about
*	space, so we would print some
*	prompt like 'press any key to
* reboot' and wait for a keystroke
*	to reboot the machine.
*/
movw $REBOOT_MSG,	%si
call puts
xorb %ah,	%ah
int $0x16
int $0x19
search:
/*
*	search the entry name specified in %si
*	cause we are in real mode and as the os
*	bootstrap, so if we could not find any
*	loader, we could do nothing but hang up
*	to wait user to come up with a solution
*	if the specified entry name was found, jmp
*	to clus2sect, otherwise jmp to missing_kernel
*/
movb OFF_SecPerClus(%bp),	%dl
next_sect:
movw $BUFFER,%bx // off
movw $0x01,	%cx // count
call read
movb $0x10,	%ch // dir per sect
next_entry:
cmpb $0x00,	(%bx)	// END OF ENTRY?
jz missing_kernel
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
je missing_kernel
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
#ifdef debug
pushal
movb %ah,	%al
call putx
popal
#endif
jmp clus2sect
/*
*	NOTE: we needn't a ret code here cause there's no
*	pass we could got here, so just comment it to
*	save space
retw
*/
putx:
/*
*	print %al as hex
*/
pushaw
movb %al,	%dl
movb $0x02,	%cl
shrb $0x04,	%al
1:
andb $0x0F,	%al
addb $0x30,	%al
cmpb $0x3A,	%al
jb 2f
addb $0x07,	%al
2:
movb $0x0C,	%bl
movb $0x0E,	%ah
int $0x10
movb %dl,	%al
decb %cl
jnz 1b
popaw
retw
kread:
/*
*	kernel read function
*	in order to save time and the disk
*	read times, we read SecPerClus's
*	sectors once a time. and every time
*	we increase %bx by BytsPerClus>>4 so
*	the kernel would be in appropriate order
*	NOTE: the LoadAddr which stores the
*	kernel segement should be updated every
*	time for the next loop, otherwise we would
*	overwrite the last read content
*/
movw OFF_LoadAddr(%bp),	%bx
addw OFF_BytsPerClus(%bp),	%bx
movw %bx,	OFF_LoadAddr(%bp)
movw %bx,	%es
xorw %bx,	%bx
movzbw OFF_SecPerClus(%bp),	%cx
read:
/*
*	do the extended read sectors from drive
*	Registers:
*	%eax hold the absolute number of the
*	start of the sectors to be read
*	(1st sector of drive has number 0)
*	%es:%bx hold the segment:offset pointer
*	to the memory buffer to which sectors
*	would be transferred
*	NOTE: x86 is little-endian, if declaring
*	the segment and offset seperately, the
*	offset must be declared before the segment
*	Changed Reg(s):
*	%ah = 0x42 function specify
*	%dl = 0x80 hard disk specify
*	%ds:%si segment:offset pointer to the DAP
*	Return Value(s):
*	CF: set on error, clear if no error
*	%ah: return code
*	if an error occured, we jmp to err and hang up
*
DAP:
*	Disk Address Packet ***********************************************
*	Offset |size|	description
*	-----------------------------------------------------------------------
*	0	1	size of DAP 0x10 = 16
*	-----------------------------------------------------------------------
*	1	1	unused, shoud be zero
*	-----------------------------------------------------------------------
*	2	2	number of sectors to be read
*	-----------------------------------------------------------------------
*	4	4	segment:offset point to the memory buffer
*	-----------------------------------------------------------------------
*	8	8	absolute number of the start sectors to be read
*	----------------------------------------------------------------------*/
pushaw
/*	store stack pointer for later use to
*	skip pop all things what we pushed in
*/
movw %sp,	%di
pushl $0x00
pushl %eax
#ifdef debug
shrl $0x10,	%eax
movb %ah,	%al
call putx
#endif
pushw %es // base
pushw %bx // off
pushw %cx // read count
pushw $0x0010 // size
movb $0x42,	%ah
movb $0x80,	%dl
movw %sp,	%si
int $0x13
jc read_err
movw %di,	%sp
/*
*	CAUTIOUS: we must clear %es before return,
*	otherwise we would got some error like LBA
*	out of range or somewhat disk error.
*/
xorw %ax,	%ax
movw %ax,	%es
popaw
retw
.code32
pm:
movw $DATA32_SEL,	%ax
movw %ax,	%ds
movw %ax,	%es
movw %ax,	%fs
movw %ax,	%gs
/*
*	enable_paging:
*	after double thinking, the page function should be
*	set up by kernel rather than loader
*/
jmpl $CODE32_SEL,	$KENTRY
/*
*	the loader should be less than 24 KB,
*	so we define the end limit here in case
*	larger or other error
*/
.=0x6000 
