`timescale 1ns/1ps

module control_unit_tb;

     reg [3:0] opcode;
     reg zero_flag;
     wire [3:0] alu_op;
     wire  use_immediate,write_enable,jmp_enable;

     control_unit uut (
       .opcode(opcode),
       .alu_op(alu_op),
       .zero_flag(zero_flag),
       .jmp_enable(jmp_enable),
       .use_immediate(use_immediate),
       .write_enable(write_enable)
     );


     initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);

        opcode = 4'b0110;
        zero_flag = 0;

        #10 opcode = 4'b0101;

        #10 opcode = 4'b1110;

        #10 opcode = 4'b1100;
        zero_flag = 1;

        #10 opcode = 4'b1101;

        #10 opcode = 4'b1110;
        
        #10


        $stop;
     end


endmodule