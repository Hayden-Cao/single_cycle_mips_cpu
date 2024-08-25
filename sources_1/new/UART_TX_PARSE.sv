`timescale  1ns/1ps

module UART_TX_PARSER 
(
    input logic clk,
    input logic [31:0] writedata,   // 32-bit data from CPU
    input logic memwrite,           // Signal from CPU to start transmission
    output logic tx_serial,    
    output logic tx_done,       
    output logic tx_ready       
);
    logic [31:0] data_buffer;    // Buffer to hold data being transmitted
    logic [2:0] byte_index;      // Index to track which byte of the data is being transmitted
    logic tx_active;
    
    // Instantiate UART_TX module
    UART_TX uart_tx_inst (clk, send, data_buffer[31:24], tx_serial, tx_done, tx_ready);

    always_ff @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            byte_index <= 0;
            data_buffer <= 0;
            tx_active <= 0;
        end 
        else if (memwrite && !tx_active) 
        begin
            data_buffer <= data_in;
            byte_index <= 0;
            tx_active <= 1;
        end 
        else if (tx_done) // if the byte is done sending go to the next
        begin
            if (byte_index < 3) begin
                byte_index <= byte_index + 1;
                data_buffer <= {data_buffer[23:0], 8'b0}; // Shift right to next byte
            end 
            else if (byte_index == 3)
            begin
                data_buffer[31:23] <= 8'h0a; // send new line
            end
            else
                tx_active <= 0;
        end
    end

endmodule
