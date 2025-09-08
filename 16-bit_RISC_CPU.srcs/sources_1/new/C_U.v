`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2025 10:21:22 PM
// Design Name: 
// Module Name: C_U
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


module C_U( input [3:0] opcode, input[2:0] funct3,
 output reg mem_read,memtoreg, reg_wrt, is_bnez, alu_src, mem_write, pc_sel, ei_set, di_clear,
 branch, push, pop, output reg [1:0] alu_op, PCsel, output reg[2:0] immtype
    );
always @(*)
begin
 case(opcode) 
 4'b0000:  // R-type
   begin
   case(funct3)
        3'b000,3'b001,3'b011,3'b100,3'b101:
            begin 
            alu_src = 1'b0;
            reg_wrt = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            memtoreg = 1'b1;
            is_bnez = 1'b0;
            alu_op = 2'b00;
            branch = 1'b0;   
            immtype = 3'b111;
            PCsel = 2'b00;
            pop = 1'b0;
            push = 1'b0;
            pc_sel = 1'b0;
            ei_set = 1'b0;
            di_clear = 1'b0;
            end
        3'b110,3'b010,3'b111: // SLT, SGT, SETE, bring out cmp flag for further purposes
            begin
            alu_src = 1'b0;
            reg_wrt = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            memtoreg = 1'b1;
            is_bnez = 1'b0;
            alu_op = 2'b00;
            branch = 1'b0;   
            immtype = 3'b111;
            PCsel = 2'b00;
            pop = 1'b0;
            push = 1'b0;
            pc_sel = 1'b0;
            ei_set = 1'b0;
            di_clear = 1'b0;
            end
    endcase
    end
 4'b0001,4'b0010,4'b0100,4'b0101,4'b0110:  // I-type
   begin
    alu_src = 1'b1;
    reg_wrt = 1'b1;
    mem_read = 1'b0;
    mem_write = 1'b0;
    memtoreg = 1'b1;
    is_bnez = 1'b0;
    alu_op = 2'b00;
    branch = 1'b0;   
    immtype = 3'b000;
    PCsel = 2'b00;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b0;
    ei_set = 1'b0;
    di_clear = 1'b0;
   end
  4'b0011,4'b1111: // LSLR, LSRI
    begin
    alu_src = 1'b1;
    reg_wrt = 1'b1;
    mem_read = 1'b0;
    mem_write = 1'b0;
    memtoreg = 1'b1;
    is_bnez = 1'b0;
    alu_op = 2'b01;
    branch = 1'b0;   
    immtype = 3'b000;
    PCsel = 2'b00;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b0;
    ei_set = 1'b0;
    di_clear = 1'b0;
    end
  4'b0111:  // LD
   begin
    alu_src = 1'b1;
    reg_wrt = 1'b1;
    mem_read = 1'b1;
    mem_write = 1'b0;
    memtoreg = 1'b0;
    is_bnez = 1'b0;
    alu_op = 2'b00;
    branch = 1'b0;  
    immtype = 3'b000; 
    PCsel = 2'b00;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b0;
    ei_set = 1'b0;
    di_clear = 1'b0;
   end  
 4'b1000:  // LI
   begin
    alu_src = 1'b1;
    reg_wrt = 1'b1;
    mem_read = 1'b0;
    mem_write = 1'b0;
    memtoreg = 1'b1;
    is_bnez = 1'b0;
    alu_op = 2'b00;
    branch = 1'b0;  
    immtype = 3'b011; 
    PCsel = 2'b00;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b0;
    ei_set = 1'b0;
    di_clear = 1'b0;
   end
 4'b1001:  // ST
   begin
    alu_src = 1'b1;
    reg_wrt = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b1;
    memtoreg = 1'b0;
    is_bnez = 1'b0;
    alu_op = 2'b00;
    branch = 1'b0;  
    immtype = 3'b000; 
    PCsel = 2'b00;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b0;
    ei_set = 1'b0;
    di_clear = 1'b0;
   end
 4'b1010:  // BEQZ
   begin
    alu_src = 1'b0;
    reg_wrt = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    memtoreg = 1'b0;
    is_bnez = 1'b1; // BEQZ
    alu_op = 2'b01;
    branch = 1'b1;  
    immtype = 3'b011; 
    PCsel = 2'b10;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b1;
    ei_set = 1'b0;
    di_clear = 1'b0; 
   end
 4'b1011:  // BNQZ
   begin
    alu_src = 1'b0;
    reg_wrt = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    memtoreg = 1'b0;
    is_bnez = 1'b0; // BNQZ
    alu_op = 2'b01;
    branch = 1'b1;  
    immtype = 3'b011; 
    PCsel = 2'b10;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b1;
    ei_set = 1'b0;
    di_clear = 1'b0;
   end
 4'b1100:  // JMP
   begin
    alu_src = 1'b0;
    reg_wrt = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    memtoreg = 1'b0;
    is_bnez = 1'b1;
    alu_op = 2'b00;
    branch = 1'b1;  
    immtype = 3'b001; 
    PCsel = 2'b10;
    pop = 1'b0;
    push = 1'b0;
    pc_sel = 1'b1;
    ei_set = 1'b0;
    di_clear = 1'b0;
    end
4'b1101: 
    begin // CALL
        alu_src   = 1'b0;
        reg_wrt   = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        memtoreg  = 1'b0;
        is_bnez   = 1'b1;
        alu_op    = 2'b00;
        branch    = 1'b1;
        immtype   = 3'b001; 
        PCsel     = 2'b10;
        pop       = 1'b0;
        push      = 1'b1;
        pc_sel    = 1'b1;
        ei_set = 1'b0;
        di_clear = 1'b0;
        end
4'b1110: 
    begin
    case(funct3)
        3'b001:
            begin // RET
            alu_src = 1'b0;
            reg_wrt = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            memtoreg = 1'b0;
            is_bnez = 1'b0;
            alu_op = 2'b00;
            branch = 1'b1;  
            immtype = 3'b111; 
            PCsel = 2'b01;
            pop = 1'b1;
            push = 1'b0;
            pc_sel = 1'b1;
            ei_set = 1'b0;
            di_clear = 1'b0;
            end
        3'b000: begin // NOP
            alu_src = 1'b0;
            reg_wrt = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            memtoreg = 1'b0;
            is_bnez = 1'b0;
            alu_op = 2'b00;
            branch = 1'b0; 
            immtype = 3'b111; 
            PCsel = 2'b00;
            pop = 1'b0;
            push = 1'b0;
            pc_sel = 1'b0; 
            di_clear = 1'b0;
            end
        3'b010: begin // EI
            alu_src = 1'b0;
            reg_wrt = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            memtoreg = 1'b0;
            is_bnez = 1'b0;
            alu_op = 2'b00;
            branch = 1'b0; 
            immtype = 3'b111; 
            PCsel = 2'b00;
            pop = 1'b0;
            push = 1'b0;
            pc_sel = 1'b0; 
            ei_set = 1'b1;
            di_clear = 1'b0;
        end
        3'b011: begin // DI
            alu_src = 1'b0;
            reg_wrt = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            memtoreg = 1'b0;
            is_bnez = 1'b0;
            alu_op = 2'b00;
            branch = 1'b0; 
            immtype = 3'b111; 
            PCsel = 2'b00;
            pop = 1'b0;
            push = 1'b0;
            pc_sel = 1'b0; 
            ei_set = 1'b0;
            di_clear = 1'b1;
        end
    endcase
    end
endcase
end
endmodule
