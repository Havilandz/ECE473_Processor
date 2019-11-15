.data
array:  .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

.text
.globl main
main:
 ori  $1, $0, 0xFF
 ori  $2, $0, 0x3F
 andi $2, $1, 0x14
 ori  $2, $1, 0x14
 slti $2, $1, 0x14
 slti $2, $1, 0xFFF
 addi $2, $1, 0x14
 addiu $2,$1,0x14
 lui  $1, 0xEE
 la   $3, array     # put base address of array in $3
 lw   $4, 0($3)
 lw   $5, 4($3)
 lw   $6, 8($3)
 sw   $0, 0($3)
 sw   $2, 4($3)
 sw   $3, 8($3)
 nop
 nop
 nop
 nop
 nop
 nop
