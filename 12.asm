    .data
p1:        .asciiz "Enter first number: "
p2:        .asciiz "Enter second number: "
eqMsg:     .asciiz "Numbers are equal\n"
largerMsg: .asciiz "Larger number: "

    .text
main:
    # Prompt first number
    la $a0, p1
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t0, $v0            # first

    # Prompt second number
    la $a0, p2
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t1, $v0            # second

    # Equality check
    beq $t0, $t1, print_equal

    # Use slt to compare; if t0 < t1, then second is larger
    slt $t2, $t0, $t1
    bne $t2, $zero, print_second

    # Otherwise first is larger
print_first:
    la $a0, largerMsg
    li $v0, 4
    syscall
    move $a0, $t0
    li $v0, 1
    syscall
    j exit

print_second:
    la $a0, largerMsg
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall
    j exit

print_equal:
    la $a0, eqMsg
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall


