`timescale 1ns/1ns

module cache(input[14:0] address, input[31:0] dataIn [0:3], input rst, clk, cacheWrite, output[31:0] readData, output reg miss);
    reg[14:0] counter;
    reg[35:0] cache [0:4095];
    wire hit;
    reg [11:0] writeAdr;
    integer i;
    always @(address, posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4096; i++) begin
                cache[i] = 0;
            end
            counter <= 0;
        end
        else if (hit) begin
            counter <= counter + 1;
        end
        else begin
            counter <= counter;
        end
    end
    always @(posedge clk) begin
        if (cacheWrite) begin
            writeAdr = {address[11:2], 2'b00};
            cache[writeAdr] = {1'b1, address[14:12], dataIn[0]};
            cache[writeAdr + 1] = {1'b1, address[14:12], dataIn[1]};
            cache[writeAdr + 2] = {1'b1, address[14:12], dataIn[2]};
            cache[writeAdr + 3] = {1'b1, address[14:12], dataIn[3]};
        end
    end
    assign hit = (address[14:12] == cache[address % 4096][34:32] && cache[address % 4096][35]) ? 1 : 0;
    assign readData = (hit) ? cache[address][31:0] : dataIn[address[1:0]];
    assign miss = ~hit;
endmodule
