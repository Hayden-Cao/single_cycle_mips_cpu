`timescale 1ns / 1ps


module regfile_testbench();

    logic clk, we3;
    logic [4:0] ra1, ra2, wa3;
    logic [31:0] wd3, rd1, rd2;
    
    regfile reg1(clk,we3,ra1,ra2,wa3,wd3,rd1,rd2);
    
    
    always
        #5 clk = ~clk;
    
    initial
    begin
        clk = 0;
        we3 = 0;
        ra1 = 0;
        ra2 = 0;
        wa3 = 0;
        wd3 = 0;
        
        #10
        
        we3 = 1;
        wa3 = 5'b00001; // write to register 1
        wd3 = 32'hf0f0f0f0;

        #10 // wait for clock cycle for data to be stored
        
        we3 = 0;
        ra1 = 1;
        
        
    end
    
    always @(negedge clk)
    begin
    
        if(ra1 == 1)
        begin
            if(rd1 == 32'hf0f0f0f0)
            begin
                $display("Simulation succeeded");
                $stop;
            end
            else
            begin
                $display("Simuation Failed");
                $stop;
            end
        end
    
    end
    

endmodule