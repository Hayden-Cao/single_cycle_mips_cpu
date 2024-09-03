`timescale 1ns / 1ps


module top
(
    input logic clk, reset, clk_enable_sw,
    input logic [1:0] data_select,
    output logic clk_1hz, memwrite,
    output logic [7:0] seven_seg_enb,
    output logic [6:0] seven_seg_out
);

logic [26:0] clock_divisor = 0;
localparam clock_divider_count = 100_000_000;


clk_1hz clk_1hz_gen(clk, clk_enable_sw, clk_1hz);

logic [31:0] writedata, dataadr;


logic [31:0] pc, instr, readdata;
// instantiate processor and memories
mips mips(clk_1hz, reset, pc, instr, memwrite, dataadr, writedata, readdata);
instr_mem imem(pc[7:2], instr);
data_mem dmem(clk_1hz, memwrite, dataadr, writedata, readdata);


logic[31:0] data_to_display;

always_comb
begin
    case(data_select)
        
        2'b00: data_to_display = instr;
        2'b01: data_to_display = writedata;
        2'b11: data_to_display = dataadr;
        default: data_to_display = instr;
    endcase
end

seven_seg_selector sss(clk, reset, 1'b1, data_to_display, seven_seg_enb, seven_seg_out);


endmodule