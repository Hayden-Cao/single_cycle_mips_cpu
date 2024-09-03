`timescale 1ns / 1ps

// counts 1 second
module clk_1hz
(
    input logic clk,
    input logic enable,
    output logic clk_1hz
);

    localparam master_clk_freq = 100_000_000;
    
    logic [$clog2(master_clk_freq)-1:0] counter = 0;
    logic next_clk_1hz;
    
    always_ff @(posedge clk) begin
        counter <= counter + 1;
        if (counter == master_clk_freq - 1)
          begin
            counter <= 0;
            if (enable) next_clk_1hz <= ~next_clk_1hz;
          end
    end
    
    assign clk_1hz = next_clk_1hz;
    
endmodule
