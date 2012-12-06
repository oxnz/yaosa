TARGET	=
CC	=	gcc
LD	=	ld
INCD	=	../inc
CFLAGS	=	-O -Wall -nostdinc -nostdlib -fno-builtin
LDFLAGS	=	--oformat binary -N -e start
ASRCS +=	$(wildcard *.S)
CSRCS +=	$(wildcard *.c)
OBJS	=	$(ASRCS:.S=.o)
OBJS +=	$(CSRCS:.c=.o)
DEPS	=	$(ASRCS:.S=.d)
DEPS +=	$(CSRCS:.c=.d)
$(TARGET): $(DEPS) $(OBJS)
%.d:%.S
$(CC) $(CFLAGS) -I $(INCD) -MM $< > $@
sinclude $(DEPS)
%.o:%.S
$(CC) $(CFLAGS) -I $(INCD) -c -o $@ $<
clean:
-rm $(DEPS)
-rm $(OBJS)
.PHONY: $(TARGET) clean 
