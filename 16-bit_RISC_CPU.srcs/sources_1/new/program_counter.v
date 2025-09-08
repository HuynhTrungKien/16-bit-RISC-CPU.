`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2025 01:05:31 PM
// Design Name: 
// Module Name: program_counter
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


module program_counter (
    input clk,
    input reset,         
    input [15:0] pc_in,   
    input icr_sel, 
    input pc_sel,   
    output reg [15:0] pc_out 
);
initial begin
    pc_out = 0;
    end   
always @(posedge clk) begin
        if (pc_sel || icr_sel)
        begin
            pc_out <= pc_in;    
        end
        else begin
            pc_out <= pc_out + 2; 
            end
    end
endmodule

