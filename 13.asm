    .data
prompt: .asciiz "Enter number (0 to stop): "
sumMsg: .asciiz "Sum is: "
newline: .asciiz "\n"

    .text
main:
    li $t0, 0            # sum = 0

loop:
    # Prompt
    la $a0, prompt
    li $v0, 4
    syscall

    # Read int
    li $v0, 5
    syscall
    move $t1, $v0        # n

    # Break if n == 0
    beq $t1, $zero, done

    # sum += n
    addu $t0, $t0, $t1
    j loop

done:
    # Print result label
    la $a0, sumMsg
    li $v0, 4
    syscall

    # Print sum
    move $a0, $t0
    li $v0, 1
    syscall

    # Newline
    la $a0, newline
    li $v0, 4
    syscall

    # Exit
    li $v0, 10
    syscall


