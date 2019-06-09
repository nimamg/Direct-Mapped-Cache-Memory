`timescale 1ns / 1ns


module tb();
    reg clk = 0, rst = 1;
    wire [31:0] outData;
    reg [14:0] address = 15'd1024;
    wire increment,outDataReady;
    topLevel UUT(clk, rst, address, outData, increment, outDataReady);
    always #10 clk = ~clk;
    initial begin
        rst = 1;
        #20;
        rst = 0;
        while (address < 9216) begin
            #20;
            if (increment) address++;
        end
        $stop;
    end
endmodule
