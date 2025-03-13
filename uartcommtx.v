module uartcommtx (
    input wire clk, new_message,
    input wire [7:0] pcOutput,
    output reg tx
);

reg [6:0] baudCounter = 0;
reg idle = 1;
reg start = 0;
reg [3:0] sending = 0;
reg [7:0] tempShift = 0;
initial tx = 1;

always @(posedge new_message) begin
    idle <= 0;
    start <= 1;
    tempShift <= pcOutput;
    baudCounter <= 0;
end

always @(posedge clk) begin
    baudCounter <= baudCounter + 1;
    if (baudCounter >= 104) begin
        baudCounter <= 0;
        if (idle) begin
            tx <= 1;
        end
        else begin
            if (start) begin
                tx <= 0;
                start <= 0;
            end
            else begin
                if (sending < 8) begin
                    tx <= tempShift[0];  
                    tempShift <= tempShift >> 1;
                    sending <= sending + 1;
                end
                else begin
                    tx <= 1;
                    idle <= 1;
                    sending <= 0;
                end
            end
        end
    end
end

endmodule


