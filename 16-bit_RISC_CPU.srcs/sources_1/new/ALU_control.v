`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 09:49:56 AM
// Design Name: 
// Module Name: ALU_control
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


module ALU_control( input [1:0] alu_op,input [2:0] funct3, output reg [3:0] ALU_control);
    wire [4:0] control_sig;
    assign control_sig = {alu_op,funct3};
    always@(*)
    begin
        case(control_sig)
        5'b00_000: ALU_control = 4'b0000; // ADD/ADDI
        5'b00_001: ALU_control = 4'b0001; // SUB/SUBI
        5'b00_010: ALU_control = 4'b0010; // SETE
        5'b00_011: ALU_control = 4'b0011; // AND/ANDI
        5'b00_100: ALU_control = 4'b0100; // OR/ORI 
        5'b00_101: ALU_control = 4'b0101; // XOR/XORI
        5'b00_110: ALU_control = 4'b0110; // SLT
        5'b00_111: ALU_control = 4'b0111; // SGT
        5'b01_000: ALU_control = 4'b1000; // LSLI
        5'b01_001: ALU_control = 4'b1001; // LSRI
        5'b01_010: ALU_control = 4'b1010; // BEQZ
        5'b01_011: ALU_control = 4'b1011; // BNQZ
        default: ALU_control = 4'b0000;
    endcase
    end
endmodule
