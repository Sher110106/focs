.data
str: .asciiz "Enter 1st Number " 
str1: .asciiz "Enter 2nd Number "
str2: .asciiz "Division of 2 numbers is "
newline: .asciiz "\n"
.text
main:
    la $a0,str
    li $v0,4
    syscall 
    
    li $v0,5
    syscall

    move $t0,$v0

    la $a0,str1
    li $v0,4
    syscall 
    
    li $v0,5
    syscall

    move $t1,$v0

    div $t0,$t1
    # Store quotient in $t2
    mflo $t2
    # Store remainder in $t3
    mfhi $t3

    la $a0, str2
    li $v0,4
    syscall 

    # Print quotient
    move $a0, $t2
    li $v0,1
    syscall

    # Print newline
    la $a0, newline
    li $v0,4
    syscall

    #Print remainder (optional, if you want to show it)
    move $a0, $t3
    li $v0,1
    syscall

    li $v0,10
    syscall