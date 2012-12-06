#ifndef __IO_H__
#define __IO_H__
#include <yaosa/types.h>
extern __ku8 inportb(__ku16 port);
extern __ku16 inportw(__ku16 port);
extern __ku32 inportl(__ku16 port);
extern void outportb(__ku16 port, __ku8 data);
extern void outportw(__ku16 port, __ku16 data);
extern void outportl(__ku16 port, __ku32 data);
/* Implementation
**************************************************/
__ku8 inportb(__ku16 port)
{
__ku8 rv;
__asm__ __volatile__("inb %1, %0" : "=a" (rv) : "d" (port));
return rv;
}
__ku16 inportw(__ku16 port)
{
__ku16 rv;
__asm__ __volatile__("inw %1, %0" : "=a" (rv) : "d" (port));
return rv;
}
__ku32 inportl(__ku16 port)
{
__ku32 rv;
__asm__ __volatile__("inl %1, %0" : "=a" (rv) : "d" (port));
return rv;
}
void outportb(__ku16 port, __ku8 data)
{
__asm__ __volatile__("outb %1, %0" : : "d" (port), "a" (data));
}
void outportw(__ku16 port, __ku16 data)
{
__asm__ __volatile__("outw %1, %0" : : "d" (port), "a" (data));
}
void outportl(__ku16 port, __ku32 data)
{
__asm__ __volatile__("outl %1, %0" : : "d" (port), "a" (data));
}
inline __ku32 read_cr0(void)
{
__ku32 x;
asm volatile("movl %%cr0, %0" : "=r"(x));
return x;
}
inline void cpuid(int code, __ku32 *a, __ku32* b)
{
asm volatile("cpuid" : "=a"(*a), "=d"(*b) : "0"(code) : "ebx", "ecx");
}
#endif//__IO_H__ 
