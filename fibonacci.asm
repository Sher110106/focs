.data
    prompt: .asciiz "Enter n (count of Fibonacci numbers): "
    header: .asciiz "Fibonacci series: "
    space:  .asciiz " "
    newline: .asciiz "\n"

.text
main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read integer n
    li $v0, 5
    syscall
    move $t0, $v0          # n -> $t0

    # Print header
    li $v0, 4
    la $a0, header
    syscall

    # Handle n <= 0: just print newline and exit
    blez $t0, done

    # Initialize first two Fibonacci numbers: a=0, b=1
    li $t1, 0              # a = F0
    li $t2, 1              # b = F1

    # Print F0
    move $a0, $t1
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, space
    syscall

    # If n == 1, we're done printing numbers
    li $t3, 1              # countPrinted = 1
    beq $t0, $t3, end_line

    # Print F1
    move $a0, $t2
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, space
    syscall

    addi $t3, $t3, 1       # countPrinted = 2

    # Loop to print remaining numbers up to n
fib_loop:
    bge $t3, $t0, end_line

    # next = a + b
    addu $t4, $t1, $t2

    # print next
    move $a0, $t4
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, space
    syscall

    # shift a <- b, b <- next
    move $t1, $t2
    move $t2, $t4

    addi $t3, $t3, 1
    j fib_loop

end_line:
    # Print trailing newline
    li $v0, 4
    la $a0, newline
    syscall

done:
    # Exit program
    li $v0, 10
    syscall


