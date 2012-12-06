#include <system.h>

unsigned short* gp;	// graphic pointer
int x, y;	// cursor position

/*	Move cursor position
 *		send command to indicies 14 and 15 in the VGA control
 *		register. These are the high and low bytes of the index
 *		that show where the hardware cursor is to be blinking.
 ******************************************************************************/

void movcsr(void)
{
	unsigned short tmp = y*80 + x;
	outportb(0x03D4, 14);
	outportb(0x03D5, tmp>>8);
	outportb(0x03D4, 15);
	outportb(0x03D4, tmp);
}

void clrscn(void)
{
	int i;
	for (i=0; i<25; ++i)
		memset(gp+i*80, 0x20|(0x0F<<8), 80);
	x = 0;
	y = 0;
	movcsr();
}

void scrn_init(void)
{
	gp = (unsigned short*)0x000B8000;
}

/*	Character output:
 *		0x00:	\0	NULL
 *		0x01~0x06
 *		0x07:	\a	Bell(not implemented yet)
 *		0x08:	\b	Backspace
 *		0x09:	\t	Tab
 *		0x0A:	\n	Line Feed(LF)
 *		0x0B:	\v	Vertical Tab
 *		0x0C:	\f	form feed
 *		0x0D:	\r	carriage return(CR)
 *		0x0E~0x1A:
 *		0x1B:	\\
 ******************************************************************************/

void kputch(const char ch)
{
	if (ch == 0x07)			// \a Bell
		;	// Not implemented yet
	else if (ch == 0x08)		// \b Backspace
	{
		if (x)
			--x;
	}
	else if (ch == 0x09)		// \t Tab
	{
		x = (x+8)&~(8-1);	// align = 8
	}
	else if (ch == 0x0A)		// \n
	{
		x = 0;
		++y;
	}
	else if (ch == 0x0B)		// \v
		y = (y+8)&~(8-1);
	else if (ch == 0x0C)		// \f
		;
	else if (ch == 0x0D)		// \r
		x = 0;
	else
	{
		*(gp+y*80+x) = ch | (0x0F << 8);
		++x;
	}

	if (x > 80)
	{
		x = 0;
		++y;
	}
	if (y > 25)
		--y;
	movcsr();
}

__ksize kputs(const char* str)
{
	__ksize i;
	for (i=0; i<strlen(str); ++i)
		kputch(str[i]);
	return i;
}
