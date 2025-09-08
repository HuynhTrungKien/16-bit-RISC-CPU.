`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 02:35:44 PM
// Design Name: 
// Module Name: Ins_Mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// INSTRUCTION MEMORY + DECODE

module Ins_Mem(address,opcode,rd,rs1,rs2,funct3,instruction);
input [15:0]address;
output [3:0]  opcode;
output [2:0]  rd;
output [2:0]  rs1;
output [2:0]  rs2;
output [2:0]  funct3;
wire [2:0]  instr_type;
reg [7:0] imem[0:2047];
output [15:0] instruction; 
integer i;
initial begin
//    $readmemb("test.prog", imem);
//    $display("==== Test readmemb ins_mem ====");
//    for(i=0;i<50;i=i+1)
//    begin
//        $display("imem[%0d] = %b",i, imem[i]);
//    end    
imem[0] = 8'b1110_0000;
imem[1] = 8'b0000_0010; // EI

imem[2] = 8'b1000_0110; // LI r3 <- 0x01
imem[3] = 8'b0000_0001; 

imem[4] = 8'b1011_0110; // BNQZ r3!=0 ? PC+=4
imem[5] = 8'b0000_0100; 

imem[6] = 8'b1100_1111; // JMP PC <- PC + (-4)
imem[7] = 8'b1111_1100; 

imem[8] = 8'b0011_0110; // LSLI r3 <- r3 << 1
imem[9] = 8'b1100_0001; 

imem[10] = 8'b1100_1111; // JMP PC <- PC + (-6)
imem[11] = 8'b1111_1010; 

imem[12] = 8'b1110_0000; // NOP
imem[13] = 8'b0000_0000; 

imem[100] = 8'b1000_0100;
imem[101] = 8'b0000_0101; // LI r2 <- 5

imem[102] = 8'b0001_0110;
imem[103] = 8'b0100_0000; // ADDI r1 <- r3 + 0

imem[104] = 8'b1000_1010;
imem[105] = 8'b1111_1111; // LI r5 <- 255

imem[106] = 8'b0011_1011;
imem[107] = 8'b0000_1000; // LSLI r4 <- r5 << 8

imem[108] = 8'b0000_1011;
imem[109] = 8'b0001_1100; // OR r3 <- r4 + r5

imem[110] = 8'b1110_0000;
imem[111] = 8'b0000_0000; // NOP

imem[112] = 8'b1110_0000;
imem[113] = 8'b0000_0000; // NOP

imem[114] = 8'b1110_0000;
imem[115] = 8'b0000_0000; // NOP

imem[116] = 8'b1000_0110;
imem[117] = 8'b0000_0000; // LI r3 <- 0

imem[118] = 8'b1010_0100;
imem[119] = 8'b0000_0110; // BEQZ r2==0 ? PC+=6

imem[120] = 8'b0010_0100;
imem[121] = 8'b1000_0001; // SUBI r2 <- r2 - 1

imem[122] = 8'b1100_1111;
imem[123] = 8'b1111_0010; // JMP PC <- PC + (-14)

imem[124] = 8'b0001_0010;
imem[125] = 8'b1100_0000; // ADDI r3 <- r1 + 0

imem[126] = 8'b1110_0000;
imem[127] = 8'b0000_0001; // RET

end
assign instruction = {imem[address],imem[address+1]};

assign opcode = instruction[15:12];

assign instr_type =
    (opcode == 4'b0000) ? 3'd0 : // R-type
    ((opcode >= 4'b0001 && opcode <= 4'b0111) || opcode == 4'b1111) ? 3'd1 : // I-type
    (opcode == 4'b1000) ? 3'd5 : //LI
    (opcode == 4'b1001) ? 3'd2 : // S-type
    (opcode == 4'b1010 || opcode == 4'b1011) ? 3'd3 : // B-type
    (opcode == 4'b1100 || opcode == 4'b1101) ? 3'd4 : // J-type
    (opcode == 4'b1110) ? 3'd6: // SYS-type
    3'd7;

assign rd  = (instr_type == 3'd0 ) ? instruction[5:3] :(instr_type == 3'd1 ) ? instruction[8:6]  : (instr_type == 3'd5) ? instruction[11:9] : 3'b000 ;
assign rs1 = (instr_type == 3'd0 || instr_type == 3'd1 || instr_type == 3'd2 || instr_type == 3'd3 ) ? instruction[11:9] : 3'b000;
assign rs2 = (instr_type == 3'd0 || instr_type == 3'd2) ? instruction[8:6] : 3'b000;
    
assign funct3 = (instr_type == 3'd0 || instr_type == 3'd6 ) ? instruction[2:0] : // R-type
                (opcode == 4'b0010) ? 3'b001 : (opcode == 4'b0101) ? 3'b011 : (opcode == 4'b0110) ? 3'b100 : (opcode == 4'b0100) ? 3'b101 : // I-type
                (opcode == 4'b1111) ? 3'b001 : (opcode == 4'b1010) ? 3'b010 : (opcode == 4'b1011) ? 3'b011 : // B-type
                3'b000;  
endmodule

