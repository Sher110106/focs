.data

.text
main:   
    li $t0,18
    li $t1,20
    slt $t2,$t0,$t1
    #if condition satifies then 1 othereise 0

    li $v0,10
    syscall 
