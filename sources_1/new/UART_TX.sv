`timescale  1ns/1ps

module UART_TX 
(
    input logic clk, tx_dv,
    input logic [7:0] tx_byte,
    output logic tx_serial, tx_done, tx_ready
);

    localparam CLKS_PER_BIT   = 14'b10100010110000;   // hard coded to 9600 baud from the 100 MHz master clock
                                                    // i.e. 100 MHz / 9600 Hz = 10416 = 14'b10100010110000


    typedef enum logic[2:0] 
    {
        IDLE = 3'b000,
        TX_START = 3'b001,
        TX_SEND_DATA = 3'b010,
        TX_STOP_BIT = 3'b011,
        CLEANUP = 3'b100,
    } states;

    states state = IDLE;

    logic tx_active = 0;

    assign tx_ready = ~tx_active;


    // extra variables for computation

    logic [2:0] bit_index = 0; // keeps track of where we are in 8 bit data
    logic [13:0] clock_count = 0; // keeps count of clock cycles so we can send data in the middle of the send data cycle
    logic [7:0] tx_byte_i = 0; // internal byte so we dont lose data if tx_byte input changes

    always_ff@(posedge clk)
    begin

        case(state)

            IDLE:
            begin

                tx_serial <= 1'b1; // output is high for idle state
                tx_done <= 1'b0;

                if(tx_dv)
                begin
                    state <= TX_START;
                    tx_active <= 1'b1;
                    tx_byte_i <= tx_byte;
                end

            end

            TX_START:
            begin

                tx_serial <= 1'b0; // data line set low to signal start

                // wait for the start bit to be sent
                if(clock_count < CLKS_PER_BIT - 1)
                begin
                    clock_count <= clock_count + 1;
                    state <= TX_START
                end
                else
                begin
                    clock_count <= 0;
                    state <= TX_SEND_DATA;
                end

            end

            TX_SEND_DATA:
            begin

                tx_serial <= tx_byte_i[bit_index];

                if(clock_count < CLKS_PER_BIT -1)
                begin
                    clock_count <= clock_count + 1;
                    state <= TX_SEND_DATA;
                end
                else
                    clock_count <= 0;

                if(bit_index < 7)
                begin
                    bit_index <= bit_index + 1;
                    state <= TX_SEND_DATA;
                end
                else
                begin
                    bit_index <= 0;
                    state <= TX_STOP_BIT;
                end

            end

            TX_STOP_BIT:
            begin
                tx_serial <= 1'b1;

                if(clock_count < CLKS_PER_BIT - 1)
                begin
                    clock_count <= clock_count + 1;
                    state <= TX_STOP_BIT
                end
                else
                begin
                    tx_done <= 1'b1;
                    clock_count <= 0;
                    state <= CLEANUP;
                    tx_active <= 1'b0;
                end

            end

            CLEANUP:
            begin
                tx_done <= 1'b1;
                state <= IDLE;
            end

            default:
                state <= IDLE;

        endcase

    end

endmodule
