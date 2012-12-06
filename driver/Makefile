CC	=	gcc
AS	=	as
LD	=	ld
AR	=	ar

INCDIR	=	../include
LIBDIR	=	./

CFLAGS	=	-O -Wall -nostdinc -fno-builtin -nostdlib $(addprefix -I, $(INCDIR)) $(addprefix -L, $(LIBDIR))

ARFLAGS	=	ruv
LDFLAGS	=	-s

DRVSRCS	=	$(wildcard video/*.c) $(wildcard keyboard/*.c)
DRVOBJS	=	$(patsubst %.c, %.o, $(DRVSRCS))

TARGET:	drv.a

$(DRVOBJS): $(DRVSRCS)

drv.a: $(DRVOBJS) $(INCDIR)/system.h
	$(AR) $(ARFLAGS) $@ $<
clean:
	rm -f $(DRVOBJS)

.PHONY: TARGET clean
