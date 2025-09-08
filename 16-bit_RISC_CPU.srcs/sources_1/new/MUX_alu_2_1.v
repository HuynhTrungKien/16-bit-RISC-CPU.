`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 10:41:35 AM
// Design Name: 
// Module Name: MUX_alu_2_1
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


module MUX_alu_2_1(
        input[15:0] B, imm,input alu_src, output [15:0] outmux
    );
    assign outmux = (alu_src == 0) ? B : imm;
endmodule
