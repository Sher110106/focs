.data
    prompt: .asciiz "Enter a number: "
    result: .asciiz "Factorial = "
    newline: .asciiz "\n"
    
.text
main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read integer
    li $v0, 5
    syscall
    move $a0, $v0      # Store input in $a0
    
    # Call factorial function
    jal factorial
    
    # Print result message
    li $v0, 4
    la $a0, result
    syscall
    
    # Print factorial result
    move $a0, $v1      # Move result to $a0 for printing
    li $v0, 1
    syscall
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit program
    li $v0, 10
    syscall

factorial:
    # Base case: if n <= 1, return 1
    li $t0, 1
    ble $a0, $t0, base_case
    
    # Recursive case: n * factorial(n-1)
    # Save registers on stack
    addi $sp, $sp, -8
    sw $ra, 4($sp)     # Save return address
    sw $a0, 0($sp)     # Save argument n
    
    # Call factorial(n-1)
    addi $a0, $a0, -1
    jal factorial
    
    # Restore registers from stack
    lw $a0, 0($sp)     # Restore original n
    lw $ra, 4($sp)     # Restore return address
    addi $sp, $sp, 8   # Restore stack pointer
    
    # Multiply n * factorial(n-1)
    mul $v1, $a0, $v1
    jr $ra             # Return to caller

base_case:
    li $v1, 1          # Return 1
    jr $ra             # Return to caller
