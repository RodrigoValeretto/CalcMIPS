        .data
msg1:   .asciiz "\nData Type: "
msg2:   .asciiz "\nOperation: "
msg3:   .asciiz "\nResult: " 
msg4:   .asciiz "\nOverflow: "
msg5:   .asciiz "\nEnd Of Program\n"
ql :    .asciiz "\n"
dt :    .asciiz " "
op :    .asciiz " "
tipos:  .asciiz "IFD"
ops:    .asciiz "!+-*/"
d1i:    .word   0
resi:   .word   0
resf:   .float  0.0
resd:   .double 0.0

        .text
        .globl main
main: 
        li $v0, 4
        la $a0, msg1
        syscall
        li $v0, 12
        syscall
        jal converteMaiuscula

parte2:
        li $v0, 4
        la $a0, msg2
        syscall
        li $v0, 12
        syscall
        sb $v0, op
        li $v0, 4,
        la $a0, ql
        syscall

parte3_4:
vetipo:
        li  $a1, 0
        lb  $t0, tipos($a1)
        lb  $t1, ops($a1)
        lb  $t2, dt
        lb  $t3, op
        beq $t2, $t0, progint
        addi $a1, 1
        lb  $t1, ops($a1)
        beq $t2, $t0, progflt
        addi $a1, 1
        lb  $t1, ops($a1)
        beq $t2, $t0, progdbl

parte5:
resint: li $v0, 1
        lw $a0, resi
        syscall
        b parte7

parte7:
        li $v0, 4
        la $a0, msg5
        syscall
        li $v0, 10
        syscall

converteMaiuscula:
        slti $a0, $v0, 92
        bnez $a0, retorno
        sub $v0, $v0, 32
        sb $v0, dt
retorno:
        jr $ra

progint:
        jal leint
        lw $t0, d1i
        sw $t0, resi
        li $a1, 0
        lb $t1, ops($a1)
        lb $t2, op
        beq $t1, $t2, noti
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, somai
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, subti
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, multi
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, divi

noti:   lw $t0, resi
        neg $t0, $t0
        sw $t0, resi
        b resint

somai:  lw $t0, resi
        jal leint
        lw $t1, d1i
        add $t0, $t0, $t1
        sw $t0, resi
        b resint

subti:  lw $t0, resi
        jal leint
        lw $t1, d1i
        sub $t0, $t0, $t1
        sw $t0, resi
        b resint

multi:  lw $t0, resi
        jal leint
        lw $t1, d1i
        mul $t0, $t0, $t1
        sw $t0, resi
        b resint

divi:   lw $t0, resi
        jal leint
        lw $t1, d1i
        div $t0, $t0, $t1
        sw $t0, resi
        b resint

leint:  li $v0, 5
        syscall
        sw $v0, d1i
        li $v0, 1
        lw $a0, d1i
        syscall
        li $v0, 4
        la $a0, ql
        syscall 
        jr $ra



#leint2: li $v0, 5
#        syscall
#        sw $v0, d2i
#        li $v0, 1
#        la $a0, d2i
#        syscall
#        b ret2

        