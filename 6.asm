.data
.text
main:
    li $t0,2
    li $t1,7
    div $t1,$t0

    li $v0,10
    syscall

#lower 32 bits stored in low and higher 32 bits stored in 32 and no destination address is required
#The remainder is stored in high and the quotient is in low
#Division program with user inputs