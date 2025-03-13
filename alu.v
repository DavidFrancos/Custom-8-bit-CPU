module alu (
    input wire [7:0] operand1, operand2,
    input wire [3:0] alu_op,
    output reg [7:0] alu_result,
    output reg zero_flag, overflow_flag
);
always @(*) begin
    case (alu_op)
        4'b0000,4'b0001: begin // ADD | ADDI
            alu_result = operand1 + operand2;
            overflow_flag = (operand1[7] & operand2[7] & ~alu_result[7]) | 
            (~operand1[7] & ~operand2[7] & alu_result[7]);
        end
        4'b0010,4'b0011: begin // SUB | SUBI
            alu_result = operand1 - operand2;
            overflow_flag = (operand1[7] & ~operand2[7] & ~alu_result[7]) | 
            (~operand1[7] & operand2[7] & alu_result[7]);
        end
        4'b0100,4'b0101: begin // AND | ANDI
            alu_result = operand1 & operand2;
            overflow_flag = 1'b0;
        end
        4'b0110,4'b0111: begin // OR | ORI
            alu_result = operand1 | operand2;
            overflow_flag = 1'b0;
        end
        4'b1000,4'b1001: begin // XOR | XORI
            alu_result = operand1 ^ operand2;
            overflow_flag = 1'b0;
        end

        default: begin // No operation
            alu_result = 8'd0;
            overflow_flag = 1'b0;
        end
    endcase
    zero_flag = (alu_result == 8'd0)? 1'b1:1'b0;
end
endmodule