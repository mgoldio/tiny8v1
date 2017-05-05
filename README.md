# Welcome to Tiny8v1

Tiny8v1 is a simple ISA inspired by an ECE-411 exam question at the University
of Illinois Urbana-Champaign. 

We have a simple CPU in SystemVerilog that meets the ISA specifications.

## ISA

### Overview

The Tiny8v1 ISA is "focused on ultra low-cost systems." It boasts
  * 4 general purpose registers (r0, r1, r2, r3)
  * 1 accumulator register (acc)
  * 8-bit word size
  * 8-bit address space and byte-addressability

### Operations

The ISA boasts a Turing-complete set of four operations.

#### ADS - Add Scale
```
|7      |6      |5      |4      |3      |2      |1      |0      |
|---------------------------------------------------------------|
|   0   |   0   |      Rs       |             Imm4              |
-----------------------------------------------------------------
```
```
acc <- acc + rs * imm4
```

#### BPD - Branch Positive Decrement
```
|7      |6      |5      |4      |3      |2      |1      |0      |
|---------------------------------------------------------------|
|   0   |   1   |      Rs       |            Offset             |
-----------------------------------------------------------------
```
```
if (rs > 0) {
    pc <- pc + offset
}
rs <- rs - 1
```

#### LDP - Load Shift Delta
```
|7      |6      |5      |4      |3      |2      |1      |0      |
|---------------------------------------------------------------|
|   1   |   0   |      Rs       |      Rd       |    Delta2     |
-----------------------------------------------------------------
```
```
rd <- mem[rs]
rs <- rs - delta2
```

#### STP - Store Shift Delta
```
|7      |6      |5      |4      |3      |2      |1      |0      |
|---------------------------------------------------------------|
|   1   |   1   |      Rd       |   0   |   0   |    Delta2     |
-----------------------------------------------------------------
```
```
mem[rd] <- acc
rd <- rd - delta2
```
