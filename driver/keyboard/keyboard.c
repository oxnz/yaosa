#include <system.h>

unsigned char kb_US[128] =
{
	0, 27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',
	'\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',
	0,	// 29 control
	'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',
	'\'', '`', '0', // left shift
	'\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '/', 0,
	'*',
	0,	// alt
	' ',	// space
	0,	// capslock
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	// F1~F10
	0,	// Numlock
	0,	// Scroll lock
	0,	// Home key
	0,	// Up arrow
	0,	// Page up
	'-',
	0,	// Left arrow
	0,
	0,	// Right arrow
	'+',
	0,	// 79 - End key
	0,	// Down arrow
	0,	// Page down
	0,	// Insert key
	0,	0,	0,
	0,	// F11
	0,	// F12
	0,	// All other undifined keys
};
