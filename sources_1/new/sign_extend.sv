`timescale 1ns / 1ps


module sign_extend
(
    input logic [15:0] a,
    output logic [31:0] y
);
    assign y = {{16{a[15]}}, a};
    
endmodule