	.file	"main.c"
	.comm	sPass,32,32
	.comm	sCarrinho,32,32
	.globl	mutex
	.bss
	.align 32
	.type	mutex, @object
	.size	mutex, 40
mutex:
	.zero	40
	.comm	nPass,4,4
	.comm	cap,4,4
	.comm	nPassCarrinho,4,4
	.comm	nPassRestante,4,4
	.comm	listaPass,2000,32
	.comm	listaThread,2000,32
	.text
	.globl	inicializar
	.type	inicializar, @function
inicializar:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	cap(%rip), %eax
	movl	%eax, %edx
	movl	$0, %esi
	movl	$sPass, %edi
	call	sem_init
	movl	$0, %edx
	movl	$0, %esi
	movl	$sCarrinho, %edi
	call	sem_init
	movl	$0, %esi
	movl	$mutex, %edi
	call	pthread_mutex_init
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	inicializar, .-inicializar
	.section	.rodata
	.align 8
.LC0:
	.string	"Numero de passageiros (<500): "
.LC1:
	.string	"%d"
	.align 8
.LC2:
	.string	"Numero de passageiros por carrinho: "
	.text
	.globl	carregarVariaveis
	.type	carregarVariaveis, @function
carregarVariaveis:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$nPass, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movl	$cap, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movl	$10, %edi
	call	putchar
	movl	$0, nPassCarrinho(%rip)
	movl	nPass(%rip), %eax
	movl	%eax, nPassRestante(%rip)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	carregarVariaveis, .-carregarVariaveis
	.globl	finalizar
	.type	finalizar, @function
finalizar:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$sPass, %edi
	call	sem_destroy
	movl	$sCarrinho, %edi
	call	sem_destroy
	movl	$mutex, %edi
	call	pthread_mutex_destroy
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	finalizar, .-finalizar
	.globl	getPassID
	.type	getPassID, @function
getPassID:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	call	rand
	movl	%eax, %ecx
	movl	$274877907, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$5, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	imull	$500, %eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	getPassID, .-getPassID
	.section	.rodata
	.align 8
.LC3:
	.string	"passageiro[id:%d].entrar() - thread: %d\n"
	.text
	.globl	passageiro
	.type	passageiro, @function
passageiro:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$sPass, %edi
	call	sem_wait
	movl	$mutex, %edi
	call	pthread_mutex_lock
	movl	$0, %eax
	call	getPassID
	movl	%eax, -8(%rbp)
	movq	-24(%rbp), %rax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	nPassCarrinho(%rip), %eax
	addl	$1, %eax
	movl	%eax, nPassCarrinho(%rip)
	movl	nPassCarrinho(%rip), %eax
	cltq
	movl	-8(%rbp), %edx
	movl	%edx, listaPass(,%rax,4)
	movl	nPassCarrinho(%rip), %eax
	cltq
	movl	-4(%rbp), %edx
	movl	%edx, listaThread(,%rax,4)
	movl	nPassRestante(%rip), %eax
	subl	$1, %eax
	movl	%eax, nPassRestante(%rip)
	movl	nPassCarrinho(%rip), %edx
	movl	cap(%rip), %eax
	cmpl	%eax, %edx
	je	.L7
	movl	nPassRestante(%rip), %eax
	testl	%eax, %eax
	jne	.L8
.L7:
	movl	$sCarrinho, %edi
	call	sem_post
.L8:
	movl	$mutex, %edi
	call	pthread_mutex_unlock
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	passageiro, .-passageiro
	.section	.rodata
.LC4:
	.string	"carrinho.passear()"
	.align 8
.LC5:
	.string	"passageiro[id:%d].descer() - thread: %d\n"
.LC6:
	.string	"carrinho.esperando()\n"
	.text
	.globl	carrinho
	.type	carrinho, @function
carrinho:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	jmp	.L10
.L13:
	movl	$sCarrinho, %edi
	call	sem_wait
	movl	$mutex, %edi
	call	pthread_mutex_lock
	movl	$.LC4, %edi
	call	puts
	movl	$1, -4(%rbp)
	jmp	.L11
.L12:
	movl	$sPass, %edi
	call	sem_post
	movl	-4(%rbp), %eax
	cltq
	movl	listaThread(,%rax,4), %edx
	movl	-4(%rbp), %eax
	cltq
	movl	listaPass(,%rax,4), %eax
	movl	%eax, %esi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -4(%rbp)
.L11:
	movl	nPassCarrinho(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jle	.L12
	movl	$0, nPassCarrinho(%rip)
	movl	$.LC6, %edi
	call	puts
	movl	$mutex, %edi
	call	pthread_mutex_unlock
.L10:
	movl	nPassRestante(%rip), %edx
	movl	nPassCarrinho(%rip), %eax
	addl	%edx, %eax
	testl	%eax, %eax
	jg	.L13
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	carrinho, .-carrinho
	.section	.rodata
.LC7:
	.string	"Erro na criacao da thread!"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$4032, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, %eax
	call	carregarVariaveis
	movl	$0, %eax
	call	inicializar
	movl	$1, -4028(%rbp)
	jmp	.L15
.L17:
	movl	-4028(%rbp), %eax
	cltq
	movq	%rax, %rcx
	leaq	-4016(%rbp), %rax
	movl	-4028(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movl	$passageiro, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	testl	%eax, %eax
	je	.L16
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
.L16:
	addl	$1, -4028(%rbp)
.L15:
	movl	nPass(%rip), %eax
	cmpl	%eax, -4028(%rbp)
	jle	.L17
	leaq	-4024(%rbp), %rax
	movl	$0, %ecx
	movl	$carrinho, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	movl	$0, %edi
	call	pthread_exit
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
