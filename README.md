# Customizable 16-Bit ALU in Vivado 
A customizable ALU designed for 16-bits for this project. The ALU can be changed to any specification of bit-size as per requirement. 
A highly flexible, latch-free, parameter-driven Arithmetic Logic Unit (ALU) designed in Verilog and verified using Xilinx Vivado. While configured for 16-bit operations by default, the architecture can be scaled to any bit-width via parameters.

---

## Features
* **Customizable Size:** Easily scale the data path using `parameter WIDTH `.
* **WIDTH+1 Extended Result:** Dedicated overflow and carry-out tracking for arithmetic operations.
* **Reduction Zero Flag:** Continuous assignment using reduction NOR (`~|result`) for instant zero-detection.

---

## Instruction Set Architecture (ISA)
The ALU uses a 5-bit opcode supporting 19 distinct operations (leaving 13 slots open for future changes):

| Opcode Range | Operation Categories | Supported Functions |
| :--- | :--- | :--- |
| **00000 - 00010** | Core Arithmetic | `ADD`, `SUB`, `MULT` |
| **00011 - 01000** | Logical Operations | `AND`, `OR`, `NAND`, `NOR`, `XOR`, `XNOR` |
| **01001 - 01110** | Shifts & Rotates | `SLT`, `LSL`, `LSR`, `ASR` (Signed), `ROL`, `ROR` |
| **01111 - 10010** | Utility & Carry | `INC`, `DEC`, `PASS_A`, `ADC` (Add with Carry) |

---

## Verification & Simulation
* Verified using a custom behavioral testbench (`tb_alu.v`) in **Xilinx Vivado (XSim)**.
* Tested across all 19 operational branches to validate all operations.
