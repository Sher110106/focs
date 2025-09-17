### MIPS Assembly Guide: Syntax, Patterns, and Exam Mastery

This guide distills everything you need to write, read, debug, and ace exams in MIPS assembly using MARS/QtSPIM. It references working examples from your repo (`1.asm`–`20.asm`) and generalizes them into reusable patterns.

## Core Concepts

- Architecture: 32-bit MIPS, big-endian (sim tools may abstract this). Fixed-length 32-bit instructions. Load/store architecture: arithmetic works on registers, not memory.
- Registers: 32 general-purpose integer registers plus special HI/LO.
  - `$zero` always 0; `$at` assembler temp; `$v0-$v1` return values/syscall codes.
  - `$a0-$a3` arguments to functions and syscalls.
  - `$t0-$t9` temporaries (not preserved across calls).
  - `$s0-$s7` saved registers (callee must preserve).
  - `$gp`, `$sp` (stack pointer), `$fp` (frame), `$ra` (return address).
  - HI/LO hold results for `mult/div` (`mfhi`, `mflo`).
- Endianness and word size: words are 4 bytes. Align data accordingly.

## File Structure and Directives

- `.data`: static data section for strings, arrays, constants.
- `.text`: code section. `main:` is just a label where execution typically starts in simulators.
- Common data directives:
  - `.asciiz "text"` null-terminated string
  - `.word 1, 2, 3` 32-bit integers
  - `.space N` uninitialized bytes
  - `.byte`, `.half` for 8/16-bit data
- Labels end with `:` and bind to the current location in code or data.

## Syscalls and I/O (MARS/QtSPIM)

- Set `$v0` to the syscall code, place arguments in `$a0`..`$a3`, then `syscall`.
- Common codes:
  - `1` print int (`$a0` value)
  - `4` print string (`$a0` address)
  - `5` read int (result in `$v0`)
  - `8` read string (`$a0` buffer addr, `$a1` length)
  - `10` exit
- Patterns:
  - Prompt→Read→Compute→Print→Exit, as in `7.asm`, `8.asm`, `9.asm`.
  - Always copy inputs from `$v0` to a temp (`move $t0, $v0`) before another syscall.

## Instruction Categories (with examples)

- Data movement: `la` (load address), `lw`/`sw` (load/store word), `li` (load imm), `move` (register copy).
- Arithmetic: `add`, `addu`, `addi` (with immediate), `sub`, `mul` (pseudo), `mult`/`multu` then `mflo`/`mfhi`.
- Division: `div rs, rt` puts quotient in LO, remainder in HI; `mflo`, `mfhi` to read. See `9.asm`.
- Logic/bitwise: `and`, `andi`, `or`, `ori`, `xor`, `sll`, `srl`, `sra`.
- Comparisons: `slt`, `slti` set 1 if less-than, else 0. Combine with `beq`/`bne` for branching. See `12.asm`, `16.asm`.
- Branch/jump: `beq`, `bne`, `bgtz`, `bltz`, `blez`, `bgez`, `j`, `jr`, `jal`.

## Control Flow Patterns

- If/Else (`12.asm`):
  - Compute relation with `slt` or compare directly; branch to chosen label; use `j` to skip alternate block.
- Multi-way branching (`15.asm`):
  - Order checks from most specific to general; use fallthrough for the final case.
- Loops (`16.asm`–`20.asm`):
  - While: guard label computes condition, branch to exit, body, back-edge to guard.
  - Do-while: body first, then branch back if condition holds.
  - For: explicit init, guard, body, increment, and jump to guard.
  - Nested: inner guard/body inside outer loop with separate counters.

## Arrays, Addressing, and Strings

- Address arithmetic: `base + index*4` for word arrays using `sll index, index, 2` and `addu` to get the address. See `19.asm`.
- Load/store: `lw rt, offset(rs)` and `sw rt, offset(rs)` read/write words.
- Strings: store with `.asciiz`, print with syscall 4. For input, allocate buffer with `.space`, then syscall 8 (see `2.asm`).

## HI/LO and Multiply/Divide Details

- Prefer using `mul rd, rs, rt` in MARS for clarity; it expands to `mult`/`mflo` as needed. For portability, use `mult` then `mflo` explicitly when required and consider checking HI for overflow-sensitive tasks.
- Division: `div rs, rt` then `mflo` for quotient and `mfhi` for remainder (see `9.asm`). Guard against division by zero.

## Procedures, Stack, and Calling Convention (Quick Primer)

- Caller places args in `$a0-$a3`. Callee may use `$t*` freely; must preserve `$s*`, `$sp`, `$ra` if modified.
- Stack grows downward. Typical function prologue/epilogue:
  - Prologue: `addiu $sp, $sp, -frameSize`; save `$ra`, `$s*` as needed.
  - Epilogue: restore saved regs; `addiu $sp, $sp, frameSize`; `jr $ra`.
- Return values in `$v0`/`$v1`.

## Common Exam-Ready Patterns (from your files)

- Print Hello World (`1.asm`): basic I/O and exit.
- Read and echo string (`2.asm`): buffer management and syscall 8.
- Basic arithmetic (`3.asm`, `4.asm`, `5.asm`, `6.asm`): register ops; multiplication/division nuances.
- Read two ints and compute sum/division (`7.asm`, `8.asm`): end-to-end input→compute→output.
- Division with quotient and remainder (`9.asm`): `div`, `mflo`, `mfhi` and multi-value output.
- Branching basics and guards (`10.asm`, `11.asm`, `12.asm`, `15.asm`): conditional control including parity and comparisons.
- Loop patterns and arrays (`13.asm`, `16.asm`–`20.asm`): sentinel loops, counters, nested loops, and array summation.

## Syntax Reference (Most-Used Instructions)

- Load/Store: `lw rt, imm(rs)`, `sw rt, imm(rs)`, `lb`, `sb`, `la rd, label`, `li rd, imm`.
- Move: `move rd, rs`.
- Arithmetic: `add rd, rs, rt`, `addu`, `addi rt, rs, imm`, `sub`, `mul rd, rs, rt`.
- Logic: `and`, `andi`, `or`, `ori`, `xor`, `nor`.
- Shifts: `sll rd, rt, shamt`, `srl`, `sra`.
- Compare/Branch: `slt rd, rs, rt`, `slti rt, rs, imm`, `beq rs, rt, label`, `bne`, `bgtz rs, label`, `bltz`, `blez`, `bgez`.
- Jumps: `j label`, `jr rs`, `jal label` (store return in `$ra`).
- Multiply/Divide: `mult rs, rt`, `multu`, `div rs, rt`, `mflo rd`, `mfhi rd`.
- Syscall: set `$v0`, args in `$a*`, `syscall`.

## Robustness and Edge Cases

- Check for division by zero before `div`.
- Validate loop bounds (e.g., non-negative `N`, `rows`, `cols`).
- For input routines, consider buffer sizes and newline handling.
- For arithmetic that can overflow, prefer `addu`/`subu` and check HI/LO when using `mult`.

## Debugging Workflow (MARS/QtSPIM)

- Step/run with breakpoints at key labels (loop guards, branches).
- Inspect registers (`$t*`, `$s*`, `$a*`, `$v*`, HI/LO) and memory.
- Add trace prints: use syscall 4 for labels like "i=", paired with int prints.
- Verify branch direction by printing inside each branch once.
- For arrays, print computed addresses and values to confirm indexing math.

## Performance and Readability

- Prefer clear labels (`loop_guard`, `done`, `print_result`) and short basic blocks.
- Keep the loop guard close to the branch for locality.
- Minimize redundant loads/stores; keep hot values in registers.
- Use early exits to reduce nesting.

## Exam Strategy and Checklist

- Read the problem and translate into a register plan:
  - Which registers hold inputs, counters, accumulators?
  - What are the loop guards and exit conditions?
  - What syscalls are needed and in what order?
- Sketch labels: `setup`, `guard`, `body`, `inc`, `done` before coding.
- Implement incrementally: compile/run after each section (I/O, guard, body) if allowed.
- Always move read values from `$v0` before another syscall.
- Print intermediate values if stuck; verify guard correctness with small test cases.
- Include edge cases: 0, 1, negative numbers, empty arrays.
- Use `slt`/`slti` to form booleans, then branch on zero/non-zero; avoid complex expressions.
- For divide/multiply, know when to use `mflo`/`mfhi` vs `mul` pseudo.
- Comment briefly the role of each register at the top (e.g., `$t0=N`, `$t1=i`, `$t2=temp`).
- End with a clean `exit` label and syscall 10.

## Quick Patterns (Copy/Paste Starters)

While loop 1..N:
```asm
li $t1, 1          # i
while_guard:
  slt $t2, $t0, $t1  # N < i ?
  bne $t2, $zero, done
  # body
  addi $t1, $t1, 1
  j while_guard
done:
```

Do-while (read until 0):
```asm
do_body:
  li $v0, 5
  syscall
  move $t0, $v0
  bne $t0, $zero, do_body
```

For (0..9):
```asm
li $t0, 0
for_guard:
  slti $t1, $t0, 10
  beq  $t1, $zero, done
  # body
  addi $t0, $t0, 1
  j for_guard
done:
```

Compare and pick max:
```asm
slt $t2, $t0, $t1    # t2=1 if a<b
bne $t2, $zero, use_b
move $t3, $t0
j after
use_b:
move $t3, $t1
after:
```

Array sum:
```asm
la $t0, arr
li $t2, 0           # i
li $t3, 0           # sum
loop:
  slt $t4, $t2, $t1 # i < len
  beq $t4, $zero, done
  sll $t5, $t2, 2
  addu $t6, $t0, $t5
  lw  $t7, 0($t6)
  addu $t3, $t3, $t7
  addi $t2, $t2, 1
  j loop
done:
```

With these patterns, a clear register plan, and disciplined branching, you should be able to implement most exam problems quickly and correctly.
