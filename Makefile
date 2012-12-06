TARGET	=	/dev/loop0
LDFLAGS	=	--oformat binary -Ttext 0x100000 -e start -s
#LDFLAGS = -e start -Ttext 0x100000 -s -M
SUBDIRS	=	boot \
		driver \
		kernel
DEPS	=	drv/drv.a boot/bootsect.bin boot/obr.bin kernel/kernel.o
$(TARGET): $(DEPS)
	$(LD) $(LDFLAGS) kernel/kernel.a -o yaosa.bin
	# @sudo dd if=boot/bootsect.bin of=$@ bs=512 count=1
	@sudo dd if=boot/yosboot.bin of=$@ bs=512 count=1
	@sudo cp boot/loader.bin /mnt/boot/loader16.bin
	@sudo cp yaosa.bin /mnt/boot/kernel00.yos
	@sync
$(DEPS):
	@list='$(SUBDIRS)'; for subdir in $$list; do \
	(cd $$subdir && make); \
	done
test: conf.bochs
	bochs -q -f conf.bochs
backup:
	(cd .. && tar -cjf yaosa.tar.bz2 yaosa --exclude=yaosa/.git)
clean:
	@list='$(SUBDIRS)'; for subdir in $$list; do \
	(cd $$subdir && make clean); \
	done
prepare:
	sudo losetup /dev/loop0 xos.img
	sudo mount xos.img /mnt
push:
	git commit
	git push
.PHONY: image push test clean 
