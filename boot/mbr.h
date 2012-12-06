#ifndef __X_MBR_H__
#define __X_MBR_H__
struct PartEntry
{
unsigned char bootInd;
unsigned char startH;
unsigned char startS;
unsigned char startC;
unsigned char sysInd;
unsigned char endH;
unsigned char endS;
unsigned char endC;
unsigned char realSec4;
unsigned char realSec3;
unsigned char realSec2;
unsigned char realSec1;
unsigned char sect4;
unsigned char sect3;
unsigned char sect2;
unsigned char sect1;
};
struct MBR
{
unsigned char bootCode[446];
struct PartEntry pe[4];
unsigned char bootFlag[2];
};
#endif //__X_MBR_H__ 
