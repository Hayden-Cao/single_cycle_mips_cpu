`timescale 1ns / 1ps

module seven_seg_encoder
(

    input logic [2:0] select,
    input logic led_enable,
    output logic [7:0]led_enb

);
    
    always@(select, led_enable) begin

        if(!led_enable)
            led_enb = 8'b11111111;
        else
        begin
            case(select)
            3'b000 : led_enb = 8'b11111110;
            3'b001 : led_enb = 8'b11111101;
            3'b010 : led_enb = 8'b11111011;
            3'b011 : led_enb = 8'b11110111;
            3'b100 : led_enb = 8'b11101111;
            3'b101 : led_enb = 8'b11011111;
            3'b110 : led_enb = 8'b10111111;
            3'b111 : led_enb = 8'b01111111;
        endcase
        end        

    end
    
endmodule
