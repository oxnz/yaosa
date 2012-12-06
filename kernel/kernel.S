.code32
.global restart
restart:
movw $0x0C41,0xB8000
hlt
jmp . 
