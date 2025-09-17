    .data
prompt: .asciiz "Enter a number: "
evenMsg: .asciiz "Number is even\n"
oddMsg:  .asciiz "Number is odd\n"

    .text
main:
    # Prompt
    la $a0, prompt
    li $v0, 4
    syscall

    # Read integer
    li $v0, 5
    syscall
    move $t0, $v0

    # Check LSB to determine even/odd
    andi $t1, $t0, 1
    beq $t1, $zero, print_even

print_odd:
    la $a0, oddMsg
    li $v0, 4
    syscall
    j exit

print_even:
    la $a0, evenMsg
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall

