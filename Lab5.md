# Lab 5: MIPS Assembly Programming Concepts

This lab covers various fundamental concepts in MIPS assembly programming, including bit manipulation, memory operations, comparison instructions, and function calls.

## Table of Contents
1. [Bit Shift Operations](#bit-shift-operations)
2. [Memory Operations and Arrays](#memory-operations-and-arrays)
3. [Stack Operations](#stack-operations)
4. [Comparison Instructions](#comparison-instructions)
5. [Function Calls and Jump Instructions](#function-calls-and-jump-instructions)
6. [Factorial Program](#factorial-program)

---

## Bit Shift Operations

### Program 21.asm - Left Shift (SLL)
```assembly
.data
.text
main:   
    li $t1,1
    sll $t0,$t1,2
    li $v0,10
    syscall 
```

**Explanation:**
- **Purpose**: Demonstrates left shift operation
- **Operation**: `sll $t0,$t1,2` performs a left shift of 2 positions
- **Result**: $t1 = 1 (binary: 0001), after left shift by 2: $t0 = 4 (binary: 0100)
- **Use Case**: Left shift by n positions is equivalent to multiplying by 2^n

### Program 22.asm - Right Shift (SRL)
```assembly
.data
.text
main:   
    li $t1,8
    srl $t0,$t1,2
    li $v0,10
    syscall 
```

**Explanation:**
- **Purpose**: Demonstrates right shift operation
- **Operation**: `srl $t0,$t1,2` performs a right shift of 2 positions
- **Result**: $t1 = 8 (binary: 1000), after right shift by 2: $t0 = 2 (binary: 0010)
- **Use Case**: Right shift by n positions is equivalent to dividing by 2^n (integer division)

---

## Memory Operations and Arrays

### Program 23.asm - Array Access
```assembly
.data
abc: .word 10, 20, 30, 40
.text
main:   
    la $t0, abc
    lw $t1,0($t0)
    lw $t2,4($t0)
    lw $t3,8($t0)
    lw $t4,12($t0)
    li $v0,10
    syscall 
```

**Explanation:**
- **Purpose**: Demonstrates array access and memory operations
- **Data Declaration**: `abc: .word 10, 20, 30, 40` creates an array of 4 words
- **Load Address**: `la $t0, abc` loads the base address of the array into $t0
- **Load Word Operations**:
  - `lw $t1,0($t0)` loads abc[0] = 10 into $t1
  - `lw $t2,4($t0)` loads abc[1] = 20 into $t2
  - `lw $t3,8($t0)` loads abc[2] = 30 into $t3
  - `lw $t4,12($t0)` loads abc[3] = 40 into $t4
- **Memory Layout**: Each word occupies 4 bytes, so elements are at offsets 0, 4, 8, 12

---

## Stack Operations

### Program 24.asm - Stack Push and Pop
```assembly
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
```

**Explanation:**
- **Purpose**: Demonstrates stack operations (push and pop)
- **Push Operation**:
  - `addi $sp,$sp,-4` decrements stack pointer by 4 bytes (allocates space)
  - `sw $t0,0($sp)` stores the value 18 at the top of the stack
- **Pop Operation**:
  - `lw $t1,0($sp)` loads the value from the top of the stack into $t1
- **Stack Convention**: In MIPS, the stack grows downward (toward lower addresses)
- **Important Note**: Using `+4` would move the stack pointer upward, violating MIPS convention and potentially overwriting data

---

## Comparison Instructions

### Program 25.asm - Set Less Than (SLT)
```assembly
.data
.text
main:   
    li $t0,18
    li $t1,20
    slt $t2,$t0,$t1
    li $v0,10
    syscall 
```

**Explanation:**
- **Purpose**: Demonstrates register-to-register comparison
- **Operation**: `slt $t2,$t0,$t1` compares $t0 and $t1
- **Result**: $t2 = 1 if $t0 < $t1, otherwise $t2 = 0
- **In this case**: 18 < 20, so $t2 = 1

### Program 26.asm - Set Less Than Immediate (SLTI)
```assembly
.data
.text
main:   
    li $t0,18
    li $t1,20
    slti $t2,$t0,21
    li $v0,10
    syscall 
```

**Explanation:**
- **Purpose**: Demonstrates register-to-immediate comparison
- **Operation**: `slti $t2,$t0,21` compares $t0 with immediate value 21
- **Result**: $t2 = 1 if $t0 < 21, otherwise $t2 = 0
- **In this case**: 18 < 21, so $t2 = 1
- **Advantage**: More efficient than loading immediate into register first

---

## Function Calls and Jump Instructions

### Program 27.asm - Jump and Link Concepts
```assembly
.data
msg: .asciiz "Factorial = "
.text

jal 
jump and link
jump,registers,immediate
move
ra is return address
in case of jump it is required
```

**Explanation:**
- **Purpose**: Notes about function call mechanisms
- **JAL (Jump and Link)**:
  - Saves the return address in register $ra
  - Jumps to the specified address
  - Essential for function calls and subroutine execution
- **Return Address**: $ra contains the address to return to after function completion
- **Usage Pattern**: 
  ```assembly
  jal function_name    # Call function
  # ... function code ...
  jr $ra              # Return to caller
  ```

---

## Factorial Program

### factorial.asm - Complete Factorial Implementation
```assembly
.data
    prompt: .asciiz "Enter a number: "
    result: .asciiz "Factorial = "
    newline: .asciiz "\n"
    
.text
main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Read integer
    li $v0, 5
    syscall
    move $a0, $v0      # Store input in $a0
    
    # Call factorial function
    jal factorial
    
    # Print result message
    li $v0, 4
    la $a0, result
    syscall
    
    # Print factorial result
    move $a0, $v1      # Move result to $a0 for printing
    li $v0, 1
    syscall
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Exit program
    li $v0, 10
    syscall

factorial:
    # Base case: if n <= 1, return 1
    li $t0, 1
    ble $a0, $t0, base_case
    
    # Recursive case: n * factorial(n-1)
    # Save registers on stack
    addi $sp, $sp, -8
    sw $ra, 4($sp)     # Save return address
    sw $a0, 0($sp)     # Save argument n
    
    # Call factorial(n-1)
    addi $a0, $a0, -1
    jal factorial
    
    # Restore registers from stack
    lw $a0, 0($sp)     # Restore original n
    lw $ra, 4($sp)     # Restore return address
    addi $sp, $sp, 8   # Restore stack pointer
    
    # Multiply n * factorial(n-1)
    mul $v1, $a0, $v1
    jr $ra             # Return to caller

base_case:
    li $v1, 1          # Return 1
    jr $ra             # Return to caller
```

**Explanation:**

**Program Structure:**
1. **Data Section**: Contains string literals for user interaction
2. **Main Function**: Handles I/O and calls factorial function
3. **Factorial Function**: Implements recursive factorial calculation

**Key Concepts Demonstrated:**

1. **Function Calls**:
   - `jal factorial` calls the factorial function
   - `jr $ra` returns to the caller
   - Return address automatically saved in $ra

2. **Stack Management**:
   - `addi $sp, $sp, -8` allocates 8 bytes on stack
   - `sw $ra, 4($sp)` saves return address
   - `sw $a0, 0($sp)` saves function argument
   - `lw` instructions restore saved values
   - `addi $sp, $sp, 8` deallocates stack space

3. **Recursive Algorithm**:
   - Base case: n ≤ 1 returns 1
   - Recursive case: n × factorial(n-1)
   - Each recursive call saves its state on the stack

4. **Register Usage**:
   - `$a0`: Function argument (input number)
   - `$v1`: Return value (factorial result)
   - `$ra`: Return address
   - `$sp`: Stack pointer

5. **System Calls**:
   - `li $v0, 4`: Print string
   - `li $v0, 5`: Read integer
   - `li $v0, 1`: Print integer
   - `li $v0, 10`: Exit program

**Example Execution:**
- Input: 5
- Process: 5 × 4 × 3 × 2 × 1 = 120
- Output: "Factorial = 120"

---

## Summary

This lab covered essential MIPS assembly programming concepts:

1. **Bit Operations**: SLL and SRL for efficient multiplication/division by powers of 2
2. **Memory Management**: Array access, stack operations, and proper memory addressing
3. **Comparison Instructions**: SLT and SLTI for conditional logic
4. **Function Calls**: JAL/JR mechanism for subroutine implementation
5. **Recursive Programming**: Complete factorial implementation with proper stack management

These concepts form the foundation for more complex assembly programming tasks and are essential for understanding computer architecture and low-level programming.
