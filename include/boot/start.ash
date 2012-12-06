#ifndef __START_ASH__
#define __START_ASH__

#define FAT32

#define	MAGIC	0xAA55
#define ORIGIN	0x0600
#define	BOOT	0x0600
#define	LOADSEG	0x0100
#define	LOADER	0x1000
#define	LOADLEN 0x0010
#define KERNEL	0x8000
#define	KERNSEG 0x0800
#define	KERNLEN 0x0010
#define	STACK	0x8000
#define	BUFFER	0x0800
#define	PGDR	0x100000

#ifndef	BUFFER
	#define	BUFFER	0x0800
#endif

#ifndef NFAT32
	#define	END_OF_CLUS	0x0FFFFFFF
#endif


.set	CODE32_SEL,	0x08
.set	DATA32_SEL,	0x10
.set	STACK_SEL,	0x18
.set	VIDEO_SEL,	0x20
.set	TEST_SEL,	0x28
.set	CODE16_SEL,	0x30
.set	LDT_SEL,	0x38

/*	TYPE	********************************
 *	DATA
 *	P|DPL|S|X|E|R/W|A
 *	1|00 |1|0|0|0  |0	0x90	NULL
 *	1|00 |1|0|0|0  |1	0x91	RA
 *	1|00 |1|0|0|1  |0	0x92	RW
 *	1|00 |1|0|0|1  |1	0x93	RWA
 *	1|00 |1|0|1|0  |0	0x94	ER
 *	1|00 |1|0|1|0  |1	0x95	ERA
 *	1|00 |1|0|1|1  |0	0x96	ERW
 *	1|00 |1|0|1|1  |1	0x97	ERWA
 *	CODE
 *	1|00 |1|1|0|0  |0	0x98	X
 *	1|00 |1|1|0|0  |1	0x99	XA
 *	1|00 |1|1|0|1  |0	0x9A	XR
 *	1|00 |1|1|0|1  |1	0x9B	XRA
 *	1|00 |1|1|1|0  |0	0x9C	XE
 *	1|00 |1|1|1|0  |1	0x9D	XEA
 *	1|00 |1|1|1|1  |0	0x9E	XER
 *	1|00 |1|1|1|1  |1	0x9F	XERA
 *	P|DPL|S|X|E|R/W|A
 ***********************************************/

.equ	MDATA_R,	0x90
.equ	MDATA_RA,	0x91
.equ	MDATA_RW,	0x92
.equ	MDATA_RWA,	0x93
.equ	MDATA_ER,	0x94
.equ	MDATA_ERA,	0x95
.equ	MDATA_ERW,	0x96
.equ	MDATA_ERWA,	0x97

.equ	MCODE_X,	0x98
.equ	MCODE_XA,	0x99
.equ	MCODE_XR,	0x9A
.equ	MCODE_XRA,	0x9B
.equ	MCODE_XE,	0x9C
.equ	MCODE_XEA,	0x9D
.equ	MCODE_XER,	0x9E
.equ	MCODE_XERA,	0x9F

.equ	M32,	0x4000

.equ	MDPL0,	0x00
.equ	MDPL1,	0x20
.equ	MDPL2,	0x40
.equ	MDPL3,	0x60

.macro M_DESC  base, limit, type
	.word	(\limit & 0xFFFF)
	.word	(\base & 0xFFFF)
	.byte	(\base >> 16) & 0xFF
	.byte	(\type & 0xFF)
	.byte	(((\limit >> 16) & 0x0F) | 0xC0)
	.byte	(\base >> 24)
.endm

#endif//__START_ASH__
