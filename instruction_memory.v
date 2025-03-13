module instruction_memory (
    input wire [7:0] pc,
    output reg [15:0] current_instruction
);

reg [15:0] instructions [255:0];

initial begin
    $readmemb("program.mem", instructions);
end

always @(*) begin
    if (instructions[pc] === 16'bx) current_instruction = 16'd0;
    else current_instruction = instructions[pc];
    
end

endmodule