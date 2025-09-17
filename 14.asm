    .data
prompt: .asciiz "Enter a non-negative integer: "
factMsg: .asciiz "Factorial: "
errMsg: .asciiz "Factorial not defined for negative numbers\n"

    .text
main:
    # Prompt
    la $a0, prompt
    li $v0, 4
    syscall

    # Read int
    li $v0, 5
    syscall
    move $t0, $v0            # n

    # If n < 0 -> error
    bltz $t0, print_error

    # Handle 0 and 1 quickly
    li $t1, 1                # result = 1
    beq $t0, $zero, print_result

    # i = n
    move $t2, $t0

loop:
    mul $t1, $t1, $t2        # result *= i
    addi $t2, $t2, -1        # i--
    bgtz $t2, loop           # continue while i > 0

print_result:
    la $a0, factMsg
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall
    j exit

print_error:
    la $a0, errMsg
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall


