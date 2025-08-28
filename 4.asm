.data
.text
main:
    li $t0,2
    li $t1,7
    sub $a0,$t1,$t0

    li $v0,10
    syscall