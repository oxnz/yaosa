void cloader(void);
static void inline putch(const char ch);
static void inline puts(const char* s);
int printf(const char* fmt, ...);
unsigned short* gp = (unsigned short*)0xB8000;
static void inline putch(const char ch)
{
static short x = 0;
static short y = 0;
switch (ch)
{
case '\n':
++y;
case '\r':
x = 0;
break;
default:
*(gp + (x++) + 80 * y) = 0x0F00 | ch;
break;
}
}
static void inline puts(const char* s)
{
while (*s)
putch(*s++);
}
int printf(const char* fmt, ...)
{
char* pfmt = (char*)&fmt;
char* parg = pfmt + sizeof(fmt);
while (*pfmt)
{
switch (*pfmt)
{
case '%':
putch('%');
break;
case 'd':
puts("ddd");
break;
case 's':
puts((char*)(*(int*)parg));
break;
case '\n':
putch('\n');
break;
default:
puts((char*)(*(int*)parg));
puts("fuck");
break;
}
++pfmt;
parg += 4;
}
parg = 0;
return 0;
}
void cloader(void)
{
printf("%s", "xcxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxend");
unsigned long long* mem = (unsigned long long*)(0x8000-8);
*mem -= 0x100000;
} 
