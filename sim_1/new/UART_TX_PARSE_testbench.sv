`timescale  1ns/1ps

module UART_TX_PARSER_testbench();

    // input logics
    logic clk, memwrite;
    logic [31:0] writedata;

    //output logics
    logic tx_serial, tx_done, tx_ready;

    UART_TX_PARSER dut(clk, writedata, memwrite, tx_serial, tx_done, tx_ready);

    always
        #5 clk = ~clk;

    initial
    begin

        clk = 0;
        writedata = 32'hf0f0f0f0;
        memwrite = 0;

        #10
        memwrite <= 1;

        // wait 5 tx_done cycles because 4 data bytes + 1 new line byte need to be sent
        while(tx_done == 0);
        while(tx_done == 0);
        while(tx_done == 0);
        while(tx_done == 0);
        while(tx_done == 0);


        #10 $finish;

    end

endmodule