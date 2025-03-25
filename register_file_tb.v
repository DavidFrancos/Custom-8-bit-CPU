`timescale 1ns/1ps

module register_file_tb;

    // Inputs
    reg clk, rst, write_enable;
    reg [2:0] read_addr1, read_addr2, write_addr;
    reg [7:0] write_data;

    // Outputs
    wire [7:0] read_data1, read_data2;

    // Instantiate the Register File
    register_file uut (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock Generation
    always #5 clk = ~clk; // Toggle clock every 5 ns (10 ns period)

    // Test Procedure
    initial begin
        $dumpfile("register_file_tb.vcd");
        $dumpvars(0, register_file_tb);

        // Initialize signals
        clk = 0;
        rst = 1;
        write_enable = 0;
        read_addr1 = 3'b000;
        read_addr2 = 3'b001;
        write_addr = 3'b000;
        write_data = 8'b00000000;

        // Apply Reset
        #10 rst = 0; // Deassert reset

        // Write Test: Store 8'b10101010 into R2
        #10 write_addr = 3'b010; 
        write_data = 8'b10101010; 
        write_enable = 1;
        #10 write_enable = 0; // Disable write

        // Read Test: Read from R2 and R3
        #10 read_addr1 = 3'b010; // Read from R2
        read_addr2 = 3'b011; // Read from R3

        // Write Test: Store 8'b11001100 into R4
        #10 write_addr = 3'b100; 
        write_data = 8'b11001100; 
        write_enable = 1;
        #10 write_enable = 0;

        // Read Test: Read from R4 and R2
        #10 read_addr1 = 3'b100; 
        read_addr2 = 3'b010;

        // Apply Reset Again
        #10 rst = 1;
        #10 rst = 0;

        // End simulation
        #20 $stop;
    end

endmodule