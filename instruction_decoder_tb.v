`timescale 1ns/1ps

module instruction_decoder_tb;

     reg [15:0] instruction;
     wire [3:0] opcode;
     wire [2:0] rs1,rs2,rd;
     wire [5:0] immediate;

     instruction_decoder uut (
       .instruction(instruction) ,
       .opcode(opcode),
       .rs1(rs1),
       .rs2(rs2),
       .rd(rd),
       .immediate(immediate)
     );


     initial begin
        $dumpfile("instruction_decoder_tb.vcd");
        $dumpvars(0, instruction_decoder_tb);

        instruction = 16'b0000001110111000;

        #10 instruction = 16'b0001110000010101;

        #10 instruction = 16'b0100000001010000;
        
        #10


        $stop;
     end


endmodule