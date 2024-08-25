`timescale 1ns / 1ps

module instr_mem_testbench();

// input address
logic [5:0] a;

// output memory
logic [31:0] rd;

instr_mem dut(a, rd);

logic [31:0] expected_vals[63:0];

integer i = 0;

initial
begin
    a = 0;
    $readmemh("memfile.mem", expected_vals);
    for(i = 0; i < 18; i = i + 1) // there are 18 instructions so 0-17 indexing
    begin
        a = i;
        #10;

        if(rd == expected_vals[i])
            $display("Sim passed for instr %d", i);
        else
            $display("Sim failed for instr %d", i);

    end

    #10 $finish;

end

endmodule