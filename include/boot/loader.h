#ifndef __LOADER_H__
#define __LOADER_H__
#ifndef FAT32
#define FAT32
#define END_OF_CLUS 0x0FFFFFFF
#endif//FAT32
#ifndef MAGIC
#define MAGIC 0xAA55
#endif
#ifndef STACK
#define STACK 0x8000
#endif
#ifndef BUFFER
#define BUFFER 0x0800
#endif
#define LOADSEG 0x0100
#define LOADER 0x1000
#define LOADLEN 0x0010
#ifndef KERNEL
#define KERNEL 0x8000
#endif
#ifndef KERNSEG
#define KERNSEG 0x0800
#endif
#ifndef KERNLEN
#define KERNLEN 0xF0000
#endif
#ifndef KENTRY
#define KENTRY 0x8000
#endif
#endif//__LOADER_H__ 
