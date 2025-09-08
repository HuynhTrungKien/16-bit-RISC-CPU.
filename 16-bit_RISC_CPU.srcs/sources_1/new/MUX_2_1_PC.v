`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:40:07 PM
// Design Name: 
// Module Name: MUX_2_1_PC
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


module MUX_2_1_PC(
        input[15:0] B, imm,input alu_src, output [15:0] outmux
    );
    assign outmux = (alu_src == 0) ? B : imm;
endmodule

