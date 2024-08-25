`timescale  1ns/1ps

module UART_TX_testbench();

//input logics;
logic clk, tx_dv;
logic [7:0] tx_byte;

//output logics

logic tx_serial, tx_done, tx_ready;

UART_TX dut(clk, tx_dv, tx_byte, tx_serial,tx_done, tx_ready);


always
    #5 clk = ~clk;

initial begin
    clk = 0;
    tx_dv = 0;
    tx_byte = 8'hf4;

    #10

    tx_dv = 1;

    while(tx_done == 0); // wait for tx to be finished

    #20 
    
    tx_dv = 0;
    tx_byte = 8'h12;

    #10 
    
    tx_dv = 1;

    while(tx_done == 0);
    
    #20 $finish;

end



endmodule;