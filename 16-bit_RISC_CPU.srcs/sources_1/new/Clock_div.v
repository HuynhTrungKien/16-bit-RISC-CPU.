`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2025 04:58:49 PM
// Design Name: 
// Module Name: Clock_div
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:57:48 11/06/2024 
// Design Name: 
// Module Name:    Clock_div 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Clock_div(clk, rst/*, clk_1hz, clk_4hz, clk_100hz*/, clk_8hz); 
input clk;
input rst;
//output reg clk_1hz ;
//output reg clk_4hz ;
output reg clk_8hz ;
//output reg clk_100hz ;
//reg [25:0]counter1Hz; 
//reg [23:0]counter4Hz; 
reg [22:0]counter8Hz;  
//reg [18:0]counter100Hz; 
wire [4:0] equal;
parameter /*div_1Hz = 49_999_999, div_4Hz = 12_249_999,*/div_8Hz = 1/*,div_100Hz = 499_999*/;
//assign equal[1] = (counter1Hz == div_1Hz)? 1'b1: 1'b0;
//assign equal[2] = (counter4Hz == div_4Hz)? 1'b1: 1'b0;
assign equal[3] = (counter8Hz == div_8Hz)? 1'b1: 1'b0;
//assign equal[4] = (counter100Hz == div_100Hz)? 1'b1: 1'b0;
initial begin
//clk_1hz = 0;
//clk_4hz = 0;
clk_8hz = 0;
//clk_100hz = 0;
//counter1Hz = 0;
//counter4Hz = 0;
counter8Hz = 0;
//counter100Hz = 0;
end
always @(posedge clk) begin
    if (rst) begin
//        counter1Hz <= 0;
//        counter4Hz <= 0;
        counter8Hz <= 0;
//        counter100Hz <= 0;
    end else begin
//        if (equal[1]) counter1Hz <= 0; else counter1Hz <= counter1Hz + 1;
//        if (equal[2]) counter4Hz <= 0; else counter4Hz <= counter4Hz + 1;
        if (equal[3]) counter8Hz <= 0; else counter8Hz <= counter8Hz + 1;
//        if (equal[4]) counter100Hz <= 0; else counter100Hz <= counter100Hz + 1;
    end
end

always @(posedge clk) begin
    if (rst) begin
//       clk_1hz <= 0; 
//       clk_4hz <= 0;  clk_100hz <= 0;
       clk_8hz <= 0;
    end else begin
//        if (equal[1]) clk_1hz <= ~clk_1hz;
//        if (equal[2]) clk_4hz <= ~clk_4hz;
        if (equal[3]) clk_8hz <= ~clk_8hz;
//        if (equal[4]) clk_100hz <= ~clk_100hz;
    end
end
endmodule
