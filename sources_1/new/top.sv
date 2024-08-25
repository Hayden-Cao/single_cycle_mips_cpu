`timescale 1ns / 1ps


module top
(
    input logic clk, reset,
    output logic [31:0] writedata, dataadr,
    output logic memwrite
);

logic [31:0] pc, instr, readdata;
// instantiate processor and memories
mips mips(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);
instr_mem imem(pc[7:2], instr);
data_mem dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule