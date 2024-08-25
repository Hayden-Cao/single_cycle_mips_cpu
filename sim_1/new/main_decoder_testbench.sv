`timescale 1ns / 1ps


module main_decoder_testbench();

    logic[5:0] opcode;
    logic RegWrite, RegDst, ALUSrc, Branch, MemWrite, Jump, MemtoReg;
    logic [1:0] ALUOp;

    main_decoder dut(opcode, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump, ALUOp);
    
    logic [8:0] control_signals;

    assign control_signals = {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Jump, ALUOp};
    
    
    initial
    begin
    
        opcode = 6'b000000;
             
        #10
        
        opcode = 6'b100011;
        
        #10
        
        opcode = 6'b101011;
        
        #10
        
        opcode = 6'b000100;
        
        #10
        
        opcode = 6'b001000;
        
        #10
        
        opcode = 6'b000010;
        
        #10 $finish;
    
    end
    
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