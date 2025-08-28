.data
str: .asciiz "Enter 1st Number " 
str1: .asciiz "Enter 2nd Number "
str2: .asciiz "Sum of 2 numbers is "
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


    add $t3,$t0,$t1

    la $a0, str2
    li $v0,4
    syscall 

    # load sum into $a0 for printing
    move $a0, $t3
    li $v0,1
    syscall
    



    li $v0,10
    syscall
