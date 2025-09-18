.data

.text
main:   
    li $t0,18
    li $t1,20
    slti $t2,$t0,21
    #if condition satifies then 1 othereise 0

    li $v0,10
    syscall 
