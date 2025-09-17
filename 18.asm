    .data
newline: .asciiz "\n"
space:   .asciiz " "

    .text
main:
    # for (i=0; i<10; i++) print i
    li $t0, 0        # i

for_guard:
    slti $t1, $t0, 10
    beq  $t1, $zero, done

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, space
    li $v0, 4
    syscall

    addi $t0, $t0, 1
    j for_guard

done:
    la $a0, newline
    li $v0, 4
    syscall
    li $v0, 10
    syscall


