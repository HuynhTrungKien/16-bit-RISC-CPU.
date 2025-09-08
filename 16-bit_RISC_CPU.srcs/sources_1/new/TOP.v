`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 11:07:04 AM
// Design Name: 
// Module Name: TOP
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

module TOP( input  clk,reset,interrupt_pending,
output [15:0] r3, 
input [1:0] mux_clk
    );
localparam ICR_fix_add = 100;
localparam CONST = 2;
wire   is_bnez, mem_read_en, branch_out;
wire /*clk_1hz ,clk_4hz,clk_100hz,*/ clk_8hz;
wire reg_wrt, mem_write_en, push, pop, pc_sel, alu_src;
wire zero, mux_pc_sel, branch, ei_set, di_clear, memtoreg;
wire [1:0] alu_op, PCsel;
wire [2:0] rs1, rs2, rd, funct3, immtype;
wire [3:0] opcode, alu_sel;
wire [15:0] in_mux, instruction;
wire [15:0] pc_in, muxicr_in;
wire [15:0] ALU_out, imm_out, outmux, read_data;
wire [15:0] data_reg, readA_out, readB_out;
wire [15:0] pc_out, pc_mux,ret_addr,address;
wire interrupt_rise;


Ins_Mem ic1 (.address(address),.opcode(opcode),.rd(rd),.rs1(rs1),.rs2(rs2),.funct3(funct3),.instruction(instruction));

reg_file ic2 (.reg_wrt(reg_wrt),.rs1(rs1),.rs2(rs2),.rd(rd),.readA_out(readA_out),.readB_out(readB_out),.data(data_reg),.r3(r3),.clk(clk_out));

MUX_alu_2_1 ic3 (.B(readB_out),.imm(imm_out),.alu_src(alu_src),.outmux(outmux));

ALU ic4 (.A(readA_out),.B(outmux),.alu_sel(alu_sel),.ALU_out(ALU_out),.zero(zero));

ALU_control ic5 (.funct3(funct3),.alu_op(alu_op),.ALU_control(alu_sel));

Imm_gen ic6 (.instruction(instruction),.imm_type(immtype),.imm_out(imm_out));

data_mem ic7 (.mem_write_en(mem_write_en),.sp_addr(address),.push(push),.pop(pop),.ret_addr(ret_addr)
,.clk(clk_out),.mem_read_en(mem_read_en),.addr(ALU_out),.write_data(readB_out),.read_data(read_data),.reset(reset),.icr_sel(icr_sel));

MUX_2_1 ic8 (.B(read_data),.imm(ALU_out),.memtoreg(memtoreg),.outmux(data_reg));

add_pc ic9 (.pc(address),.imm(imm_out),.pc_out(pc_out));

pc_add_2 ic10 (.pc(address),.imm(CONST),.pc_out(in_mux));

program_counter ic11 (.clk(clk_out),.reset(reset),.pc_in(pc_in),.pc_out(address),.pc_sel(pc_sel),.icr_sel(icr_sel));

MUX_2_1_PC ic12 (.B(in_mux),.imm(pc_out),.alu_src(branch & branch_out),.outmux(pc_mux));

branch ic14 (.zero(zero),.is_bnez(is_bnez),.branch_out(branch_out));

MUX_3_1_RET ic16 (.A(in_mux),.B(ret_addr),.C(pc_mux),.PC_sel(PCsel),.outmux(muxicr_in));

C_U ic17 (.opcode(opcode),.funct3(funct3),.mem_read(mem_read_en),.reg_wrt(reg_wrt),.is_bnez(is_bnez),.alu_src(alu_src),.pc_sel(pc_sel),.
mem_write(mem_write_en),.branch(branch),.push(push),.pop(pop),.alu_op(alu_op),.memtoreg(memtoreg),.PCsel(PCsel),.immtype(immtype),.ei_set(ei_set),.di_clear(di_clear));

Clock_div ic18 (.clk(clk),.rst(reset)/*,.clk_1hz(clk_1hz),.clk_4hz(clk_4hz)*/,.clk_8hz(clk_8hz)/*,.clk_100hz(clk_100hz)*/);

MUX_clk ic19 (/*.clk_1hz(clk_1hz),.clk_4hz(clk_4hz),*/.clk_8hz(clk_8hz)/*,.clk_100hz(clk_100hz)*/,.mux_clk(mux_clk),.clk_out(clk_out));

interrupt_pending ic20 (.clk(clk_out),.reset(reset),.ei_set(ei_set),.di_clear(di_clear),.interrupt_pending(interrupt_rise),.icr_sel(icr_sel));

MUX_ICR ic21 (.B(muxicr_in),.icr(ICR_fix_add),.src(icr_sel),.out_mux(pc_in));

debounce_interrupt ic22 (.clk(clk_out),.interrupt_pending(interrupt_pending),.interrupt_rise(interrupt_rise));

endmodule