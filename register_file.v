module register_file (
    input wire clk, rst, write_enable,
    input wire [2:0] read_addr1 ,read_addr2, write_addr,
    input wire [7:0] write_data,
    output reg [7:0] read_data1,read_data2
);
integer i;
reg [7:0] registers [7:0];
initial begin
    registers[0] = 8'b00000000; //addr R0: 000
    registers[1] = 8'b00000001; //addr R1: 001
    registers[2] = 8'b00000010; //addr R2: 010
    registers[3] = 8'b00000011; //addr R3: 011
    registers[4] = 8'b00000100; //addr R4: 100
    registers[5] = 8'b00000101; //addr R5: 101
    registers[6] = 8'b00000110; //addr R6: 110
    registers[7] = 8'b00000111; //addr R7: 111
end



always @(posedge clk or posedge rst) begin
    read_data1 = registers[read_addr1];
    read_data2 = registers[read_addr2];
    if (rst) begin
        for (i = 0; i < 8; i = i + 1) begin
            registers[i] <= 0;
        end
    end
    else begin
        if (write_enable) begin
            registers[write_addr] <= write_data;
        end
    end
    end
endmodule