`timescale 1ns / 1ps


module full_controller_testbench();

    logic[5:0] opcode, funct;
    logic zero, RegWrite, RegDst, ALUSrc, PCSrc, MemWrite, MemtoReg, Jump;
    logic [2:0] ALUControl; 

    controller dut(opcode, funct, zero, RegWrite, RegDst, ALUSrc, PCSrc, MemWrite, MemtoReg, Jump, ALUControl);
    
    logic [8:0] control_signals;

    assign control_signals = {RegWrite, RegDst, ALUSrc, dut.Branch, MemWrite, MemtoReg, Jump, dut.ALUOp};

    initial 
    begin
    
        zero = 0;
        opcode = 6'b000000;
        funct = 6'b100000;
        
        #10
        
        funct = 6'b100010;
        
        #10
        
        funct = 6'b100100;
        
        #10
        
        funct = 6'b100101;
        zero = 1;
        
        #10
        
        opcode = 6'b100011;
        funct = 6'b101010;
        zero = 0;
        
        #10
        
        opcode = 6'b000100;
        zero = 1;
        funct = 6'b100000;
        
    end
    
    always@(PCSrc)
    begin
    
        if((dut.Branch & zero) == PCSrc)
            $display("PCSrc Sim Passed");
        else
            $display("PCSrc Sim Failed");
    end
    
    
    // alu_decoder testbench
    
    
    always@(ALUControl)
    begin
    
        if(dut.ALUOp == 2'b1x)
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
        
            case(dut.ALUOp)
            
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
    
    
    // main_decoder testbench
    always@(control_signals)
    begin
    
        case(opcode)
        
            6'b000000:
                if(control_signals == 9'b110000010)
                    $display("Sim passed for opcode 000000");
                else
                    $display("Sim Failed for opcode 000000");
            
            6'b100011:
                if(control_signals == 9'b101001000)
                    $display("Sim passed for opcode 100011");
                else
                    $display("Sim Failed for opcode 100011");
                    
             6'b101011:
                if(control_signals == 9'b001010000)
                    $display("Sim passed for opcode 101011");
                else
                    $display("Sim Failed for opcode 101011");    
                    
             6'b000100:
                if(control_signals == 9'b000100001)
                    $display("Sim passed for opcode 000100");
                else
                    $display("Sim Failed for opcode 000100");                     
 
             6'b001000:
                if(control_signals == 9'b101000000)
                    $display("Sim passed for opcode 001000");
                else
                    $display("Sim Failed for opcode 001000");       
 
              6'b000010:
                if(control_signals == 9'b000000100)
                    $display("Sim passed for opcode 000010");
                else
                    $display("Sim Failed for opcode 000010");                              
                    
        endcase
    
    end

endmodule