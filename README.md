# 16-bit RISC CPU
---
## Abstract:
This project presents the design and implementation of a 16-bit Reduced Instruction Set Computing (RISC) processor using the Verilog Hardware Description Language (HDL). The processor architecture consists of essential components, including the Arithmetic Logic Unit (ALU), Register File, Control Unit, Interrupt Pending and Memory. The design was deployed on a Xilinx Basys 3 FPGA board to validate functionality. The proposed CPU is capable of fetching, decoding, and executing a set of 16-bit instructions. Experimental results demonstrate correct execution of arithmetic, logical, and control instructions confirming the effectiveness of the design. This work provides a practical foundation for understanding computer architecture and can be extended for educational purposes or as a baseline for more advanced processors.
## Schematic:
![CPU](https://github.com/HuynhTrungKien/16-bit-RISC-CPU./blob/master/Images/CPU.png)

## Operational Procedure:

1) IF (Instruction Fetch):  
   The Program Counter (PC) increases by 2 units from the current address because this CPU operates with 16-bit (2-byte) instructions. The updated PC is used to access the corresponding instruction from the Instruction Memory.  

2) ID (Instruction Decode):  
   The fetched instruction is decoded into several fields such as opcode, source registers, destination register, and function code (e.g., funct3). These fields are forwarded to the corresponding units for further processing.  

3) EX (Execute):  
   Based on the decoded instruction, the Control Unit generates specific control signals to drive the ALU, Branch Unit, Immediate Generator, and other functional blocks. These signals ensure that the correct operation is performed according to the instruction type.  

4) MEM (Memory Access):  
   If the instruction requires a memory operation (load/store), the Control Unit activates the necessary signals to access Data Memory.  

5) WB (Write Back):  
   In this stage, the result produced by the ALU or another functional block is written back to the destination register, if required by the instruction.  

## Instruction format:
### R-type:
| Opcode | Rs1  | Rs2  | Rd   | Funct3 |
|--------|------|------|------|--------|
| 15:12  | 11:9 | 8:6  | 5:3  | 2:0    |

| Order | Command | Opcode | Funct3 | Description           |
|-------|---------|--------|--------|-----------------------|
| 1     | ADD     | 0000   | 000    | rd ← rs1 + rs2        |
| 2     | SUB     | 0000   | 001    | rd ← rs1 – rs2        |
| 3     | AND     | 0000   | 011    | rd ← rs1 & rs2        |
| 4     | OR      | 0000   | 100    | rd ← rs1 \| rs2       |
| 5     | XOR     | 0000   | 101    | rd ← rs1 ^ rs2        |
| 6     | SLT     | 0000   | 110    | rd ← (a < b) ? 1 : 0  |
| 7     | SGT     | 0000   | 111    | rd ← (a > b) ? 1 : 0  |
| 8     | SETE    | 0000   | 010    | rd ← (a == b) ? 1 : 0 |

### I-type:
| Opcode | Rs1  | Rd  | Imm   |
|--------|------|------|------|
| 15:12  | 11:9 | 8:6  | 5:0  |

| Order | Command  | Opcode | Description          |
|-------|----------|--------|----------------------|
| 1     | ADDI     | 0001   | rd ← rs1 + imm       |
| 2     | SUBI     | 0010   | rd ← rs1 – imm       |
| 3     | ANDI     | 0101   | rd ← rs1 & imm       |
| 4     | ORI      | 0110   | rd ← rs1 \| imm      |
| 5     | XORI     | 0100   | rd ← rs1 ^ imm       |
| 6     | LSTI     | 0011   | rd ← rs1 << imm      |
| 7     | LSLI     | 1111   | rd ← rs1 >> imm      |

### L-type:
#### LD:
| Opcode | Rs1  | Rd  | Imm   |
|--------|------|------|------|
| 15:12  | 11:9 | 8:6  | 5:0  |

| Order | Command | Opcode | Description           |
|-------|---------|--------|-----------------------|
| 1     | LD      | 0111   | rd ← Mem[rs1 + imm]   |
#### LI:
| Opcode | Rd  | Imm   |
|--------|-----|-------|
| 15:12  | 11:9 | 8:0  |

| Order | Command | Opcode | Description           |
|-------|---------|--------|-----------------------|
| 1     | LI      |1000    | rd ← imm              |

### S-type:
| Opcode | Rs1  | Rs2  | Imm   |
|--------|------|------|------|
| 15:12  | 11:9 | 8:6  | 5:0  |

| Order | Command | Opcode | Description           |
|-------|---------|--------|-----------------------|
| 1     | ST      | 1001   | Mem[rs1 + imm] ← rs2  |

### B-type:
| Opcode | Rs1  | Imm   |
|--------|-----|--------|
| 15:12  | 11:9 | 8:0   |

| Order | Command | Opcode | Description           |
|-------|---------|--------|-----------------------|
| 1     | BEQZ    |1010    | if(rs1 == 0) PC += imm|
| 2     | BNQZ    |1011    | if(rs1 ≠ 0) PC += imm |

### J-type:
| Opcode | Imm   |
|--------|-------|
| 15:12  | 11:0  |

| Order | Command | Opcode | Description                |
|-------|---------|--------|----------------------------|
| 1     | JMP     |1100    | PC ← PC + imm              |
| 2     | CALL    |1101    | PC -> Mem[sp] PC = PC + imm|

### SYS-type:
| Opcode | Imm  | Fucnt3 |
|--------|------|--------|
| 15:12  | 11:3 |  2:0   |

| Order | Command | Opcode | Description           |
|-------|---------|--------|-----------------------|
| 1     | NOP     |1010    | Do nothing            |
| 2     | RET     |1011    | Return from interrupt |
| 3     | EI      |1010    | Enable interrupt      |
| 4     | DI      |1011    | Disable interrupt     |

### Example

| Index    | Value        | Comment                          |
|----------|--------------|----------------------------------|
| imem[0]  | 8'b1110_0000 |                                  |
| imem[1]  | 8'b0000_0010 | EI                               |
| imem[2]  | 8'b1000_0110 | LI r3 <- 0x01                    |
| imem[3]  | 8'b0000_0001 |                                  |
| imem[4]  | 8'b1011_0110 | BNQZ r3 != 0 ? PC += 4           |
| imem[5]  | 8'b0000_0100 |                                  |
| imem[6]  | 8'b1100_1111 | JMP PC <- PC + (-4)              |
| imem[7]  | 8'b1111_1100 |                                  |
| imem[8]  | 8'b0011_0110 | LSLI r3 <- r3 << 1               |
| imem[9]  | 8'b1100_0001 |                                  |
| imem[10] | 8'b1100_1111 | JMP PC <- PC + (-6)              |
| imem[11] | 8'b1111_1010 |                                  |
| imem[12] | 8'b1110_0000 | NOP                              |
| imem[13] | 8'b0000_0000 |                                  |
| imem[100]| 8'b1000_0100 |                                  |
| imem[101]| 8'b0000_0101 | LI r2 <- 5                       |
| imem[102]| 8'b0001_0110 |                                  |
| imem[103]| 8'b0100_0000 | ADDI r1 <- r3 + 0                |
| imem[104]| 8'b1000_1010 |                                  |
| imem[105]| 8'b1111_1111 | LI r5 <- 255                     |
| imem[106]| 8'b0011_1011 |                                  |
| imem[107]| 8'b0000_1000 | LSLI r4 <- r5 << 8               |
| imem[108]| 8'b0000_1011 |                                  |
| imem[109]| 8'b0001_1100 | OR r3 <- r4 \| r5                |
| imem[110]| 8'b1110_0000 | NOP                              |
| imem[111]| 8'b0000_0000 |                                  |
| imem[112]| 8'b1110_0000 | NOP                              |
| imem[113]| 8'b0000_0000 |                                  |
| imem[114]| 8'b1110_0000 | NOP                              |
| imem[115]| 8'b0000_0000 |                                  |
| imem[116]| 8'b1000_0110 | LI r3 <- 0                       |
| imem[117]| 8'b0000_0000 |                                  |
| imem[118]| 8'b1010_0100 | BEQZ r2 == 0 ? PC += 6           |
| imem[119]| 8'b0000_0110 |                                  |
| imem[120]| 8'b0010_0100 | SUBI r2 <- r2 - 1                |
| imem[121]| 8'b1000_0001 |                                  |
| imem[122]| 8'b1100_1111 | JMP PC <- PC + (-14)             |
| imem[123]| 8'b1111_0010 |                                  |
| imem[124]| 8'b0001_0010 |                                  |
| imem[125]| 8'b1100_0000 | ADDI r3 <- r1 + 0                |
| imem[126]| 8'b1110_0000 |                                  |
| imem[127]| 8'b0000_0001 | RET                              |

## RTL schematic:
![RTL schematic](https://github.com/HuynhTrungKien/16-bit-RISC-CPU./blob/master/Images/RTL%20schematic.jpg)

## Demo video:
https://www.youtube.com/watch?v=dWAolgAUa08

## References:

https://www.fpga4student.com/2017/04/verilog-code-for-16-bit-risc-processor.html

https://github.com/michaelriri/16-bit-risc-processor
