    .data
prompt: .asciiz "Enter a number: "
negMsg: .asciiz "Negative\n"
zeroMsg: .asciiz "Zero\n"
posMsg: .asciiz "Positive\n"

    .text
main:
    # Prompt
    la $a0, prompt
    li $v0, 4
    syscall

    # Read int
    li $v0, 5
    syscall
    move $t0, $v0

    # if x == 0
    beq $t0, $zero, print_zero

    # if x < 0
    bltz $t0, print_neg

    # else positive
    la $a0, posMsg
    li $v0, 4
    syscall
    j exit

print_neg:
    la $a0, negMsg
    li $v0, 4
    syscall
    j exit

print_zero:
    la $a0, zeroMsg
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall


