`timescale 1ns / 1ps

module seven_seg_out(

    input [3:0] b_in,
    output [6:0] inv_leds

    );
    
    wire [6:0] leds;
    
    truth_table_7_seg u1 (.b_in(b_in), .leds(leds));
    inverter u2 (.a(leds), .x(inv_leds));
    
endmodule