    .data
promptR: .asciiz "Rows: "
promptC: .asciiz "Cols: "
cell:    .asciiz "* "
newline: .asciiz "\n"

    .text
main:
    # read rows
    la $a0, promptR
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t0, $v0   # rows

    # read cols
    la $a0, promptC
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $t1, $v0   # cols

    li $t2, 0       # r = 0

row_guard:
    slt $t3, $t2, $t0
    beq $t3, $zero, done

    li $t4, 0       # c = 0

col_guard:
    slt $t5, $t4, $t1
    beq $t5, $zero, end_row

    la $a0, cell
    li $v0, 4
    syscall

    addi $t4, $t4, 1
    j col_guard

end_row:
    la $a0, newline
    li $v0, 4
    syscall
    addi $t2, $t2, 1
    j row_guard

done:
    li $v0, 10
    syscall


