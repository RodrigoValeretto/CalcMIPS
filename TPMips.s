        .data
msg1:   .asciiz "\nData Type: "
msg2:   .asciiz "\nOperation: "
msg3:   .asciiz "\nResult: " 
msg4:   .asciiz "\nOverflow: "
msg5:   .asciiz "\nEnd Of Program\n"
msg6:   .asciiz "\nRepeat? Y=Yes, N=No\n"
msg7:   .asciiz "\nErro\n"
yes:    .asciiz "Y"
no:     .asciiz "N"
ql :    .asciiz "\n"
dt :    .asciiz " "
op :    .asciiz " "
ans:    .asciiz " "
tipos:  .asciiz "IFD"
ops:    .asciiz "!+-*/"
d1i:    .word   0
d1f:    .float  0000.0000
d1d:    .double 0000.0000
resi:   .word   0
resf:   .float  0000.0000
resd:   .double 0000.0000

        .text
        .globl main
main: 
        li $v0, 4
        la $a0, msg1
        syscall
        li $v0, 12
        syscall
        jal converteMaiuscula
        sb $v0, dt

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
        lb  $t0, tipos($a1)
        beq $t2, $t0, progflt
        addi $a1, 1
        lb  $t0, tipos($a1)
        beq $t2, $t0, progdbl

parte5:
resint: li $v0, 4
        la $a0, msg3
        syscall
        li $v0, 1
        lw $a0, resi
        syscall
        b parte6

resflt: li $v0, 4
        la $a0, msg3
        syscall
        li $v0, 2
        l.s $f12, resf
        syscall
        b parte6

resdbl: li $v0, 4
        la $a0, msg3
        syscall
        li $v0, 3
        l.d $f12, resd
        syscall
        b parte6

parte6:
        li $v0, 4
        la $a0, msg6
        syscall
        li $v0, 12
        syscall
        jal converteMaiuscula
        lb  $a0, yes
        beq $v0, $a0, main
        lb  $a0, no
        beq $v0, $a0, parte7
        li $v0, 4
        la $a0, msg7
        syscall
        b parte6


parte7:
        li $v0, 4
        la $a0, msg5
        syscall
        li $v0, 10
        syscall

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

progflt:
        jal leflt
        l.s $f0, d1f
        s.s $f0, resf
        li $a1, 0
        lb $t1, ops($a1)
        lb $t2, op
        beq $t1, $t2, notf
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, somaf
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, subtf
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, multf
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, divf

notf:   l.s $f0, resf
        neg.s $f0, $f0
        s.s $f0, resf
        b resflt

somaf:  l.s $f1, resf
        jal leflt
        l.s $f2, d1f
        add.s $f1, $f1, $f2
        s.s $f1, resf
        b resflt

subtf:  l.s $f1, resf
        jal leflt
        l.s $f2, d1f
        sub.s $f1, $f1, $f2
        s.s $f1, resf
        b resflt

multf:  l.s $f1, resf
        jal leflt
        l.s $f2, d1f
        mul.s $f1, $f1, $f2
        s.s $f1, resf
        b resflt

divf:   l.s $f1, resf
        jal leflt
        l.s $f2, d1f
        div.s $f1, $f1, $f2
        s.s $f1, resf
        b resflt

progdbl:
        jal ledbl
        l.d $f0, d1d
        s.d $f0, resd
        li $a1, 0
        lb $t1, ops($a1)
        lb $t2, op
        beq $t1, $t2, notd
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, somad
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, subtd
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, multd
        addi $a1, 1
        lb $t1, ops($a1)
        beq $t1, $t2, divd

notd:   l.d $f0, resd
        neg.d $f0, $f0
        s.d $f0, resd
        b resdbl

somad:  l.d $f2, resd
        jal ledbl
        l.d $f4, d1d
        add.d $f2, $f2, $f4
        s.d $f2, resd
        b resdbl

subtd:  l.d $f2, resd
        jal ledbl
        l.d $f4, d1d
        sub.d $f2, $f2, $f4
        s.d $f2, resd
        b resdbl

multd:  l.d $f2, resd
        jal ledbl
        l.d $f4, d1d
        mul.d $f2, $f2, $f4
        s.d $f2, resd
        b resdbl

divd:   l.d $f2, resd
        jal ledbl
        l.d $f4, d1d
        div.d $f2, $f2, $f4
        s.d $f2, resd
        b resdbl

converteMaiuscula:
        slti $a0, $v0, 92
        bnez $a0, retorno
        sub $v0, $v0, 32
retorno:
        jr $ra

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

leflt:  li $v0, 6
        syscall
        s.s $f0, d1f
        li $v0, 2
        l.s $f12, d1f
        syscall
        li $v0, 4
        la $a0, ql
        syscall 
        jr $ra

ledbl:  li $v0, 7
        syscall
        s.d $f0, d1d
        li $v0, 3
        l.d $f12, d1d
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

        