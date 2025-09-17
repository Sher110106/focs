### Lab 3: Control Flow and Branching in MIPS

This lab demonstrates core branching constructs in MIPS using small, focused programs. Each program can be assembled and run in MARS/QtSPIM.

- 9.asm: Integer division with quotient and remainder; straight-line then print. Introduces data section, syscalls (print string, read int, print int), `div`, `mflo`, `mfhi` and simple sequencing.
- 10.asm: Basic conditional branch using `bge` to skip an instruction block; demonstrates labels and fallthrough control.
- 11.asm: Even/odd check using bit test and branching. Uses `andi` to inspect the least significant bit and `beq` to select the path.
- 12.asm: If/else with comparison and equality. Uses `beq` for equality, `slt` + branch to decide the larger of two inputs.
- 13.asm: While-style loop using a backward branch. Repeatedly reads integers and accumulates a sum until sentinel 0 is entered (`beq` to exit condition, back-edge `j loop`).
- 14.asm: Factorial with input validation. Shows `bltz` for negative check, early return pattern, and a countdown loop with `mul` and `bgtz` as the loop guard.
- 15.asm: Multi-way branching (negative/zero/positive) via `beq`, `bltz`, and fallthrough as the positive case.

Key learnings

- Branch basics: `beq`, `bne`, `bgtz`, `bltz`, and unsigned/bitwise techniques (e.g., `andi` for parity) select paths based on register values. Labels mark targets; `j` performs an unconditional jump.
- Comparison patterns: Use `slt`/`slti` to construct boolean-like results for relational tests, then branch on zero/non-zero to implement `if/else` without high-level operators.
- Loop construction: Implement while/for loops with a top or bottom guard plus a backward branch. Maintain loop counters or sentinel conditions; place exit checks early to avoid unnecessary work.
- Early exits and structure: Prefer early branches for invalid inputs or terminal cases to keep the “happy path” clear and reduce nesting depth.
- Syscall usage: Printing strings (4), reading ints (5), printing ints (1), exiting (10). Keep argument conventions: `$a0` for print args, results returned in `$v0`.
- Data and registers: Keep immutable strings in `.data`. Use temporary registers (`$t0`–`$t9`) for intermediates; move syscall results from `$v0` to temporaries immediately when needed later.

Suggested exercises

- Extend 11.asm to print both parity and magnitude category using nested branches.
- Modify 12.asm to also print the difference between numbers using conditional selection without additional branches.
- Change 13.asm to ignore negative inputs (branch to continue) and continue summing positives.
- Optimize 14.asm to use a multiply-accumulate loop that stops early for `n ∈ {0,1}` and detect overflow by checking HI after `mult`.
- Enhance 15.asm to include an additional category for “large” numbers (e.g., ≥ 1000) using chained branches.

How these map to topics

- Conditional execution and branching
- Comparison via `slt`/bit tests
- Looping constructs with labels and back-edges
- Input validation and early returns
- Syscalls and the calling convention for simple I/O


