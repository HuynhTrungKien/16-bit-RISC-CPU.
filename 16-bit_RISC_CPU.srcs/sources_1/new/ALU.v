`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 03:03:58 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input signed [15:0] A,B,input [3:0]alu_sel, output reg [15:0] ALU_out, output reg zero, output reg [1:0] cmp
    );
//assign zero = () ? 1'b1: 1'b0;  // dung de so sanh 2 gia tri sau co bang hay khong, dung trong BEQZ, BNQZ
    always@(*)
        begin
            case(alu_sel)
                4'b0000:  begin
                          ALU_out = A + B;
                          cmp = 2'b00;
                          zero = 1;
                          end
                4'b0001:  begin
                          ALU_out = A - B;
                          cmp = 2'b00;
                          zero = 1;
                          end                         
                4'b0010:  begin if (A==B) // bằng
                            cmp = 2'b01;  
                            zero = 1;
                          end
                4'b0110:  begin if (A<B) // bé hơn
                            cmp = 2'b10;
                            zero = 1;
                          end 
                4'b0111:  begin if (A>B) // lớn hơn
                            cmp = 2'b11; // bằng
                            zero = 1;
                          end
                4'b0011:  begin
                          ALU_out = A & B;
                          cmp = 2'b00;
                          zero = 1;
                          end
                4'b0100:  begin
                          ALU_out = A | B;
                          cmp = 2'b00;
                          zero = 1;
                          end
                4'b0101:  begin
                          ALU_out = A ^ B;
                          cmp = 2'b00;
                          zero = 1;
                          end
                4'b1000:  begin
                          ALU_out = A << B;
                          cmp = 2'b00;
                          zero = 1;
                          end                       
                4'b1001:  begin
                          ALU_out = A >> B;
                          cmp = 2'b00;
                          zero = 1;
                          end 
                4'b1010: begin
                            if(A == B)
                            begin
                            ALU_out = 0;
                            zero = 1;
                            end
                            else begin
                            ALU_out = 0;
                            zero = 0;
                            end
                         end
                4'b1011: begin
                            if(A != B)
                            begin
                            ALU_out = 0;
                            zero = 0;
                            end
                            else begin
                            ALU_out = 0;
                            zero = 1;
                            end
                         end                    
                default: begin
                          ALU_out = A + B;
                          cmp = 2'b00;
                          zero = 1;
                          end
                endcase
        end
endmodule
