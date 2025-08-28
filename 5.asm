.data
msg: .asciiz "Product is "
.text
main:
    li $t0,2
    li $t1,7
    mul $t4,$t1,$t0

    # print the prompt
    la $a0,msg
    li $v0,4
    syscall

    # print the product
    move $a0,$t4
    li $v0,1
    syscall

    li $v0,10
    syscall