`timescale 1ns/1ns

module controller (input clk, rst, miss, dataRdy, output reg outSel, regWrite, memRead, increment, outDataReady);
    reg [1:0] ps,ns;
    // reg flag = 0;
    parameter addressing = 0, memoryRd = 1, cacheWrite = 2, addrInc = 3;
    always @ (posedge rst, posedge clk) begin
      if (rst) ps <= addressing;
      else ps <= ns;
    end
    always @(ps, dataRdy, miss) begin
        case (ps)
            addressing: begin
                if (miss == 0)
                    ns <= addrInc;
                else
                    ns <= memoryRd;
            end
            memoryRd: begin
                if (dataRdy == 0)
                    ns <= memoryRd;
                else
                    ns <= cacheWrite;
            end
            cacheWrite: begin
                if (dataRdy)
                    ns <= cacheWrite;
                else
                    ns <= addressing;
            end
            addrInc: ns <= addressing;
        endcase
    end
    always @(ps) begin
        memRead = 0;
        regWrite = 0;
        increment = 0;
        outDataReady = 0;
        case (ps)
            addressing: begin
                outSel = 0;
                if (miss == 0)
                    outDataReady = 1;
            end
            addrInc: increment = 1;
            memoryRd: begin
                memRead = 1;
                // if (flag == 0)
                //     adrDec = 1;
                // flag = 1;
            end
            cacheWrite: begin
                // flag = 0;
                regWrite = 1;
                outSel = 1;
                outDataReady = 1;
            end
        endcase
    end
endmodule
