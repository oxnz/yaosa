#include <yaosa/types.h>
#include <yaosa/idt.h>
/*
IDT_Entry* IDT = (IDT_Entry*)0x0;
RET, and its exact synonym RETN, pop IP or EIP from the stack and transfer control to the new address. Optionally, if a numeric second operand is provided, they increment the stack pointer by a further imm16 bytes after popping the return address.
RETF executes a far return: after popping IP/EIP, it then pops CS, and then increments the stack pointer by the optional argument if present.
IRET returns from an interrupt (hardware or software) by means of popping IP (or EIP), CS and the flags off the stack and then continuing execution from the new CS:IP.
IRETW pops IP, CS and the flags as 2 bytes each, taking 6 bytes off the stack in total.
IRETD pops EIP as 4 bytes, pops a further 4 bytes of which the top two are discarded and the bottom two go into CS, and pops the flags as 4 bytes as well, taking 12 bytes off the stack.
IRET is a shorthand for either IRETW or IRETD, depending on the default BITS setting at the time.
*/ 
