#ifndef __BOOT_H__
#define __BOOT_H__
#ifndef FAT32
#define FAT32
#define END_OF_CLUS 0x0FFFFFFF
#endif//FAT32
#define STACK 0x8000
#define BUFFER 0x0800
#define MAGIC 0xAA55
#define ORIGIN 0x0600
#define BOOT 0x0600
#endif//__BOOT_H__ 
