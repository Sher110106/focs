# Fibonacci Series (MIPS/MARS)

This example prints the first `n` Fibonacci numbers using MIPS assembly (compatible with MARS/SPIM). It matches the style used in `factorial.asm` (syscalls for I/O, `.data` for strings, `.text` for code).

## Program behavior
- Prompts: `Enter n (count of Fibonacci numbers): `
- Reads an integer `n` from stdin
- Prints: `Fibonacci series: ` followed by the first `n` numbers separated by spaces
- Handles edge cases:
  - `n <= 0`: prints just a newline
  - `n = 1`: prints `0` and newline

## How it works
The program prints the series iteratively to avoid recursion and stack usage:
- Initializes `a = 0` (`$t1`) and `b = 1` (`$t2`)
- Prints `a` and, if needed, `b`
- Repeats: `next = a + b`, print `next`, then shift `a <- b`, `b <- next`
- Stops after printing `n` numbers

## Registers used
- `$t0`: input `n`
- `$t1`: current `a`
- `$t2`: current `b`
- `$t3`: countPrinted
- `$t4`: next number (`a + b`)

## Syscalls used
- Print string: `$v0 = 4`, `$a0 = address`
- Read integer: `$v0 = 5` (result in `$v0`)
- Print integer: `$v0 = 1`, `$a0 = integer`
- Exit: `$v0 = 10`

## Source
See `fibonacci.asm`:

```1:200:/Users/sher/project/focs/fibonacci.asm
```

## Run instructions (MARS)
1. Open `fibonacci.asm` in MARS
2. Assemble (F3)
3. Run (F5)
4. Provide an integer when prompted

## Notes
- Uses `addu` for non-trapping unsigned addition; for large `n`, printed values will wrap around 32-bit integer range.
- Adjust I/O strings or formatting as desired.
