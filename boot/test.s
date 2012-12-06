main:
pushl	%ebp
movl	%esp, %ebp
subl	$16, %esp
movl	$1, -12(%ebp)
movl	$2, -8(%ebp)
movw	$3, -2(%ebp)
movl	-8(%ebp), %eax
movl	%eax, %edx
movzwl	-2(%ebp), %eax
imull	%eax, %edx
movl	-12(%ebp), %eax
addl	%edx, %eax
movw	%ax, -2(%ebp)
movl	$0, %eax
leave
ret 
