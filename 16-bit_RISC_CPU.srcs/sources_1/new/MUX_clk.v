`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2025 04:47:25 PM
// Design Name: 
// Module Name: MUX_clk
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


module MUX_clk(input clk_1hz, clk_4hz, clk_8hz, clk_100hz, input [1:0] mux_clk, output clk_out);

assign clk_out = (mux_clk == 2'b00) ? clk_1hz : (mux_clk == 2'b01) ? clk_4hz : (mux_clk == 2'b10) ? clk_8hz : clk_100hz;

endmodule
