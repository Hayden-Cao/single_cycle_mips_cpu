`timescale 1ns / 1ps


module alu_decoder_testbench();


logic [5:0] funct;
logic [1:0] aluop;
logic [2:0] ALUControl;

alu_decoder dut(funct, aluop, ALUControl);

    initial 
    begin
        
        aluop = 2'b00;
        funct = 6'b100000;
        
        #10
        
        aluop = 2'b01;
        funct = 6'b100010;
        
        #10
        
        aluop = 2'b10;
        funct = 6'b100100;
        
        #10
        
        funct = 6'b100101;
        
        #10
        
        aluop = 2'b00;
        funct = 6'b101010;
        
        #10
        aluop = 2'b01;
        funct = 6'b100000;
        
    end

always@(ALUControl)
    begin
    
        if(aluop == 2'b10 || aluop == 2'b11)
        begin
        
            case(funct)
        
            6'b100000:
                if(ALUControl == 3'b010)
                    $display("Sim Passed for funct 100000");
                else
                    $display("Sim Failed for funct 100000");
                    
            6'b100010:
                if(ALUControl == 3'b110)
                    $display("Sim Passed for funct 100010");
                else
                    $display("Sim Failed for funct 100010");
                    
            6'b100010:
               if(ALUControl == 3'b000)
                    $display("Sim Passed for funct 100100");
                else
                    $display("Sim Failed for funct 100100");
                     
              6'b100101:
                if(ALUControl == 3'b001)
                    $display("Sim Passed for funct 100101");
                else
                    $display("Sim Failed for funct 100101");    
                    
              6'b101010:
                if(ALUControl == 3'b111)
                    $display("Sim Passed for funct 101010");
                else
                    $display("Sim Failed for funct 101010");                                                    
                         
            endcase
        end
        else
        begin
        
            case(aluop)
            
                2'b00:
                    if(ALUControl == 3'b010)
                        $display("Sim Passed for ALUop 00");
                    else
                        $display("Sim Failed for ALUOp 00");
                
                2'b01:
                    if(ALUControl == 3'b110)
                        $display("Sim Passed for ALUOp 01");
                    else
                        $display("Sim Failed for ALUOp 01");
            
            endcase
        
        end
    
    end


endmodule
