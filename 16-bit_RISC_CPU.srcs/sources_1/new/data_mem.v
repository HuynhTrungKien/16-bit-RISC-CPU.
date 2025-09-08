`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 04:00:13 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem (                       
    input mem_write_en, clk,
    input mem_read_en,  
    input reset,icr_sel,        
    input [15:0] addr,           
    input [15:0] write_data,  
    input [15:0] sp_addr,  // value from PC
    input push, // push from control unit
    input pop,
    output reg over_flow, under_flow,
    output [15:0] ret_addr, 
    output [15:0] read_data
);
wire [15:0] ret_addr_plus_2;
//reg [15:0] sp;
reg [15:0] sp;
//reg [7:0] memory [0:65534];  
reg [7:0] memory [0:4094];   // 4Kb
//reg [7:0] memory [0:1023];
//reg [15:0] save1_reg;
//integer f;
//integer i;
initial begin
sp = 16'hFFFE;
//$readmemb("test.data", memory);
//$display("==== Test readmemb data_mem ====");
//$display("memory[0] = %b", memory[0]);
//$display("memory[1] = %b", memory[1]);
//$display("memory[2] = %b", memory[2]);
//$display("memory[3] = %b", memory[3]);
//$display("memory[4] = %b", memory[4]);
//$display("memory[5] = %b", memory[5]);
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
    sp <= 16'h0FFE;
    over_flow <= 0;
    under_flow <=0;
    end else
    if (push || icr_sel) begin // full
       if(sp <= (16'h0FF0 + 1))
       begin
       over_flow <= 1;
       under_flow <=0;
       end
       else begin 
       memory[sp] <=  ret_addr_plus_2[7:0];
       memory[sp - 1] <=  ret_addr_plus_2[15:8];
       sp <= sp - 2;
       over_flow <= 0;
       under_flow <=0;
       end
    end
    else if (pop) begin //empty
        if(sp <= (16'h0FF0 - 1))
        begin
        over_flow <= 0;
        under_flow <=1;
        end
        else begin   
        sp <= sp + 2;
        over_flow <= 0;
        under_flow <=0;
        end
    end
    else if (mem_write_en) begin
        memory[addr] <= write_data[7:0];
        memory[addr + 1] <= write_data[15:8];
    end
end
assign ret_addr_plus_2 = sp_addr + 16'd2;
assign read_data = (mem_read_en) ? {memory[addr + 1],memory[addr]} : 16'd0;
assign ret_addr = (pop==0) ? 0 : (sp >= 16'h0FFE) ? 0 : {memory[sp + 1],memory[sp + 2]};
endmodule
