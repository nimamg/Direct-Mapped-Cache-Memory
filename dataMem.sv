`timescale 1ns/1ns

module dataMem (input [14:0] address, output [31:0] data [0:3]);
    reg [31:0] memory [0:32767];
    wire [14:0] shiftedAdr = {address[14:2], 2'b0};
    assign data [0] = memory [shiftedAdr];
    assign data [1] = memory [shiftedAdr + 1];
    assign data [2] = memory [shiftedAdr + 2];
    assign data [3] = memory [shiftedAdr + 3];
endmodule
