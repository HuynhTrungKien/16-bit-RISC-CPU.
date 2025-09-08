`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2025 03:03:07 PM
// Design Name: 
// Module Name: interrupt_pending
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


module interrupt_pending(
    input        clk,
    input        reset,
    input        ei_set,
    input        di_clear,
    input        interrupt_pending,
    output       icr_sel
);
reg int_enable;
    always @(posedge clk or posedge reset) begin
        if (reset)
            int_enable <= 1'b0;
        else if (ei_set)
            int_enable <= 1'b1;
        else if (di_clear)
            int_enable <= 1'b0;
    end
    assign icr_sel = int_enable && interrupt_pending;
endmodule

