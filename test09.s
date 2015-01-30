
# Test to determine if $s registers used by skip are preserved.
# main puts values into each of the $s registers just before the jal
#    and checks that those values are still present after the call

# There are 7 numbers in mainNumbers, not counting the 0 at the end.

# Calls skip: four times, with starting values of 0, 1, 2, and 3.

.data

mainNumbers:
         .half    27
         .half    389
         .half    42
         .half    16381
         .half    32000
         .half    4638
         .half    287
         .half    0

mainNewline:
        .asciiz "\n"

.data
mainOrigStr:
         .asciiz "main: The numbers are:\n"

.text
main:
         # Function prologue -- even main has one
         addiu $sp, $sp, -24     # allocate stack space -- default of 24 here
         sw    $fp, 0($sp)       # save frame pointer of caller
         sw    $ra, 4($sp)       # save return address
         addiu $fp, $sp, 20      # setup frame pointer of main

         la    $a0, mainOrigStr
         addi  $v0, $zero, 4
         syscall
         
         # for (i = 0; values[i] != 0; i += 2 )
         #    print values[i]
         addi  $t0, $zero, 0     # i = $t0 = 0
         la    $t1, mainNumbers  # $t1 = addr mainNumbers[0]

mainLoopBegin:
         add   $t2, $t1, $t0     # $t2 = addr mainNumbers[i]
         lh    $a0, 0($t2)       # $a0 = mainNumbers[i]
         beq   $a0, $zero, mainLoopEnd
         addi  $v0, $zero, 1
         syscall
         
         la    $a0, mainNewline
         addi  $v0, $zero, 4
         syscall
         
         addi  $t0, $t0, 2       # i += 2
         j     mainLoopBegin
         
mainLoopEnd:
         # print a blank line
         la    $a0, mainNewline
         addi  $v0, $zero, 4
         syscall

         la    $a0, mainNumbers
         addi  $a1, $zero, 0     # skip starting with position 0

         # Putting odd values in the $s registers that are not in use
         # Done to see if skip preserves these values, if necessary.
         addi  $s0, $zero, -1111
         addi  $s1, $zero, -1111
         addi  $s2, $zero, -2222
         addi  $s3, $zero, -3333
         addi  $s4, $zero, -4444
         addi  $s5, $zero, -5555
         addi  $s6, $zero, -6666
         addi  $s7, $zero, -7777

         jal   skip

         # check if $s registers preserved by skip
         addi $t0, $zero, -1111
         bne  $t0, $s0, mainSerror1
         bne  $t0, $s1, mainSerror1
         addi $t0, $zero, -2222
         bne  $t0, $s2, mainSerror1
         addi $t0, $zero, -3333
         bne  $t0, $s3, mainSerror1
         addi $t0, $zero, -4444
         bne  $t0, $s4, mainSerror1
         addi $t0, $zero, -5555
         bne  $t0, $s5, mainSerror1
         addi $t0, $zero, -6666
         bne  $t0, $s6, mainSerror1
         addi $t0, $zero, -7777
         bne  $t0, $s7, mainSerror1
         j    mainSDone1
.data
mainErrorStr:
        .asciiz "main found problem with preserving $s register(s)\n"
.text
mainSerror1:

        addi $t0, $a0, 0
        la   $a0, mainErrorStr
        addi $v0, $zero, 4
        syscall
        addi $a0, $t0, 0

mainSDone1:
 
         la    $a0, mainNumbers
         addi  $a1, $zero, 1     # skip starting with position 1

         # Putting odd values in the $s registers that are not in use
         # Done to see if skip preserves these values, if necessary.
         addi  $s0, $zero, -1111
         addi  $s1, $zero, -1111
         addi  $s2, $zero, -2222
         addi  $s3, $zero, -3333
         addi  $s4, $zero, -4444
         addi  $s5, $zero, -5555
         addi  $s6, $zero, -6666
         addi  $s7, $zero, -7777

         jal   skip

         # check if $s registers preserved by skip
         addi $t0, $zero, -1111
         bne  $t0, $s0, mainSerror2
         bne  $t0, $s1, mainSerror2
         addi $t0, $zero, -2222
         bne  $t0, $s2, mainSerror2
         addi $t0, $zero, -3333
         bne  $t0, $s3, mainSerror2
         addi $t0, $zero, -4444
         bne  $t0, $s4, mainSerror2
         addi $t0, $zero, -5555
         bne  $t0, $s5, mainSerror2
         addi $t0, $zero, -6666
         bne  $t0, $s6, mainSerror2
         addi $t0, $zero, -7777
         bne  $t0, $s7, mainSerror2
         j    mainSDone2

mainSerror2:

         addi $t0, $a0, 0
         la   $a0, mainErrorStr
         addi $v0, $zero, 4
         syscall
         addi $a0, $t0, 0

mainSDone2:

         la    $a0, mainNumbers
         addi  $a1, $zero, 2     # skip starting with position 2

         # Putting odd values in the $s registers that are not in use
         # Done to see if skip preserves these values, if necessary.
         addi  $s0, $zero, -1111
         addi  $s1, $zero, -1111
         addi  $s2, $zero, -2222
         addi  $s3, $zero, -3333
         addi  $s4, $zero, -4444
         addi  $s5, $zero, -5555
         addi  $s6, $zero, -6666
         addi  $s7, $zero, -7777

         jal   skip

         # check if $s registers preserved by skip
         addi $t0, $zero, -1111
         bne  $t0, $s0, mainSerror3
         bne  $t0, $s1, mainSerror3
         addi $t0, $zero, -2222
         bne  $t0, $s2, mainSerror3
         addi $t0, $zero, -3333
         bne  $t0, $s3, mainSerror3
         addi $t0, $zero, -4444
         bne  $t0, $s4, mainSerror3
         addi $t0, $zero, -5555
         bne  $t0, $s5, mainSerror3
         addi $t0, $zero, -6666
         bne  $t0, $s6, mainSerror3
         addi $t0, $zero, -7777
         bne  $t0, $s7, mainSerror3
         j    mainSDone3

mainSerror3:

         addi $t0, $a0, 0
         la   $a0, mainErrorStr
         addi $v0, $zero, 4
         syscall
         addi $a0, $t0, 0

mainSDone3:
         
         la    $a0, mainNumbers
         addi  $a1, $zero, 3     # skip starting with position 3

         # Putting odd values in the $s registers that are not in use
         # Done to see if skip preserves these values, if necessary.
         addi  $s0, $zero, -1111
         addi  $s1, $zero, -1111
         addi  $s2, $zero, -2222
         addi  $s3, $zero, -3333
         addi  $s4, $zero, -4444
         addi  $s5, $zero, -5555
         addi  $s6, $zero, -6666
         addi  $s7, $zero, -7777

         jal   skip

         # check if $s registers preserved by skip
         addi $t0, $zero, -1111
         bne  $t0, $s0, mainSerror4
         bne  $t0, $s1, mainSerror4
         addi $t0, $zero, -2222
         bne  $t0, $s2, mainSerror4
         addi $t0, $zero, -3333
         bne  $t0, $s3, mainSerror4
         addi $t0, $zero, -4444
         bne  $t0, $s4, mainSerror4
         addi $t0, $zero, -5555
         bne  $t0, $s5, mainSerror4
         addi $t0, $zero, -6666
         bne  $t0, $s6, mainSerror4
         addi $t0, $zero, -7777
         bne  $t0, $s7, mainSerror4
         j    mainSDone4

mainSerror4:

         addi $t0, $a0, 0
         la   $a0, mainErrorStr
         addi $v0, $zero, 4
         syscall
         addi $a0, $t0, 0

mainSDone4:

         # Print the numbers again, to make sure the array in main
         # has not been changed.

         la    $a0, mainOrigStr
         addi  $v0, $zero, 4
         syscall
         
         # for (i = 0; values[i] != 0; i += 2 )
         #    print values[i]
         addi  $t0, $zero, 0     # i = $t0 = 0
         la    $t1, mainNumbers  # $t1 = addr mainNumbers[0]

mainLoopBeginTwo:
         add   $t2, $t1, $t0     # $t2 = addr mainNumbers[i]
         lh    $a0, 0($t2)       # $a0 = mainNumbers[i]
         beq   $a0, $zero, mainLoopEndTwo
         addi  $v0, $zero, 1
         syscall

         la    $a0, mainNewline
         addi  $v0, $zero, 4
         syscall

         addi  $t0, $t0, 2       # i += 2
         j     mainLoopBeginTwo

mainLoopEndTwo:

mainDone:
         # Epilogue for main -- restore stack & frame pointers and return
         lw    $ra, 4($sp)       # get return address from stack
         lw    $fp, 0($sp)       # restore frame pointer of caller
         addiu $sp, $sp, 24      # restore stack pointer of caller
         jr    $ra               # return to caller


.data
printArrayNewline:
         .asciiz "\n"
printArrayStrings:
         .word    printArrayStringOne
         .word    printArrayStringTwo
         .word    printArrayStringThree
         .word    printArrayStringFour

printArrayStringOne:
         .asciiz  "printArray: Starting with the first integer:\n"
printArrayStringTwo:
         .asciiz  "printArray: Starting with the second integer:\n"
printArrayStringThree:
         .asciiz  "printArray: Starting with the third integer:\n"
printArrayStringFour:
         .asciiz  "printArray: Starting with the fourth integer:\n"

.text
printArray:
         # Function prologue -- even printArray has one
         subu  $sp, $sp, 24      # allocate stack space -- default of 24
         sw    $fp, 0($sp)       # save frame pointer of caller
         sw    $ra, 4($sp)       # save return address
         sw    $a0, 8($sp)       # save addr of array[0]
         sw    $a1, 12($sp)      # save count
         sw    $a2, 16($sp)      # save which call this is
         addiu $fp, $sp, 20      # setup frame pointer for printArray

         # Print one of the four strings
         la    $a0, printArrayStrings
         sll   $t0, $a2, 2       # $a2 = index * 4
         add   $t0, $a0, $t0     # $a0 = addr of printArrayStrings[$a2]
         lw    $a0, 0($t0)
         addi  $v0, $zero, 4
         syscall

printArrayProcessArray:
         # for (i = 0; i < count; i++)
         #    print array[i]
         addi  $t0, $zero, 0     # i = 0
         lw    $t1, 8($sp)       # $t1 = original $a0 = addr of local[0]

printArrayLoopBegin:
         slt   $t2, $t0, $a1     # $t2 = i < count
         beq   $t2, $zero, printArrayLoopEnd
         sll   $t3, $t0, 1       # $t3 = i * 2, we are printing half-words
         add   $t3, $t3, $t1     # $t3 = addr of local[i]
         lh    $a0, 0($t3)       # $a0 = local[i]
         addi  $v0, $zero, 1
         syscall
         la    $a0, printArrayNewline
         addi  $v0, $zero, 4
         syscall
         addi  $t0, $t0, 1       # i++
         j     printArrayLoopBegin

printArrayLoopEnd:
         la    $a0, printArrayNewline
         addi  $v0, $zero, 4
         syscall

         # Epilogue for printArray -- restore stack/frame pointers & return
         lw    $fp, 0($sp)       # restore frame pointer of caller
         lw    $ra, 4($sp)       # get return address from stack
         lw    $a0, 8($sp)       # restore addr of array[0]
         lw    $a1, 12($sp)      # restore count
         lw    $a2, 16($sp)      # restore which call this is
         addiu $sp, $sp, 24      # restore stack pointer of caller
         jr    $ra               # return to caller

# Your code goes below this line
