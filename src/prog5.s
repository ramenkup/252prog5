# Your code goes below this line

.data

skipHalf:	.asciiz	"skip: There are "
skipSecond:	.asciiz	" numbers in the array."
ownNewLine: .asciiz "\n"

.text
skip:
addiu	$sp,	$sp,	-24		#WHY AGAIN?
sw		$fp,	0($sp)
sw		$ra,	4($sp)
addiu	$fp,	$sp,	24
sw		$a0,	8($sp)			#$a0 array of half word intigers
sw		$a1,	12($sp)
sub		$sp,	$sp,	32		#SHOULD THIS BE NEGATIVE?
sw		$s0,	0($sp)
sw		$s1,	4($sp)
sw		$s2,	8($sp)
sw		$s3,	12($sp)
sw		$s4,	16($sp)
sw		$s5,	20($sp)
sw		$s6,	24($sp)
sw		$s7,	28($sp)

addi	$t0,	$zero,	0		#int count=0
addi	$s0,	$a0,	0


skipLoop:
add		$t2, 	$t0, 	$s0
lh		$t2,	0($t2)
beq		$t2,	$zero,	skipLoopJump
addi	$t0,	$t0,	2	#WHY AD TWO INSTEAD OF ONE -> BITWIZE?
j skipLoop

skipLoopJump:
la		$a0,	skipHalf
addi	$v0,	$zero,	4
syscall
srl		$t4,	$t0,	1
addi	$a0,	$t4,	0
addi	$v0,	$zero,	1
syscall
la		$a0,	skipSecond
addi	$v0,	$zero,	4
syscall
la		$a0,	ownNewLine
syscall
syscall
		
addi 	$t2, 	$zero,	4		#T2 REASSIGNED HERE
div		$t0,	$t2			#COUNT DIVIDED BY 4 STORED IN LO AND HI
mfhi	$t7
mflo 	$t3
div		$t3,	$t2
mfhi	$t7
add		$t3,	$t3,	$t2
sub		$t3,	$t3,	$t7

foundZero:
sub		$sp,	$sp,	$t3
addi	$t1,	$zero,	0	#index of temp array
add		$t2,	$a1,	$a1

startFinder:
slt		$t4,	$t2,	$t0	#check current offset < array bit size
beq		$t4,	$zero,	outBounds
add		$t4,	$s0,	$t2
lh		$t5,	0($t4)
add		$t6,	$t1,	$sp
sh		$t5,	0($t6)	
addi	$t1,	$t1,	2	#number of bits in temp array
addi	$t2,	$t2,	8
j 		startFinder




outBounds:
#set a registry argument values for print caller
addi	$t6,	$sp,	0
addi	$sp,	$sp,	-24
sw		$t0,	0($sp)
sw		$t1,	4($sp)
sw		$t2,	8($sp)	
sw		$t3,	12($sp)	
sw		$t4,	16($sp)	
sw		$t5,	20($sp)	
addi	$a0,	$t6,	0
addi	$a2,	$a1,	0
sra		$a1,	$t1,	1
jal		printArray			#jl link means 
lw		$t0,	0($sp)
lw		$t1,	4($sp)
lw		$t2,	8($sp)	
lw		$t3,	12($sp)	
lw		$t4,	16($sp)	
lw		$t5,	20($sp)
addi	$sp,	$sp,	24
add		$sp,	$sp,	$t3
lw		$s0,	0($sp)
lw		$s1,	4($sp)
lw		$s2,	8($sp)
lw		$s3,	12($sp)
lw		$s4,	16($sp)
lw		$s5,	20($sp)
lw		$s6,	24($sp)
lw		$s7,	28($sp)	
addi	$sp,	$sp,	32
lw		$fp,	0($sp)
lw		$ra, 	4($sp)
addi	$sp,	$sp,	24
jr		$ra





