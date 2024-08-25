`timescale 1ns / 1ps

module alu
(
    input logic [31:0] A, B,
    input logic [2:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic zero
);

    always_comb 
    begin
        
        case(ALUControl)

            3'b000: ALUResult = A & B;
            3'b001: ALUResult = A | B;
            3'b010: ALUResult = A + B;
            3'b110: ALUResult = A - B;
            3'b111: ALUResult = A < B;
            default: ALUResult = 0;
        endcase

    end

    assign zero = ~| ALUResult;

endmodule
