`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2025 11:03:21 AM
// Design Name: 
// Module Name: branch
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


module branch(
    input zero, is_bnez, output branch_out
    );
assign branch_out = (is_bnez == 1 && zero ==1) ? 1'b1 : (is_bnez == 0 && zero ==0) ? 1'b1 : 1'b0; // BEQZ & BNQZ
endmodule