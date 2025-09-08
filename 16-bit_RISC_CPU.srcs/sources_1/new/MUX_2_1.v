`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 01:29:28 PM
// Design Name: 
// Module Name: MUX_3_1
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


module MUX_2_1(
        input[15:0] B, imm,input memtoreg, output [15:0] outmux
    );
    assign outmux = (memtoreg == 1'b0) ? B : (memtoreg == 1'b1)? imm : 0;
endmodule