	.file	"main.c"
	.comm	tam,4,4
	.text
	.globl	inicia
	.type	inicia, @function
inicia:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movl	$0, tam(%rip)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	inicia, .-inicia
	.globl	vazia
	.type	vazia, @function
vazia:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L3
	movl	$1, %eax
	jmp	.L4
.L3:
	movl	$0, %eax
.L4:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	vazia, .-vazia
	.section	.rodata
.LC0:
	.string	"Sem memoria disponivel!"
	.text
	.globl	aloca
	.type	aloca, @function
aloca:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$16, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L6
	movl	$.LC0, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L6:
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	aloca, .-aloca
	.globl	insere
	.type	insere, @function
insere:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, %eax
	call	aloca
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	vazia
	testl	%eax, %eax
	je	.L9
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L10
.L9:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -16(%rbp)
	jmp	.L11
.L12:
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -16(%rbp)
.L11:
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L12
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
.L10:
	movl	tam(%rip), %eax
	addl	$1, %eax
	movl	%eax, tam(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	insere, .-insere
	.section	.rodata
.LC1:
	.string	"Fila ja esta vazia"
	.text
	.globl	retira
	.type	retira, @function
retira:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L14
	movl	$.LC1, %edi
	call	puts
	movl	$0, %eax
	jmp	.L15
.L14:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, 8(%rax)
	movl	tam(%rip), %eax
	subl	$1, %eax
	movl	%eax, tam(%rip)
	movq	-8(%rbp), %rax
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	retira, .-retira
	.globl	libera
	.type	libera, @function
libera:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	vazia
	testl	%eax, %eax
	jne	.L20
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -16(%rbp)
	jmp	.L18
.L19:
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
.L18:
	cmpq	$0, -16(%rbp)
	jne	.L19
.L20:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	libera, .-libera
	.section	.rodata
.LC2:
	.string	"Fila vazia!\n"
.LC3:
	.string	"Fila :"
.LC4:
	.string	"%5d"
.LC5:
	.string	"\n        "
.LC6:
	.string	"  ^  "
.LC7:
	.string	"\nOrdem:"
.LC8:
	.string	"\n"
	.text
	.globl	exibe
	.type	exibe, @function
exibe:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	vazia
	testl	%eax, %eax
	je	.L22
	movl	$.LC2, %edi
	call	puts
	jmp	.L21
.L22:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	jmp	.L24
.L25:
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
.L24:
	cmpq	$0, -8(%rbp)
	jne	.L25
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movl	$0, -12(%rbp)
	jmp	.L26
.L27:
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -12(%rbp)
.L26:
	movl	tam(%rip), %eax
	cmpl	%eax, -12(%rbp)
	jl	.L27
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	movl	$0, -12(%rbp)
	jmp	.L28
.L29:
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -12(%rbp)
.L28:
	movl	tam(%rip), %eax
	cmpl	%eax, -12(%rbp)
	jl	.L29
	movl	$.LC8, %edi
	call	puts
.L21:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	exibe, .-exibe
	.globl	pause
	.type	pause, @function
pause:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movss	%xmm0, -20(%rbp)
	cvtss2sd	-20(%rbp), %xmm0
	movsd	.LC9(%rip), %xmm1
	ucomisd	%xmm0, %xmm1
	ja	.L36
	pxor	%xmm0, %xmm0
	movss	%xmm0, -4(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -8(%rbp)
	call	clock
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	.LC11(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -4(%rbp)
	jmp	.L34
.L35:
	call	clock
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movss	.LC11(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -8(%rbp)
.L34:
	movss	-8(%rbp), %xmm0
	subss	-4(%rbp), %xmm0
	movss	-20(%rbp), %xmm1
	ucomiss	%xmm0, %xmm1
	ja	.L35
	nop
	jmp	.L30
.L36:
	nop
.L30:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	pause, .-pause
	.section	.rodata
.LC12:
	.string	"Numero de passageiros: "
.LC13:
	.string	"%i"
	.align 8
.LC14:
	.string	"Numero de passageiros por carrinho: "
	.align 8
.LC15:
	.string	"Passageiro entrando no carrinho\n"
.LC16:
	.string	"\nCarrinho partindo...\n"
.LC17:
	.string	"Carrinho retornou\n"
.LC18:
	.string	"\nNao ha mais passageiros!\n"
.LC19:
	.string	"\nPassageiros entrando...\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$16, %edi
	call	malloc
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L38
	movl	$.LC0, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L38:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	inicia
.L39:
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	leaq	-36(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC13, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movl	-36(%rbp), %eax
	testl	%eax, %eax
	jle	.L39
	movl	$0, -32(%rbp)
	jmp	.L40
.L41:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	insere
	addl	$1, -32(%rbp)
.L40:
	movl	-36(%rbp), %eax
	cmpl	%eax, -32(%rbp)
	jl	.L41
.L42:
	movl	$.LC14, %edi
	movl	$0, %eax
	call	printf
	leaq	-40(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC13, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movl	-40(%rbp), %eax
	testl	%eax, %eax
	jle	.L42
	jmp	.L43
.L50:
	movl	$0, -28(%rbp)
	jmp	.L44
.L47:
	movl	-28(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC15, %edi
	movl	$0, %eax
	call	printf
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	retira
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L53
	addl	$1, -28(%rbp)
.L44:
	movl	-40(%rbp), %eax
	cmpl	%eax, -28(%rbp)
	jl	.L47
	jmp	.L46
.L53:
	nop
.L46:
	movl	$.LC16, %edi
	call	puts
	movl	$.LC17, %edi
	call	puts
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L48
	movl	$.LC18, %edi
	call	puts
	jmp	.L49
.L48:
	movl	$.LC19, %edi
	call	puts
.L43:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L50
.L49:
	movss	.LC20(%rip), %xmm0
	call	pause
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L52
	call	__stack_chk_fail
.L52:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC9:
	.long	3539053052
	.long	1062232653
	.align 4
.LC11:
	.long	1232348160
	.align 4
.LC20:
	.long	1056964608
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
