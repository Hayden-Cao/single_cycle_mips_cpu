`timescale 1ns / 1ps

module truth_table_7_seg(

    input [3:0] b_in,
    output reg [6:0] leds
   
    );
    
    
    always @(b_in) begin
    
        case (b_in)
            0: leds = 7'b0111111;
            1: leds = 7'b0000110;
            2: leds = 7'b1011011;
            3: leds = 7'b1001111;
            4: leds = 7'b1100110;
            5: leds = 7'b1101101;
            6: leds = 7'b1111101;
            7: leds = 7'b0000111;
            8: leds = 7'b1111111;
            9: leds = 7'b1101111;
            10: leds = 7'b1110111;
            11: leds = 7'b1111100;
            12: leds = 7'b0111001;
            13: leds = 7'b1011110;
            14: leds = 7'b1111001;
            15: leds = 7'b1110001;
            default: leds = 7'b1111111;
        endcase
    end 
    
endmodule