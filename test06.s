# There are 200 values in the mainNumbers array (not counting the 0
# at the end).

# Calls skip: four times, with starting values of 0, 1, 2, and 3.

.data

mainNumbers:
         .half      536
         .half     -145
         .half    -1422
         .half      -63
         .half      646
         .half       30
         .half    -1456
         .half      160
         .half     1065
         .half    -1866
         .half      355
         .half    -1162
         .half      719
         .half     1137
         .half      -71
         .half     -246
         .half     1057
         .half     -248
         .half     1227
         .half      -38
         .half    -1520
         .half      729
         .half      409
         .half    -1843
         .half     -909
         .half     1144
         .half    -1951
         .half     1417
         .half     1642
         .half    -1581
         .half    -1585
         .half      531
         .half      626
         .half     -654
         .half    -1532
         .half     -728
         .half     1376
         .half     -636
         .half     1432
         .half      793
         .half     -501
         .half      139
         .half     1631
         .half    -1782
         .half     -724
         .half     -440
         .half      -28
         .half    -1314
         .half     1312
         .half     -448
         .half      648
         .half    -1856
         .half    -1367
         .half     -590
         .half    -1699
         .half     -276
         .half    -1094
         .half    -1298
         .half     -506
         .half    -1451
         .half     -526
         .half      261
         .half     1080
         .half    -1900
         .half     1959
         .half     1900
         .half     -275
         .half     1335
         .half     -736
         .half     -491
         .half      480
         .half     1115
         .half     1649
         .half      111
         .half     1686
         .half     -723
         .half     1671
         .half       10
         .half      -37
         .half     1336
         .half     1562
         .half    -1036
         .half     1832
         .half    -1804
         .half      726
         .half    -1514
         .half      272
         .half     1632
         .half     -812
         .half    -1882
         .half    -1819
         .half      662
         .half      732
         .half     1261
         .half     1115
         .half      691
         .half     1161
         .half    -1160
         .half      379
         .half    -1222
         .half      349
         .half    -1141
         .half    -1755
         .half      350
         .half      971
         .half     1931
         .half     1628
         .half      994
         .half      -58
         .half      -57
         .half      682
         .half     -144
         .half     1259
         .half      867
         .half      404
         .half      -15
         .half     1353
         .half     -971
         .half     -382
         .half    -1107
         .half     -853
         .half      151
         .half     1908
         .half    -1769
         .half     -587
         .half     1023
         .half      923
         .half    -1074
         .half    -1785
         .half     -346
         .half       56
         .half      916
         .half      513
         .half      302
         .half     -733
         .half     -164
         .half      233
         .half    -1105
         .half     -817
         .half    -1473
         .half     1190
         .half    -1783
         .half      384
         .half      450
         .half     1084
         .half     -860
         .half    -1565
         .half      437
         .half      169
         .half      405
         .half     1331
         .half     1669
         .half    -1443
         .half     1239
         .half     1900
         .half      322
         .half      614
         .half     1175
         .half     1248
         .half      829
         .half    -1171
         .half     -343
         .half       97
         .half     1695
         .half    -1689
         .half     1364
         .half     -117
         .half      544
         .half    -1389
         .half     1066
         .half     1424
         .half     1802
         .half     1636
         .half      160
         .half      252
         .half      720
         .half     1300
         .half     1039
         .half     -842
         .half     -530
         .half     -555
         .half    -1159
         .half     -861
         .half        2
         .half    -1568
         .half     -609
         .half    -1676
         .half     1046
         .half    -1433
         .half     1924
         .half      227
         .half     -252
         .half      -67
         .half    -1676
         .half     -205
         .half      244
         .half    -1959
         .half     1679
         .half     -859
         .half    -1348
         .half        0

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
         jal   skip
         
         la    $a0, mainNumbers
         addi  $a1, $zero, 1     # skip starting with position 1
         jal   skip

         la    $a0, mainNumbers
         addi  $a1, $zero, 2     # skip starting with position 2
         jal   skip
         
         la    $a0, mainNumbers
         addi  $a1, $zero, 3     # skip starting with position 3
         jal   skip

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
