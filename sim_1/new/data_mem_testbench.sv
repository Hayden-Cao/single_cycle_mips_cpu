`timescale 1ns/1ps

module data_mem_testbench();

// Input logics
logic clk, we;
logic [31:0] a, wd;

// Output logic
logic [31:0] rd;

data_mem dut(clk, we, a, wd, rd);

always #5 clk = ~clk;

initial begin
    clk = 0;
    we = 0;
    a = 0;
    wd = 0;

    // write wd to address 14
    #10;
    a <= 14;
    wd <= 32'hf0f0f0f0;
    we <= 1;

    #10;
    we <= 0;
    // write wd to address 12
    #10;
    a <= 12;
    wd <= 32'h01010101;
    we <= 1;

    #10;
    we <= 0;
    // read address 12
    #10;
    a <= 12;
    we <= 0;

    #10;
    if (rd == 32'h01010101)
        $display("Read from address 12 Passed, rd = %h", rd);
    else
        $display("Read Test Failed, expected = %h, got = %h", 32'h01010101, rd);

    $finish;
    
    #10 a <= 14;

    #10
    
    if (rd == 32'hf0f0f0f0)
        $display("Read from address 14 passed");
    else
        $display("Read from address 14 failed, expected = %h, got %h", 32'hf0f0f0f0, rd);


end



endmodule
