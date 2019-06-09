`timescale 1ns/1ns

module topLevel(input clk, rst, input [14:0] address, output [31:0] outData, output increment, outDataReady);
    wire miss, dataRdy, outSel, cacheWrite, memRead;
    wire [31:0] data [0:3];
    wire [31:0] memOutData;
    wire [31:0] readData;
    controller ctrl (clk, rst, miss, dataRdy, outSel, cacheWrite, memRead, increment, outDataReady);
    dataMem memory (address, data, dataRdy, memRead);
    cache cacheMem (address, data, rst, clk, cacheWrite, readData, miss);
    assign memOutData = (address[1:0] == 0) ? data[0] : (address[1:0] == 1) ? data[1] :
                        (address[1:0] == 2) ? data[2] : data[3];
    assign outData = (outSel == 1) ? memOutData : readData;
endmodule
