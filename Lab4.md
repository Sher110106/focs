### Lab 4: Loops in MIPS

This lab focuses on building common loop constructs in MIPS. Programs are designed to map high-level while, do-while, for, array iteration, and nested loops to labels and branches.

- 16.asm: While-style loop counting from 1..N. Uses `slt` to form the guard `i <= N` and a back-edge to the guard label. Demonstrates printing values each iteration and increment.
- 17.asm: Do-while loop that executes the body at least once. Reads an integer each iteration and repeats while input is non-zero. Shows bottom-tested loops using a branch back to the body.
- 18.asm: For-style loop with explicit init/guard/inc sections. Prints 0..9 and demonstrates a clear mapping of C-like for loops to MIPS with a single guard label.
- 19.asm: Array summation with index-based iteration. Demonstrates address arithmetic (`base + i*4`), `lw` to fetch elements, and a typical `i < len` loop guard.
- 20.asm: Nested loops for an R x C grid. Outer loop iterates rows, inner loop iterates columns, printing `* ` for each cell and newline per row.

Key learnings

- Loop guards: Use `slt`/`slti` to compute boolean-like flags and branch on zero/non-zero to implement conditions such as `i < N`, `i <= N`, or `i >= N`.
- Back-edges: Loops are built by jumping back to a guard or body label. Top-tested loops branch forward to exit; bottom-tested loops branch backward to continue.
- State updates: Maintain counters and accumulators in `$t` registers. Keep updates (`i++`, `sum += a[i]`) near the end of the loop body to mirror high-level semantics and reduce errors.
- Addressing arrays: Scale indices with `sll index, index, 2` for 32-bit words and use `addu` to compute addresses safely.
- Input/output inside loops: Group syscalls and keep `$a0` loads adjacent to prints; copy read results from `$v0` before reuse.
- Structure and clarity: Prefer early exits for invalid sizes (e.g., negative `N`) and separate guard/body/inc labels to make the control flow easy to read.

Suggested exercises

- Modify 16.asm to count down from N to 1 using a decrementing loop.
- Update 17.asm to accumulate the sum of inputs and print both count and sum at the end.
- Extend 18.asm to print only even numbers using `andi` and a conditional `continue` branch.
- Enhance 19.asm to compute both sum and maximum element in one pass.
- Adapt 20.asm to print a right triangle by making the inner loop bound depend on the current row.

Topics reinforced

- While, do-while, and for loop patterns in assembly
- Guard construction using `slt`/`slti` and relational branches
- Array indexing and pointer arithmetic
- Nested loops and structured control flow


