module cpu (
    input wire clk, rst, rx,
    output wire tx
);

    wire [15:0] current_instruction;
    wire [7:0] pc, jmp_addr, read_data1, read_data2, read_output, write_data, operand1, operand2;
    wire [7:0] pcInput, alu_result;
    wire [5:0] immediate;
    wire [3:0] alu_op, opcode;
    wire [2:0] rs1, rs2, rd;
    wire zero_flag, use_immediate, write_enable, jmp_enable, overflow_flag ,new_message;
    reg [7:0] pcOutput;
    reg [2:0] ro;

    assign operand1 = read_data1;
    assign operand2 = use_immediate ? {2{immediate[5]}, immediate} : read_data2;
    assign write_data = alu_result;

    uartcommrx UART_RX (
        .clk(clk),
        .rx(rx),
        .new_message(new_message),
        .pcInput(pcInput)
    );

    uartcommtx UART_TX (
        .clk(clk),
        .tx(tx),
        .new_message(new_message),
        .pcOutput(pcOutput)
    );

    program_counter programCOUNTER (
        .clk(clk),
        .rst(rst),
        .jump_enable(jump_enable),
        .jmp_addr(jmp_addr),
        .pc(pc)
    );

    instruction_memory instructionMEM (
        .pc(pc),
        .current_instruction(current_instruction)
    );

    instruction_decoder instructionDEC (
        .current_instruction(current_instruction),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .immediate(immediate),
        .jmp_addr(jmp_addr)
    );

    control_unit controlUNIT (
        .zero_flag(zero_flag),
        .opcode(opcode),
        .alu_op(alu_op),
        .use_immediate(use_immediate),
        .write_enable(write_enable),
        .jmp_enable(jmp_enable)
    );

    register_file registerFILE (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .read_addr_o(ro),
        .write_addr(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .read_output(read_output)
    );

    alu ALU (
        .operand1(operand1),
        .operand2(operand2),
        .alu_op(alu_op),
        .alu_result(alu_result),
        .zero_flag(zero_flag),
        .overflow_flag(overflow_flag)
    );


    always @(*) begin
        pcOutput = read_output;
        case (pcInput)
            8'd48: begin
                ro = 3'b000;
            end
            8'd49: begin
                ro = 3'b000;
            end
            8'd50: begin
                ro = 3'b000;
            end
            8'd51: begin
                ro = 3'b000;
            end
            8'd52: begin
                ro = 3'b000;
            end
            8'd53: begin
                ro = 3'b000;
            end
            8'd54: begin
                ro = 3'b000;
            end
            8'd55: begin
                ro = 3'b000;
            end
            8'd56: begin
                ro = 3'b000;
            end
            8'd57: begin
                ro = 3'b000;
            end
            default: pcOutput = 8'b00000000
        endcase
    end

endmodule