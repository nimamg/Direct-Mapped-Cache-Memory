`timescale 1ns/1ns

module dataMem (input [14:0] address, output reg [31:0] data [0:3], output reg dataRdy);
    reg [31:0] memory [0:32767];
    wire [14:0] shiftedAdr = {address[14:2], 2'b0};
    integer i;
    initial begin
        for (i = 0; i < 32768; i++) begin
            memory[i] = i;
        end
    end
    always @* begin
        if (memRead) begin
            #40;
            data [0] = memory [shiftedAdr];
            data [1] = memory [shiftedAdr + 1];
            data [2] = memory [shiftedAdr + 2];
            data [3] = memory [shiftedAdr + 3];
            dataRdy = 1;
        end
    end
endmodule
