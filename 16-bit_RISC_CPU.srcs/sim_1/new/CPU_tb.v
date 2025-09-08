`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2025 04:28:10 PM
// Design Name: 
// Module Name: CPU_testbench
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


module CPU_tb();
  reg reset;
  reg clk;
  reg [1:0] mux_clk;
  reg interrupt_pending;
  wire [15:0] r3;

  TOP uut (
    .clk(clk),
    .reset(reset),
    .mux_clk(mux_clk),
    .interrupt_pending(interrupt_pending),
    .r3(r3)
  );
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
reset = 1;
interrupt_pending = 0;
mux_clk = 2'b10;
#3;
reset = 0;
#69967;
interrupt_pending = 1;
#15;
interrupt_pending = 0;
end
endmodule

