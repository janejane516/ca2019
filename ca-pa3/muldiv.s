#---------------------------------------------------------------
# 
#  4190.308 Computer Architecture (Fall 2019)
#
#  Project #3: RISC-V Assembly Programming
#
#  October 29, 2019
#
#  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#----------------------------------------------------------------


	.text
	.align	2

#----------------------------------------------------------------
#   int mul(int a, int b)
#----------------------------------------------------------------
    .globl  mul
mul:
	li		a2, 0
L0:
	andi	a3, a1, 1
	beq		a3, zero, L2
L1:
	add		a2, a2, a0
L2:
	slli	a0, a0, 1
	srli	a1, a1, 1
	bne		a1, zero, L0
	mv		a0, a2
	ret

#----------------------------------------------------------------
#   int mulh(int a, int b)
#----------------------------------------------------------------
    .globl  mulh
mulh:
	li		a2, 0
	li		a5, 0
	slt		a3, a0, zero
	slt		a4, a1, zero
	bge		a1, zero, L3
	neg		a0, a0
	neg		a1, a1	
L3:
	xor		a4, a3, a4
	neg		a4, a4
L4:
	andi	a3, a1, 1
	beq		a3, zero, L7
L5:	
	add		a2, a2, a0	
	bgeu	a2, a0, L6
	addi	a5, a5, 1 
L6:
	add		a5, a5, a4
L7:
	slli	a4, a4, 1
	bge		a0, zero, L8
	add		a4, a4, 1
L8:	
	slli	a0, a0, 1
	srli	a1, a1, 1
	bne		a1, zero, L4
	mv		a0, a5
	ret

#----------------------------------------------------------------
#   int div(int a, int b)
#----------------------------------------------------------------
    .globl  div
div:
	beq		a1, zero, LXX		#a0 = lower remainder
	li		a2, 0				#a2 = upper remainder
	li		a4, 0
	li		a5, 1				#a5 = sign
	bge		a0, zero, L9
	neg 	a0, a0
	neg		a5, a5
L9:
	bge		a1, zero, L10
	neg		a1, a1
	neg		a5, a5
L10:
	li		a3, 0x80000000
	sub		a2, a2, a1
	blt		a2, zero, L11
	and		a3, a3, a0
	slli	a0, a0, 1
	slli	a2, a2, 1
	addi	a0, a0, 1
	j		L12
L11:
	add		a2, a2, a1
	and		a3, a3, a0
	slli	a0, a0, 1
	slli	a2, a2, 1
L12:
	beq		a3, zero, L13
	addi	a2, a2, 1
L13:
	addi	a4, a4, 1
	li		a3, 33
	bne		a4, a3, L10
	li		a3, 1
	beq		a5, a3, L14
	neg		a0, a0
L14:
	ret
LXX:
	li		a0, -1
	ret
#----------------------------------------------------------------
#   int rem(int a, int b)
#----------------------------------------------------------------
    .globl  rem
rem:
	beq		a1, zero, LXXX		#a0 = lower remainder
	li		a2, 0				#a2 = upper remainder
	li		a4, 0
	li		a5, 1				#a5 = sign
	bge		a0, zero, L20
	neg 	a0, a0
	neg		a5, a5
L20:
	bge		a1, zero, L21
	neg		a1, a1
L21:
	li		a3, 0x80000000
	sub		a2, a2, a1
	blt		a2, zero, L22
	and		a3, a3, a0
	slli	a0, a0, 1
	slli	a2, a2, 1
	addi	a0, a0, 1
	j		L23
L22:
	add		a2, a2, a1
	and		a3, a3, a0
	slli	a0, a0, 1
	slli	a2, a2, 1
L23:
	beq		a3, zero, L24
	addi	a2, a2, 1
L24:
	addi	a4, a4, 1
	li		a3, 33
	bne		a4, a3, L21
	li		a3, 1
	srli	a2, a2, 1
	beq		a5, a3, L25
	neg		a2, a2
L25:
	mv		a0, a2
	ret
LXXX:
	ret
