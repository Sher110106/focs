    .data
promptN: .asciiz "Enter N: "
space:   .asciiz " "
newline: .asciiz "\n"

    .text
main:
    # Read N
    la $a0, promptN
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t0, $v0        # N

    li $t1, 1            # i = 1

while_guard:
    # if N < i -> exit (i > N)
    slt $t2, $t0, $t1
    bne $t2, $zero, done

    # print i
    move $a0, $t1
    li  $v0, 1
    syscall
    # print space
    la $a0, space
    li $v0, 4
    syscall

    addi $t1, $t1, 1     # i++
    j while_guard

done:
    la $a0, newline
    li $v0, 4
    syscall
    li $v0, 10
    syscall


