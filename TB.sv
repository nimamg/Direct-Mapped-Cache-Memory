`timescale 1ns / 1ns


module tb();
    reg [14:0] address;
    wire [31:0] data [0:3];
    reg rst;
    wire [31:0] readData;
    dataMem memModule (address, data);
    cache cacheModule (address, data, rst, readData);
    initial begin
        rst = 1;
        #10;
        rst = 0;
        #10;
        address = 24;
        #10;
        address = 25;
        #10;
        address = 26;
        #10;
        address = 27;
        #10;
        address = 28;
        #10;
        address = 24;
        #10;
        address = 29;
        #10;
        $stop;
    end
endmodule
