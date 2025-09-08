`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 09:14:46 PM
// Design Name: 
// Module Name: MUX_3_1_RET
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


module MUX_3_1_RET(
        input[15:0] A, B,input [1:0] PC_sel,input [15:0] C, output [15:0] outmux
    );
    assign outmux = (PC_sel == 2'b00) ? A : (PC_sel == 2'b01)? B : (PC_sel == 2'b10) ? C : A;
endmodule
