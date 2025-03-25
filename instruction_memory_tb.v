`timescale 1ns/1ps

module tb_instruction_memory;

    // Testbench signals
    reg [7:0] pc;
    wire [15:0] current_instruction;

    // Instantiate the Instruction Memory module
    instruction_memory IM (
        .pc(pc),
        .current_instruction(current_instruction)
    );

    initial begin
        // Wait for initialization
        #10;
        
        // Test cases
        pc = 8'd0; #10;
        pc = 8'd1; #10;
        pc = 8'd2; #10;
        pc = 8'd10; #10; // Out-of-bounds access
        
        // Finish simulation
        $stop;
    end

endmodule