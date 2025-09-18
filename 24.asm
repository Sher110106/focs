.data
abc: .word 10, 20, 30, 40
.text
main:   
    li $t0,18
    addi $sp,$sp,-4
    sw $t0,0($sp)

    lw $t1,0($sp)


    li $v0,10
    syscall 
#If you did +4, you’d actually be moving $sp upward in memory, which would not follow MIPS stack convention and could overwrite other data instead of reserving safe space.