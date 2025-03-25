`timescale 1ns / 1ps

module alu_tb;
    // Inputs to the ALU
    reg [7:0] operand1, operand2;
    reg [2:0] alu_op;
    
    // Outputs from the ALU
    wire [7:0] alu_result;
    wire zero_flag, overflow_flag;

    // Instantiate the ALU
    alu uut (
        .operand1(operand1),
        .operand2(operand2),
        .alu_op(alu_op),
        .alu_result(alu_result),
        .zero_flag(zero_flag),
        .overflow_flag(overflow_flag)
    );

    initial begin
        

        // Finish simulation
        #10 $stop;
    end
endmodule
