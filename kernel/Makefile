TARGET	=	kernel.a
CC	=	gcc
LD	=	ld
AR	=	ar
CFLAGS	=	-O -Wall -nostdlib -nostdinc -fno-builtin -fstrength-reduce \
		-finline-functions
LDFLAGS	=	-nostdlib -s -x -M -N
ARFLAGS	=	ru
INCD	=	../include
CSRCS	=	$(wildcard *.c)
ASRCS	+=	$(wildcard *.S)
OBJS	=	$(CSRCS:.c=.o)
OBJS	+=	$(ASRCS:.S=.o)
DEPS	=	$(CSRCS:.c=.d)
DEPS	+=	$(ASRCS:.S=.d)
$(TARGET): $(DEPS) $(OBJS)
	# $(LD) $(LDFLAGS) -r -Ttext 0x100000 -e start $(OBJS) -o $@
	$(AR) $(ARFLAGS) $@ $^
%.d:%.c
	$(CC) $(CFLAGS) -I $(INCD) -MM $< > $@
%.d:%.S
	$(CC) $(CFLAGS) -I $(INCD) -MM $< > $@
sinclude $(DEPS)
%.o:%.c
	$(CC) $(CFLAGS) -I $(INCD) -MD -c -o $@ $<
%.o:%.S
	$(CC) $(CFLAGS) -I $(INCD) -MD -c -o $@ $<
clean:
	@rm -rf $(DEPS)
	@rm -rf $(OBJS)
.PHONY: $(TARGET) clean 
