module control_unit (
    input wire zero_flag,
    input wire [3:0] opcode,
    output reg [3:0] alu_op,
    output reg use_immediate, write_enable, jmp_enable
);


always @(*) begin
    case (opcode)
        4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110,
        4'b0111, 4'b1000, 4'b1001: begin
            use_immediate = opcode[0];
            alu_op = opcode;
            write_enable = 1;
            jmp_enable = 0;
        end
        4'b1100: begin
            use_immediate = 0;
            alu_op = 4'b0000;
            jmp_enable = 1;
            write_enable = 0;
        end 
        4'b1101: begin
            use_immediate = 0;
            alu_op = 4'b0000;
            jmp_enable = ~zero_flag;
            write_enable = 0;
        end 
        4'b1110: begin
            use_immediate = 0;
            alu_op = 4'b0000;
            jmp_enable = zero_flag;
            write_enable = 0; 
        end 
        default: begin 
            use_immediate = 0;
            alu_op = 4'b0000;
            write_enable = 0; 
            jmp_enable = 0;
        end
    endcase
end
    
endmodule