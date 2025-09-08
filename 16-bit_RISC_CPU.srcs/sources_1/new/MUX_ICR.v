`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2025 03:11:44 PM
// Design Name: 
// Module Name: MUX_ICR
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


module MUX_ICR( 
        input[15:0] B, icr,input src, output [15:0] out_mux
    );
    assign out_mux = (src == 0) ? B : icr;
endmodule
