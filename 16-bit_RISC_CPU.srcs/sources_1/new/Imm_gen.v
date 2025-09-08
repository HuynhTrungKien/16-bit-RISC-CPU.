`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 11:57:57 AM
// Design Name: 
// Module Name: Imm_gen
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


module Imm_gen( input [15:0] instruction, input [2:0] imm_type, output [15:0] imm_out );
    assign imm_out = (imm_type ==3'b000)? 
    {{10{instruction[5]}},instruction[5:0]}: //I-type
    (imm_type ==3'b001)?
    {{4{instruction[11]}},instruction[11:0]}: //J-type
    (imm_type ==3'b011)?
    {7'b0,instruction[8:0]}:  //LI
    (instruction[5:0]);
endmodule
