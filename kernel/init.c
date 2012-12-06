#include <yaosa/types.h>
typedef struct
{
__ku32	back_link;
__ku32	esp0,	ss0,	esp1,	ss1,	esp2,	ss2;
__ku32	cr3,	eip,	eflags;
__ku32	eax,	ecx,	edx,	ebx;
__ku32	esp,	ebp,	esi,	edi;
__ku32	es,	cs,	ss,	ds,	fs,	gs;
__ku32	ldt;
__ku32	trace_bitmap;
}__attribute__((packed))TSS;
extern	void	task1(void);
TSS	tss11 = {
0x0,
0x9000,	0x10,	0x0,	0x0,	0x0,	0x0,
0x0,	(__ku32)task1,	0x200,
0x0,	0x0,	0x0,	0x0,
0x10000,0x0,	0x0,	0x0,
0x0,	0x0,	0x0,	0x0,	0x0,	0x0,
0x38,
0x8000000,
};
extern	__ku64*	gdt;
void init(void)
{
gdt[2] = 0x0;
tss11.esp0	= 0x0;
} 
