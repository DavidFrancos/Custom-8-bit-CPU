module instruction_decoder (
    input wire [15:0] instruction,
    output reg [3:0] opcode,
    output reg [2:0] rs1,rs2,rd,
    output reg [5:0] immediate,
    output reg [7:0] jmp_addr
);
    always @(*) begin
        opcode = instruction[15:12];
        if (instruction[15:12] == 4'b1100 || instruction[15:12] == 4'b1101 || instruction[15:12] == 4'b1110) begin
            rs1 = 3'b000;
            rs2 = 3'b000;
            rd = 3'b000;
            immediate = 6'b000000;
            jmp_addr = instruction[11:4];
        end
        else if (instruction[12] == 0 && instruction[15:12] <= 4'b1001) begin
            rs1 = instruction[11:9];
            rs2 = instruction[8:6];
            rd = instruction[5:3];
            immediate = 6'b000000;
            jmp_addr = 8'b00000000;
        end
        else begin
            rs1 = instruction[11:9];
            rs2 = 3'b000;
            rd = instruction[8:6];
            immediate = instruction[5:0];
            jmp_addr = 8'b00000000;
        end
    end
endmodule