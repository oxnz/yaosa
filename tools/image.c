#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[])
{
FILE* fd;
FILE* fbs;
FILE* fobr;
FILE* fld;
FILE* fkern;
if ((fd = fopen(argv[1], "wb")) == NULL)
{
perror("fopen [%s](binary write mode)", argv[1]);
return 1;
}
else if ((fbs = fopen(argv[2], "rb")) == NULL)
{
perror("fopen [%s](binary read mode)", argv[1]);
return 2;
}
else if ((fbs = fopen(argv[3], "rb")) == NULL)
{
perror("fopen [%s](binary read mode)", argv[1]);
return 2;
}
else if ((fbs = fopen(argv[4], "rb")) == NULL)
{
perror("fopen [%s](binary read mode)", argv[1]);
return 2;
}
write_bs();
write_obr();
write_loader();
write_kern();
return 0;
} 
