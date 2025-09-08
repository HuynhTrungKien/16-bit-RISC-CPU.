`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2025 09:58:40 PM
// Design Name: 
// Module Name: pc_add_2
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


module pc_add_2(  input [15:0] pc,input [1:0] imm, output [15:0] pc_out
    );
    assign pc_out = pc + imm;
endmodule
