`timescale 1ns / 1ps

module alu_testbench();


    logic [31:0] A,B, ALUResult;
    logic [2:0] ALUControl;

    alu dut(A,B,ALUControl,ALUResult, zero);


    initial begin
    
    A = 5;
    B = 10;
    
    ALUControl = 3'b000; // A & B
    
    #10 ALUControl = 3'b001; // A | B
    #10 ALUControl = 3'b010; // A + B
    #10 ALUControl = 3'b110; // A - B
    #10 ALUControl = 3'b111; // A < B
    
    #10
    
    A = 25;
    B = -15;
    ALUControl = 3'b000;
    
    #10 ALUControl = 3'b001;
    #10 ALUControl = 3'b010;
    #10 ALUControl = 3'b110;
    #10 ALUControl = 3'b111;
    
    #10 $finish;
    
    end
    
    always@(ALUResult)
    begin
            case(ALUControl)
            
                3'b000:
                    if(ALUResult == (A & B))
                        $display("AND Operation Passed");
                    else
                        $display("AND Operation Failed");
                
                3'b001:
                    if(ALUControl == 3'b001)
                    begin
                        if(ALUResult == (A | B))
                            $display("OR Operation Passed");
                        else
                        begin
                            $display("OR Operation Failed");
                            $display("Expected %0h, got %0h", (A|B), ALUResult);
                        end
                    end
                        
                3'b010:
                    if(ALUResult == (A + B))
                        $display("PLUS Operation Passed");
                    else
                        $display("PLUS Operation Failed");
                        
                3'b110:
                    if(ALUResult == (A - B))
                        $display("Minus Operation Passed");
                    else
                        $display("Minus Operation Failed");
                        
                        
                3'b111:
                    if(ALUResult == (A < B))
                        $display("Set Less Than Operation Passed");
                    else
                        $display("Set Less Than Operation Failed");
            
            endcase

    
    end


endmodule