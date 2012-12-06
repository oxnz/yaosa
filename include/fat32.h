#ifndef __X_MBR_H__
#define __X_MBR_H__
#include <system.h>
struct PartEntry
{
__ku8 bootInd;
__ku8 startH;
__ku8 startS;
__ku8 startC;
__ku8 sysInd;
__ku8 endH;
__ku8 endS;
__ku8 endC;
__ku8 realSec4;
__ku8 realSec3;
__ku8 realSec2;
__ku8 realSec1;
__ku8 sect4;
__ku8 sect3;
__ku8 sect2;
__ku8 sect1;
};
struct MBR
{
__ku8 jmpCode[3];	// boot strap short jmp and a nop
__ku8 oemName[8];
__ku8 bytesPerSec[2];
__ku8 secPerClu;
__k16 reserved;
__ku8 FATs;
__ku8 rootEntry[2];
__ku8 sectors[2];
__ku8 media;
__k16 secsPerFAT;
__k16 secsPerTrk;
__k16 heads;
__ku32 hidden;
__ku32 total;
struct PartEntry pe[4];
__ku8 bootFlag[2];
};
struct SuperBlock
{
__ku16	clusterSize;
__ku16	clusterBits;
__ku8	FATs;
__ku8	FATBits;
};
#endif //__X_MBR_H__ 
