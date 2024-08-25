`timescale 1ns / 1ps

module main_decoder
(
    input [5:0] opcode,
    output logic RegWrite, RegDst, ALUSrc, Branch, MemWrite, Jump, MemtoReg,
    output logic [1:0] ALUOp
);
    
    logic [8:0] control_signals;

    assign {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Jump, ALUOp} = control_signals;

    always_comb
        case (opcode)
            6'b000000: control_signals <= 9'b110000010;  // R-Type
            6'b100011: control_signals <= 9'b101001000;  // LW
            6'b101011: control_signals <= 9'b001010000;  // SW
            6'b000100: control_signals <= 9'b000100001;  // BEQ
            6'b001000: control_signals <= 9'b101000000;  // ADDI
            6'b000010: control_signals <= 9'b000000100;  // J
            default:   control_signals <= 9'bxxxxxxxxx;  // illegal op
        endcase

endmodule
