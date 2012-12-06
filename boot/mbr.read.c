#include "mbr.h"
#include <stdio.h>
#include <stdlib.h>
void printMBR(struct MBR*);
int main(int argc, char *argv[])
{
FILE* fp;
struct MBR* pmbr;
if (argc == 1)
{
printf("[%s] srcfile\n", argv[0]);
return 0;
}
else if ((fp = fopen(argv[1], "rb")) == NULL)
{
perror("open failed");
return 1;
}
else if ((pmbr = malloc(sizeof(struct MBR))) == NULL)
{
perror("alloc memory falied");
return 2;
}
else if ((fread(pmbr, sizeof(struct MBR), 1, fp)) == 0)//sizeof(struct MBR))
{
perror("read error");
return 3;
}
else
{
printMBR(pmbr);
free(pmbr);
}
return 0;
}
void printMBR(struct MBR* pmbr)
{
int i;
printf("Boot Code: [%u]\n", sizeof(pmbr->bootCode));
printf("PartTable:\n");
printf(
"|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|\n",
"启动标志", "开始面", "开始柱面","开始磁道","系统标志","结束磁头","结束扇区","结束柱面","实际开始","实际结束"
);
for (i=0; i<4; ++i)
{
printf(
"|%s|%03u|%03u|%03u|%03u|%03u|%03u|%03u|%03u|%03u|\n"
,
pmbr->pe[i].bootInd == 0x80 ? "可以启动":"不可启动",
pmbr->pe[i].startH,
pmbr->pe[i].startS,
pmbr->pe[i].startC,
pmbr->pe[i].sysInd,
pmbr->pe[i].endH,
pmbr->pe[i].endS,
pmbr->pe[i].endC,
pmbr->pe[i].realSec4,
pmbr->pe[i].realSec3,
pmbr->pe[i].realSec2,
pmbr->pe[i].realSec1,
pmbr->pe[i].sect4,
pmbr->pe[i].sect3,
pmbr->pe[i].sect2,
pmbr->pe[i].sect1
);
}
} 
