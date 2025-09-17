    .data
arr:    .word 3, 5, -2, 7, 10
len:    .word 5
sumMsg: .asciiz "Array sum: "
newline:.asciiz "\n"

    .text
main:
    la $t0, arr       # base address
    lw $t1, len       # length
    li $t2, 0         # i = 0
    li $t3, 0         # sum = 0

loop_guard:
    # if i >= len -> exit
    slt $t4, $t2, $t1
    beq $t4, $zero, done

    # load arr[i]
    sll $t5, $t2, 2   # i*4
    addu $t6, $t0, $t5
    lw  $t7, 0($t6)
    addu $t3, $t3, $t7 # sum += arr[i]

    addi $t2, $t2, 1   # i++
    j loop_guard

done:
    la $a0, sumMsg
    li $v0, 4
    syscall
    move $a0, $t3
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall
    li $v0, 10
    syscall


