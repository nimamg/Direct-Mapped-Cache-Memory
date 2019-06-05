`timescale 1ns/1ns

module cache(input[14:0] address, input[31:0] dataIn [0:3], input clk, rst, output[31:0] readData);
    reg[14:0] counter;
    reg[35:0] cache [0:4095];
    wire hit;
    integer i;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4096; i++) begin
                cache[i] = 0;
            end
            counter <= 0;
        end
        else if (hit)
            counter <= counter + 1;
        else
            counter <= counter;
    end
    always @(address) begin
        if (!hit) begin
            cache[address % 4096] = {1'b1, address[14:12], dataIn[0]};
            cache[(address % 4096) + 1] = {1'b1, address[14:12], dataIn[1]};
            cache[(address % 4096) + 2] = {1'b1, address[14:12], dataIn[2]};
            cache[(address % 4096) + 3] = {1'b1, address[14:12], dataIn[3]};
        end
    end
    assign hit = (address[31:29] == cache[address % 4096][34:32] && cache[address % 4096][35]) ? 1 : 0;
    assign readData = (hit) ? cache[address][31:0] : dataIn[address[1:0]];
endmodule