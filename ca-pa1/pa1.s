	.file	"pa1.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	Uadd64
	.type	Uadd64, @function
Uadd64:
	addi	sp,sp,-32
	sw	a0,8(sp)
	sw	a2,0(sp)
	add	a3,a1,a3
	sw	a3,20(sp)
	bleu	a1,a3,.L2
	lw	a5,16(sp)
	addi	a5,a5,1
	sw	a5,16(sp)
.L2:
	lw	a5,8(sp)
	lw	a0,0(sp)
	add	a5,a5,a0
	lw	a0,16(sp)
	add	a0,a0,a5
	lw	a1,20(sp)
	addi	sp,sp,32
	jr	ra
	.size	Uadd64, .-Uadd64
	.align	2
	.globl	Usub64
	.type	Usub64, @function
Usub64:
	addi	sp,sp,-32
	sw	a0,8(sp)
	sw	a2,0(sp)
	bltu	a1,a3,.L5
	sub	a1,a1,a3
	sw	a1,20(sp)
.L6:
	lw	a5,8(sp)
	lw	a4,0(sp)
	bltu	a5,a4,.L7
	sub	a5,a5,a4
	sw	a5,16(sp)
.L8:
	lw	a0,16(sp)
	lw	a1,20(sp)
	addi	sp,sp,32
	jr	ra
.L5:
	sub	a1,a1,a3
	sw	a1,20(sp)
	lw	a5,8(sp)
	addi	a5,a5,-1
	sw	a5,8(sp)
	j	.L6
.L7:
	sub	a5,a5,a4
	sw	a5,16(sp)
	j	.L8
	.size	Usub64, .-Usub64
	.align	2
	.globl	Umul64
	.type	Umul64, @function
Umul64:
	addi	sp,sp,-32
	sw	a0,8(sp)
	sw	a1,12(sp)
	sw	a2,0(sp)
	sw	a3,4(sp)
	sw	zero,20(sp)
	sw	zero,16(sp)
	j	.L11
.L13:
	lw	a3,8(sp)
	lw	a4,16(sp)
	add	a4,a4,a3
	sw	a4,16(sp)
.L12:
	lw	a4,8(sp)
	slli	a4,a4,1
	sw	a4,8(sp)
	lw	a3,12(sp)
	blt	a3,zero,.L18
.L14:
	slli	a3,a3,1
	sw	a3,12(sp)
	srli	a5,a5,1
	sw	a5,4(sp)
	lw	a4,0(sp)
	andi	a3,a4,1
	beq	a3,zero,.L15
	li	a3,-2147483648
	add	a5,a5,a3
	sw	a5,4(sp)
.L15:
	srli	a4,a4,1
	sw	a4,0(sp)
.L11:
	lw	a5,4(sp)
	bne	a5,zero,.L16
	lw	a4,0(sp)
	beq	a4,zero,.L19
.L16:
	andi	a4,a5,1
	beq	a4,zero,.L12
	lw	a3,12(sp)
	lw	a4,20(sp)
	add	a4,a3,a4
	sw	a4,20(sp)
	bleu	a3,a4,.L13
	lw	a4,16(sp)
	addi	a4,a4,1
	sw	a4,16(sp)
	j	.L13
.L18:
	addi	a4,a4,1
	sw	a4,8(sp)
	j	.L14
.L19:
	lw	a0,16(sp)
	lw	a1,20(sp)
	addi	sp,sp,32
	jr	ra
	.size	Umul64, .-Umul64
	.align	2
	.globl	Udiv64
	.type	Udiv64, @function
Udiv64:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	a0,8(sp)
	sw	a1,12(sp)
	sw	a2,0(sp)
	sw	a3,4(sp)
	sw	zero,20(sp)
	sw	zero,16(sp)
	mv	s1,a2
	bne	a2,zero,.L35
	beq	a3,zero,.L22
	li	s0,0
	j	.L23
.L35:
	li	s0,0
	j	.L23
.L22:
	lw	a5,16(sp)
	sw	a5,24(sp)
	lw	a5,20(sp)
	sw	a5,28(sp)
	j	.L24
.L41:
	lw	a3,20(sp)
	lw	a4,4(sp)
	bgeu	a3,a4,.L26
.L25:
	slli	a5,a5,1
	sw	a5,16(sp)
	lw	a4,20(sp)
	blt	a4,zero,.L37
.L27:
	slli	a4,a4,1
	sw	a4,20(sp)
	lw	a5,8(sp)
	blt	a5,zero,.L38
.L28:
	slli	a5,a5,1
	sw	a5,8(sp)
	lw	a4,12(sp)
	blt	a4,zero,.L39
.L29:
	slli	a4,a4,1
	sw	a4,12(sp)
.L30:
	addi	s0,s0,1
.L23:
	li	a5,64
	bgt	s0,a5,.L40
	lw	a5,16(sp)
	bgtu	s1,a5,.L25
	beq	s1,a5,.L41
.L26:
	lw	a2,0(sp)
	lw	a3,4(sp)
	lw	a0,16(sp)
	lw	a1,20(sp)
	call	Usub64
	sw	a1,20(sp)
	slli	a0,a0,1
	sw	a0,16(sp)
	mv	a5,a1
	blt	a1,zero,.L42
.L31:
	slli	a4,a5,1
	sw	a4,20(sp)
	lw	a5,8(sp)
	blt	a5,zero,.L43
.L32:
	slli	a4,a5,1
	sw	a4,8(sp)
	lw	a5,12(sp)
	blt	a5,zero,.L44
.L33:
	slli	a5,a5,1
	addi	a5,a5,1
	sw	a5,12(sp)
	j	.L30
.L37:
	addi	a5,a5,1
	sw	a5,16(sp)
	j	.L27
.L38:
	addi	a4,a4,1
	sw	a4,20(sp)
	j	.L28
.L39:
	addi	a5,a5,1
	sw	a5,8(sp)
	j	.L29
.L42:
	addi	a0,a0,1
	sw	a0,16(sp)
	j	.L31
.L43:
	addi	a4,a4,1
	sw	a4,20(sp)
	j	.L32
.L44:
	addi	a4,a4,1
	sw	a4,8(sp)
	j	.L33
.L40:
	lw	a5,8(sp)
	sw	a5,24(sp)
	lw	a5,12(sp)
	sw	a5,28(sp)
.L24:
	lw	a0,24(sp)
	lw	a1,28(sp)
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	addi	sp,sp,48
	jr	ra
	.size	Udiv64, .-Udiv64
	.ident	"GCC: (GNU) 9.2.0"
