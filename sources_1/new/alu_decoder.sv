`timescale 1ns / 1ps

module alu_decoder
(
    input logic [1:0] ALUOp,
    input logic [5:0] funct,
    output logic [2:0] ALUControl
);

    always_comb
    begin

        case(ALUOp)

            2'b00: ALUControl = 3'b010; // ADD
            2'b01: ALUControl = 3'b110; // Subtract

            default:
            begin
                
                case(funct)

                    6'b100000: ALUControl = 3'b010;
                    6'b100010: ALUControl = 3'b110;
                    6'b100100: ALUControl = 3'b000;
                    6'b100101: ALUControl = 3'b001;
                    6'b101010: ALUControl = 3'b111;
                    default: ALUControl = 3'bxxx;
                endcase

            end
        
        endcase

    end

endmodule