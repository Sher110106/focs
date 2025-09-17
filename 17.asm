    .data
prompt: .asciiz "Enter number (0 to stop): "
countMsg: .asciiz "Iterations: "
newline: .asciiz "\n"

    .text
main:
    li $t0, 0        # count = 0

do_body:
    # prompt
    la $a0, prompt
    li $v0, 4
    syscall
    # read
    li $v0, 5
    syscall
    move $t1, $v0

    addi $t0, $t0, 1  # count++ (body executed at least once)

    # while (n != 0)
    bne $t1, $zero, do_body

    # print count
    la $a0, countMsg
    li $v0, 4
    syscall
    move $a0, $t0
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10
    syscall


