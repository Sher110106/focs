# Lab 2 – Detailed Explanation of Sample MIPS Assembly Programs

This document provides a thorough, line-by-line walkthrough of six short MIPS assembly programs located in the `focs` project directory.  Each program demonstrates a fundamental arithmetic operation or I/O pattern.  The explanations assume the standard MARS/SPIM syscall interface (service codes in `$v0`).  Where helpful, comments about register conventions, data movement, and CPU behaviour are included.

> **Table of Contents**
> 1. [`3.asm` – Integer Addition (constants)](#3asm)
> 2. [`4.asm` – Integer Subtraction (constants)](#4asm)
> 3. [`5.asm` – Integer Multiplication (constants + output)](#5asm)
> 4. [`6.asm` – Integer Division (constants – quotient & remainder)](#6asm)
> 5. [`7.asm` – Addition with User Input](#7asm)
> 6. [`8.asm` – Division with User Input](#8asm)

---

## `3.asm`

### Purpose
Add two hard-coded integers (2 + 4) and leave the result in `$a0` (argument register) before terminating.

### Data Section
```mips
.data           # (empty – no static data needed)
```

### Code Section
```mips
main:
    li $t0, 2          # load immediate 2 into temporary register t0
    li $t1, 4          # load immediate 4 into temporary register t1
    add $a0, $t0, $t1  # a0 = t0 + t1 (=>6). We reuse a0 for lack of printing.

    li $v0, 10         # 10 = exit service
    syscall            # terminate simulation
```

* The program **does not print** the result – it simply stores it in `$a0` then exits.  In a debugger you could inspect `$a0` (value 6).

---

## `4.asm`

### Purpose
Subtract two constants (7 − 2) and leave the result (5) in `$a0`.

### Code Walkthrough
```mips
main:
    li $t0, 2           # t0 = 2
    li $t1, 7           # t1 = 7
    sub $a0,$t1,$t0     # a0 = t1 - t0 = 5

    li $v0,10           # exit
    syscall
```

Again no output syscall is issued; the result is simply preserved in `$a0`.

---

## `5.asm`

### Purpose
Multiply two constants (2 × 7) **and print** the product.

### Data Section
```mips
.data
msg: .asciiz "Product is "
```

### Code Walkthrough
```mips
.text
main:
    li $t0, 2           # multiplicand
    li $t1, 7           # multiplier
    mul $t4, $t1, $t0   # t4 = t1 * t0 (=>14)

    # --- Display output ---
    la  $a0, msg        # load address of prompt
    li  $v0, 4          # 4 = print string
    syscall

    move $a0, $t4       # move product into a0 (print-int arg)
    li   $v0, 1         # 1 = print integer
    syscall

    # --- Terminate ---
    li $v0,10           # 10 = exit
    syscall
```

Key point: `mul rd, rs, rt` places the product in `rd` without affecting the HI/LO registers (pseudo-instruction assembled into `mult`/`mflo`).  We then print both a label string and the integer.

---

## `6.asm`

### Purpose
Divide two constants (7 ÷ 2) and leave the quotient & remainder in the special-purpose LO and HI registers respectively.  No printing is performed.

### Code Walkthrough & Remarks
```mips
.text
main:
    li  $t0, 2          # divisor
    li  $t1, 7          # dividend
    div $t1, $t0        # performs t1 / t0
                        #  -> LO = quotient (3), HI = remainder (1)

    li $v0,10           # exit
    syscall
```

* The instruction `div rs, rt` (two-operand form) stores results in **LO** (quotient) and **HI** (remainder).  Because no `mflo`/`mfhi` is executed afterwards, the program finishes silently.

---

## `7.asm`

### Purpose
Prompt the user for two integers, compute their sum, and display a labelled result.

### Data Section
```mips
.data
str:  .asciiz "Enter 1st Number "
str1: .asciiz "Enter 2nd Number "
str2: .asciiz "Sum of 2 numbers is "
```

### Interaction Flow
1. Print `str` (syscall 4), then read an integer (syscall 5) → result in `$v0`, moved to `$t0`.
2. Print `str1`, read second integer → stored in `$t1`.
3. `add $t3,$t0,$t1` – sum in `$t3`.
4. Print label string `str2`.
5. Move sum into `$a0`, invoke syscall 1 to print the integer.
6. Exit with syscall 10.

### Annotated Code Fragment
```mips
    add $t3,$t0,$t1     # compute sum

    la  $a0,str2        # print label
    li  $v0,4
    syscall

    move $a0,$t3        # load result for printing
    li   $v0,1          # print integer
    syscall
```

---

## `8.asm`

### Purpose
Prompt the user for two integers and print the **quotient** of their division (integer division).

### Data Section
```mips
.data
str:  .asciiz "Enter 1st Number "
str1: .asciiz "Enter 2nd Number "
str2: .asciiz "Division of 2 numbers is "
```

### Core Algorithm
```mips
    div $t3, $t0, $t1   # pseudo-instruction -> quotient in t3
```

Unlike the two-operand `div`, the three-operand pseudo-instruction directly stores the quotient in its destination (`$t3`), bypassing HI/LO.

### Full Execution Steps
1. Print prompt `str`, read first integer into `$t0`.
2. Print prompt `str1`, read second integer into `$t1`.
3. `div $t3,$t0,$t1` → quotient placed in `$t3` (remainder discarded).
4. Print label `str2` (syscall 4).
5. Move quotient to `$a0`, print integer (syscall 1).
6. Exit (syscall 10).

---

## General Notes & Best Practices

* Register usage here is ad-hoc for educational clarity; real MIPS programs conform to the **o32 ABI** (`$a0-$a3` for arguments, `$v0-$v1` for returns, `$t*` for temporaries, `$s*` for saved values).
* Always pair an input syscall `5` with immediate processing or transfer to a non-volatile register; `$v0` is overwritten by subsequent syscalls.
* For production-quality code, consider error checking (e.g., division by zero) and restoring registers before `jr $ra` rather than using `syscall 10`.

---

**End of Lab 2 explanation.**
