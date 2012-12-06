#ifndef __GDT_H__
#define __GDT_H__
#include <yaosa/types.h>
#define SEG_TYPE(x) ((x) << 0x04) // Descriptor type (0 for system, 1 for code/data)
#define SEG_PRES(x) ((x) << 0x07) // Present
#define SEG_SAVL(x) ((x) << 0x0C) // Available for system use
#define SEG_LONG(x) ((x) << 0x0D) // Long mode
#define SEG_SIZE(x) ((x) << 0x0E) // Size (0 for 16-bit, 1 for 32)
#define SEG_GRAN(x) ((x) << 0x0F) // Granularity(0 for 1B-1MB, 1 for 4KB-4GB)
#define SEG_PRIV(x) (((x) & 0x03) << 0x05) // Set privilege level (0 ~ 3)
#define SEG_DATA_RD 0x00 // Read-Only
#define SEG_DATA_RDA 0x01 // Read-Only, accessed
#define SEG_DATA_RDWR 0x02 // Read/Write
#define SEG_DATA_RDWRA 0x03 // Read/Write, accessed
#define SEG_DATA_RDEXPD 0x04 // Read-Only, expand-down
#define SEG_DATA_RDEXPDA 0x05 // Read-Only, expand-down, accessed
#define SEG_DATA_RDWREXPD 0x06 // Read/Write, expand-down
#define SEG_DATA_RDWREXPDA 0x07 // Read/Write, expand-down, accessed
#define SEG_CODE_EX 0x08 // Execute-Only
#define SEG_CODE_EXA 0x09 // Execute-Only, accessed
#define SEG_CODE_EXRD 0x0A // Execute/Read
#define SEG_CODE_EXRDA 0x0B // Execute/Read, accessed
#define SEG_CODE_EXC 0x0C // Execute-Only, confirming
#define SEG_CODE_EXCA 0x0D // Execute-Only, confirming, accessed
#define SEG_CODE_EXRDC 0x0E // Execute/Read, confirming
#define SEG_CODE_EXRDCA 0x0F // Execute/Read, confirming, accessed
#define GDT_CODE_PL0 SEG_TYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0) | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(0) | SEG_CODE_EXRD
#define GDT_DATA_PL0 SEG_TYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0) | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(0) | SEG_CODE_RDWR
#define GDT_CODE_PL3 SEG_TYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0) | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(3) | SEG_CODE_EXRD
#define GDT_DATA_PL3 SEG_TYPE(1) | SEG_PRES(1) | SEG_SAVL(0) | \
SEG_LONG(0) | SEG_SIZE(1) | SEG_GRAN(1) | \
SEG_PRIV(3) | SEG_CODE_RDWR
void create_descriptor(__ku32 base, __ku32 limit, __ku16 flag)
{
__ku64 descriptor;
descriptor	=	limit & 0x000F0000;
descriptor	|=	(flag << 8) & 0x00F0FF00;
descriptor	|=	(base >> 16) & 0xFF0000FF;
// shift by 32 to allow for low part of segment
descriptor	<<=	32;
// create the low 32 bit segment
descriptor	|=	base << 16;
descriptor	|=	limit & 0x0000FFFF;
}
#endif//__GDT_H__ 
