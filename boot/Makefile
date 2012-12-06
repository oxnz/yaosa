CC	=	gcc
LD	=	ld
OBJCP	=	objcopy
INCD	=	../include
CFLAGS	=	-O -Wall -nostdinc -nostdlib -fno-builtin \
		-fno-guess-branch-probability -mno-mmx -mno-3dnow \
		-mno-sse -mno-sse2 -mno-sse3 \
		-Wcast-align -Wbad-function-cast -Wmissing-declarations \
		-Wmissing-prototypes -Wnested-externs \
		-Wstrict-prototypes
LDFLAGS	=	-N -e start -static
OBJCPFLAGS	=	-S -O binary
ASRCS	=	$(wildcard *.S)
CSRCS	=	$(wildcard *.c)
OBJS	=	$(ASRCS:.S=.o)
OBJS	+=	$(CSRCS:.c=.o)
ELFS	=	$(ASRCS:.S=.elf)
BINS	=	$(ASRCS:.S=.bin)
TARGET: bootsect.bin \
	yosboot.bin \
	loader.bin
bootsect.bin: bootsect.elf
	$(OBJCP) $(OBJCPFLAGS) $< $@
yosboot.bin: yosboot.elf
	$(OBJCP) $(OBJCPFLAGS) $< $@
loader.bin: loader.elf
	$(OBJCP) $(OBJCPFLAGS) $< $@
bootsect.elf: bootsect.o
	$(LD) $(LDFLAGS) -Ttext 0x0600 $< -o $@
yosboot.elf: yosboot.o
	$(LD) $(LDFLAGS) -Ttext 0x0600 $< -o $@
loader.elf: asmload.o loader.o
	$(LD) $(LDFLAGS) -Ttext 0x1000 $^ -o $@
%.o:%.S
	$(CC) $(CFLAGS) -I $(INCD) -c -o $@ $<
%.o:%.c
	$(CC) $(CFLAGS) -I $(INCD) -c -o $@ $<
clean:
	rm -f $(OBJS)
	rm -f $(ELFS)
	rm -f $(BINS)
.PHONY: TARGET clean 
