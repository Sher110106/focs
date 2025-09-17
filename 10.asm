.text
main:
    li $t0, 3
    li $t1, 2
    bge $t0,$t1,abc
    addi $t2,$t1,5

    abc:
    li $v0,10
    syscall