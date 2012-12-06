#include <yaosa/types.h>
#include <yaosa/kernel.h>
static __ku16* gp = (__ku16*)0xB8000;
static __ku16 x = 0;
static __ku16 y = 0;
static __ku16 property = 0x0C00;
inline void kputch(const __ku8 ch)
{
switch (ch)
{
case '\b':
x--;
x = x > 0 ? x : 0;
break;
case '\t':
x += 8;
x &= ~7;
break;
case '\n':
++y;
case '\r':
x = 0;
break;
default:
*(gp + (x++) + 80*y) = property | ch;
break;
}
if (x > 80)
{
++y;
x -= 80;
}
if (y > 25)
y = 0;
}
void kputs(const __ks8* s)
{
while (*s)
kputch(*s++);
} 
