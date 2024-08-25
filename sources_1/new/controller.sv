`timescale 1ns / 1ps

module controller
(
    input logic [5:0] opcode, funct,
    input logic zero,
    output logic RegWrite, RegDst, ALUSrc, PCSrc, MemWrite, MemtoReg, Jump,
    output logic [2:0] ALUControl
);

    logic [1:0] ALUOp;
    logic Branch;

    main_decoder main_dec_1 (opcode, RegWrite, RegDst, ALUSrc, Branch, MemWrite, Jump, MemtoReg, ALUOp);

    alu_decoder alu_dec_1 (ALUOp, funct, ALUControl);
    
    assign PCSrc = Branch & zero;


endmodule
