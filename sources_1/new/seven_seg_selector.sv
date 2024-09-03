`timescale 1ns / 1ps

module seven_seg_selector
(
    input logic clk, reset, seven_seg_enable,
    input logic [31:0] data_to_display,
    output logic [7:0] seven_seg_enb,
    output logic [6:0] seven_seg_out
);


logic [15:0] counter = 0;

always_ff@(posedge clk, posedge reset)
begin

    if(reset)
    begin
        counter <= 0;
    end
    else if(seven_seg_enable)
    begin
        counter <= counter + 1;
    end
    else
    begin
        counter <= 0;
    end

end

logic [3:0] four_bit_data;
logic [2:0] select;
assign select  = counter[15:13];

always_comb
begin
    case(select)
    
        3'b000: four_bit_data = data_to_display[3:0];
        3'b001: four_bit_data = data_to_display[7:4];
        3'b010: four_bit_data = data_to_display[11:8];
        3'b011: four_bit_data = data_to_display[15:12];
        3'b100: four_bit_data = data_to_display[19:16];
        3'b101: four_bit_data = data_to_display[23:20];
        3'b110: four_bit_data = data_to_display[27:24];
        3'b111: four_bit_data = data_to_display[31:28];
    
    endcase
end


seven_seg_encoder sse(select, seven_seg_enable, seven_seg_enb);

seven_seg_out sso(four_bit_data, seven_seg_out);

endmodule