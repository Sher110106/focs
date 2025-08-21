.data
buffer: .space 100
.text
main:
    la $a0,buffer
    li $a1,100
    li $v0,8
    syscall
    li $v0,4
    syscall
    li $v0,10
    syscall