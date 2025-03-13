module program_counter (
    input wire clk, rst, jmp_enable,
    input wire [7:0] jmp_addr,
    output reg [7:0] pc
);
initial pc = 0;
    always @(posedge clk or posedge rst) begin
        if (rst) pc <= 0;
        else if (jmp_enable) begin
            pc <= jmp_addr;
        end
        else pc <= pc + 1;
    end
endmodule