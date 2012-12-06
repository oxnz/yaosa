#ifndef __SYSTEM_H__
#define __SYSTEM_H__
typedef char	__ks8;
typedef short	__ks16;
typedef int	__ks32;
typedef unsigned char	__ku8;
typedef unsigned short	__ku16;
typedef unsigned int	__ku32;
typedef unsigned int	__ksize;
/* functions defined in main.c
* for kernel use.
*/
extern void* memcpy(void* dest, void* scr, __ksize count);
extern void* memset(void* dest, __ks8 val, __ksize count);
extern void* memsetw(void* dest, __ks16 val, __ksize count);
extern __ksize strlen(const __ks8* str);
extern __ku8 inportb(__ku16 port);
extern void outportb(__ku16 port, __ku8 data);
/*
* Drivers
* [screen.c]
*/
extern void clrscn(void);
extern void kputch(const __ks8 ch);
extern __ksize kputs(const __ks8* str);
extern void scrn_init(void);
#endif//__SYSTEM_H__ 
