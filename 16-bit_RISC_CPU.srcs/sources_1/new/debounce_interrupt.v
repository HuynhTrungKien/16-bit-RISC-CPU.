`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2025 01:21:50 PM
// Design Name: 
// Module Name: debounce_interrupt
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


module debounce_interrupt( input interrupt_pending,clk, output interrupt_rise);
reg prev_interrupt_pending;
always @(negedge clk) begin
    prev_interrupt_pending <= interrupt_pending;
end

assign interrupt_rise = (~prev_interrupt_pending & interrupt_pending);

endmodule