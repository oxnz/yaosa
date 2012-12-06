	.file	"init.c"
.section	.rodata
.LC0:
.string	"0x00"
.text
.globl	int0
.type	int0, @function
int0:
.LFB0:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC0, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE0:
.size	int0, .-int0
.section	.rodata
.LC1:
.string	"0x01"
.text
.globl	int1
.type	int1, @function
int1:
.LFB1:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC1, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE1:
.size	int1, .-int1
.section	.rodata
.LC2:
.string	"0x02"
.text
.globl	int2
.type	int2, @function
int2:
.LFB2:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC2, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE2:
.size	int2, .-int2
.section	.rodata
.LC3:
.string	"0x03"
.text
.globl	int3
.type	int3, @function
int3:
.LFB3:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC3, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE3:
.size	int3, .-int3
.section	.rodata
.LC4:
.string	"0x04"
.text
.globl	int4
.type	int4, @function
int4:
.LFB4:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC4, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE4:
.size	int4, .-int4
.section	.rodata
.LC5:
.string	"0x05"
.text
.globl	int5
.type	int5, @function
int5:
.LFB5:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC5, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE5:
.size	int5, .-int5
.section	.rodata
.LC6:
.string	"0x06"
.text
.globl	int6
.type	int6, @function
int6:
.LFB6:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC6, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE6:
.size	int6, .-int6
.section	.rodata
.LC7:
.string	"0x07"
.text
.globl	int7
.type	int7, @function
int7:
.LFB7:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC7, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE7:
.size	int7, .-int7
.section	.rodata
.LC8:
.string	"0x08"
.text
.globl	int8
.type	int8, @function
int8:
.LFB8:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC8, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE8:
.size	int8, .-int8
.section	.rodata
.LC9:
.string	"0x09"
.text
.globl	int9
.type	int9, @function
int9:
.LFB9:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC9, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE9:
.size	int9, .-int9
.section	.rodata
.LC10:
.string	"0x0A"
.text
.globl	intA
.type	intA, @function
intA:
.LFB10:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC10, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE10:
.size	intA, .-intA
.section	.rodata
.LC11:
.string	"0x0B"
.text
.globl	intB
.type	intB, @function
intB:
.LFB11:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC11, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE11:
.size	intB, .-intB
.section	.rodata
.LC12:
.string	"0x0C"
.text
.globl	intC
.type	intC, @function
intC:
.LFB12:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC12, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE12:
.size	intC, .-intC
.section	.rodata
.LC13:
.string	"0x0D"
.text
.globl	intD
.type	intD, @function
intD:
.LFB13:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC13, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE13:
.size	intD, .-intD
.section	.rodata
.LC14:
.string	"0x0E"
.text
.globl	intE
.type	intE, @function
intE:
.LFB14:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC14, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE14:
.size	intE, .-intE
.section	.rodata
.LC15:
.string	"0x0F"
.text
.globl	intF
.type	intF, @function
intF:
.LFB15:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC15, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE15:
.size	intF, .-intF
.section	.rodata
.LC16:
.string	"0x10"
.text
.globl	int10
.type	int10, @function
int10:
.LFB16:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC16, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE16:
.size	int10, .-int10
.section	.rodata
.LC17:
.string	"0x11"
.text
.globl	int11
.type	int11, @function
int11:
.LFB17:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC17, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE17:
.size	int11, .-int11
.section	.rodata
.LC18:
.string	"0x12"
.text
.globl	int12
.type	int12, @function
int12:
.LFB18:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC18, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE18:
.size	int12, .-int12
.section	.rodata
.LC19:
.string	"0x13"
.text
.globl	int13
.type	int13, @function
int13:
.LFB19:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC19, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE19:
.size	int13, .-int13
.section	.rodata
.LC20:
.string	"0x14"
.text
.globl	int14
.type	int14, @function
int14:
.LFB20:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC20, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE20:
.size	int14, .-int14
.section	.rodata
.LC21:
.string	"0x15"
.text
.globl	int15
.type	int15, @function
int15:
.LFB21:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC21, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE21:
.size	int15, .-int15
.section	.rodata
.LC22:
.string	"0x16"
.text
.globl	int16
.type	int16, @function
int16:
.LFB22:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC22, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE22:
.size	int16, .-int16
.section	.rodata
.LC23:
.string	"0x17"
.text
.globl	int17
.type	int17, @function
int17:
.LFB23:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC23, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE23:
.size	int17, .-int17
.section	.rodata
.LC24:
.string	"0x18"
.text
.globl	int18
.type	int18, @function
int18:
.LFB24:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC24, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE24:
.size	int18, .-int18
.section	.rodata
.LC25:
.string	"0x19"
.text
.globl	int19
.type	int19, @function
int19:
.LFB25:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC25, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE25:
.size	int19, .-int19
.section	.rodata
.LC26:
.string	"0x1A"
.text
.globl	int1A
.type	int1A, @function
int1A:
.LFB26:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC26, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE26:
.size	int1A, .-int1A
.section	.rodata
.LC27:
.string	"0x1B"
.text
.globl	int1B
.type	int1B, @function
int1B:
.LFB27:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC27, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE27:
.size	int1B, .-int1B
.section	.rodata
.LC28:
.string	"0x1C"
.text
.globl	int1C
.type	int1C, @function
int1C:
.LFB28:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC28, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE28:
.size	int1C, .-int1C
.section	.rodata
.LC29:
.string	"0x1D"
.text
.globl	int1D
.type	int1D, @function
int1D:
.LFB29:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC29, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE29:
.size	int1D, .-int1D
.section	.rodata
.LC30:
.string	"0x1E"
.text
.globl	int1E
.type	int1E, @function
int1E:
.LFB30:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC30, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE30:
.size	int1E, .-int1E
.section	.rodata
.LC31:
.string	"0x1F"
.text
.globl	int1F
.type	int1F, @function
int1F:
.LFB31:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
subl	$24, %esp
movl	$.LC31, (%esp)
call	kputs
leave
.cfi_restore 5
.cfi_def_cfa 4, 4
ret
.cfi_endproc
.LFE31:
.size	int1F, .-int1F
.globl	idt_init
.type	idt_init, @function
idt_init:
.LFB32:
.cfi_startproc
pushl	%ebp
.cfi_def_cfa_offset 8
.cfi_offset 5, -8
movl	%esp, %ebp
.cfi_def_cfa_register 5
movl	IDT, %eax
movl	$int0, %edx
movw	%dx, (%eax)
movl	IDT, %eax
movl	$int0, %edx
shrl	$16, %edx
movw	%dx, 6(%eax)
movl	IDT, %eax
leal	8(%eax), %edx
movl	$int1, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	8(%eax), %edx
movl	$int1, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	16(%eax), %edx
movl	$int2, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	16(%eax), %edx
movl	$int2, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	24(%eax), %edx
movl	$int3, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	24(%eax), %edx
movl	$int3, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	32(%eax), %edx
movl	$int4, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	32(%eax), %edx
movl	$int4, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	40(%eax), %edx
movl	$int5, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	40(%eax), %edx
movl	$int5, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	48(%eax), %edx
movl	$int6, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	48(%eax), %edx
movl	$int6, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	56(%eax), %edx
movl	$int7, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	56(%eax), %edx
movl	$int7, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	64(%eax), %edx
movl	$int8, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	64(%eax), %edx
movl	$int8, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	72(%eax), %edx
movl	$int9, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	72(%eax), %edx
movl	$int9, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	80(%eax), %edx
movl	$intA, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	80(%eax), %edx
movl	$intA, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	88(%eax), %edx
movl	$intB, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	88(%eax), %edx
movl	$intB, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	96(%eax), %edx
movl	$intC, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	96(%eax), %edx
movl	$intC, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	104(%eax), %edx
movl	$intD, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	104(%eax), %edx
movl	$intD, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	112(%eax), %edx
movl	$intE, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	112(%eax), %edx
movl	$intE, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	120(%eax), %edx
movl	$intF, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	120(%eax), %edx
movl	$intF, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	128(%eax), %edx
movl	$int10, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	128(%eax), %edx
movl	$int10, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	136(%eax), %edx
movl	$int11, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	136(%eax), %edx
movl	$int11, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	144(%eax), %edx
movl	$int12, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	144(%eax), %edx
movl	$int12, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	152(%eax), %edx
movl	$int13, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	152(%eax), %edx
movl	$int13, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	160(%eax), %edx
movl	$int14, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	160(%eax), %edx
movl	$int14, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	168(%eax), %edx
movl	$int15, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	168(%eax), %edx
movl	$int15, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	176(%eax), %edx
movl	$int16, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	176(%eax), %edx
movl	$int16, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	184(%eax), %edx
movl	$int17, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	184(%eax), %edx
movl	$int17, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	192(%eax), %edx
movl	$int18, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	192(%eax), %edx
movl	$int18, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	200(%eax), %edx
movl	$int19, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	200(%eax), %edx
movl	$int19, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	208(%eax), %edx
movl	$int1A, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	208(%eax), %edx
movl	$int1A, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	216(%eax), %edx
movl	$int1B, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	216(%eax), %edx
movl	$int1B, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	224(%eax), %edx
movl	$int1C, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	224(%eax), %edx
movl	$int1C, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	232(%eax), %edx
movl	$int1D, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	232(%eax), %edx
movl	$int1D, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	240(%eax), %edx
movl	$int1E, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	240(%eax), %edx
movl	$int1E, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
movl	IDT, %eax
leal	248(%eax), %edx
movl	$int1F, %eax
movw	%ax, (%edx)
movl	IDT, %eax
leal	248(%eax), %edx
movl	$int1F, %eax
shrl	$16, %eax
movw	%ax, 6(%edx)
popl	%ebp
.cfi_def_cfa 4, 4
.cfi_restore 5
ret
.cfi_endproc
.LFE32:
.size	idt_init, .-idt_init
.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu3) 4.6.3"
.section	.note.GNU-stack,"",@progbits 
