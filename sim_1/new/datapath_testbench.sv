`timescale 1ns/1ps

module datapath_testbench();

// Input logics
logic clk, reset, memtoreg, pcsrc; 
logic alusrc, regdst, regwrite, jump;
logic[2:0] alucontrol;
logic [31:0] instr, readdata;

// Output logics

logic zero;
logic [31:0] instr, aluout, writedata, pc;


datapath dut(clk, reset, memtoreg, pcsrc, alusrc
            regdst, regwrite, jump, alucontrol, zero,
            pc, instr, aluout, writedata, readdata);


controller con(instr[31:26], instr[5:0], zero, regwrite, 
            regdst, alusrc, pcsrc, memwrite, memtoreg, 
            jump, alucontrol);


always
    clk <= 1; #5 clk <= 0; #5

initial 
begin

    reset = 1;
    instr = 0;

    #10 reset = 0;
    instr = 32'h20020005;

    #10
    instr = 32'h2003000c;

    #10 $finish;

end


always @(negedge clk)
begin

    if(instr == 32'h20020005)
    begin

        if(writedata == 5)
            $display("Sim Passed")
        else
            $display("Sim Failed, got %h", writedata);
            
    end
    else if (instr == 32'h2003000c)
    begin

        if(writedata == 12)
            $display("Sim Passed");
        else
            $display("Sim Failed, got %h", writedata);

    end

end

endmodule