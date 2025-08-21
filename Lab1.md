# Lab 1 – Concise Program Descriptions

## 1.asm – “Hello World”
1. `$a0` ← address of string "Hello World".  
2. `$v0 = 4`; `syscall` → prints the string.  
3. `$v0 = 10`; `syscall` → exits.

## 2.asm – Echo Input
1. `.space 100` reserves a 100-byte buffer in the data segment.  
2. `$a0` ← buffer address, `$a1 = 100`, `$v0 = 8`; `syscall` 8 reads up to 100 chars from the console into the buffer.  
3. `$v0 = 4`; `syscall` → prints whatever was just read (the buffer address remains in `$a0`).  
4. `$v0 = 10`; `syscall` → exits.

### Register Roles and Execution Flow

**Key registers**

* `$v0` – syscall service selector / possible return value.  
  – Common services here: `4` (print string), `8` (read string), `10` (exit).
* `$a0–$a3` – argument registers.  
  – `$a0` holds a pointer in both programs.  
  – `$a1` carries the maximum length for syscall `8` in `2.asm`.

**Program flows**

`1.asm – Hello World`
1. `la $a0,str` → address of the string in `$a0`.  
2. `$v0 = 4`; `syscall` → prints the string.  
3. `$v0 = 10`; `syscall` → exits.

`2.asm – Echo Input`
1. `la $a0,buffer` → pointer to 100-byte buffer.  
2. `$a1 = 100`, `$v0 = 8`; `syscall` → reads user input into buffer.  
3. `$v0 = 4`; `syscall` → prints the buffer back (echo).  
4. `$v0 = 10`; `syscall` → exits.

**Why this order?**

1. Syscall convention: set arguments → set `$v0` → `syscall`.  
2. After reading (`syscall` 8), `$a0` already points to the buffer, so we reuse it for printing.  
3. Ending with service `10` ensures the simulator terminates cleanly.