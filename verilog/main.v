`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Peradeniya
// Engineer: Shadhurshan Navaretnam
// 
// Create Date: 02/10/2026 01:08:04 PM
// Design Name: Sobel edge detection using Verilog
// Module Name: main
// Project Name: Sobel edge detection using Verilog_Mile stone 001
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sobel_core (
    input clk,
    input [7:0] pixel_in,
    input valid_in,
    output reg [7:0] pixel_out,
    output reg valid_out
);

    parameter WIDTH = 512;

    reg [7:0] r1 [0:WIDTH-1];
    reg [7:0] r2 [0:WIDTH-1];
    reg [7:0] r3 [0:WIDTH-1];

    reg [31:0] col = 0;
    reg [31:0] row = 0;

    reg signed [10:0] Gx, Gy;
    reg [10:0] G;

    always @(posedge clk) begin
        if(valid_in) begin

            // Shift rows
            r3[col] <= r2[col];
            r2[col] <= r1[col];
            r1[col] <= pixel_in;

            if(row > 1 && col > 1) begin

                Gx =  r3[col] - r3[col-2]
                    + (r2[col] <<< 1) - (r2[col-2] <<< 1)
                    +  r1[col] - r1[col-2];

                Gy =  r3[col] + (r3[col-1] <<< 1) + r3[col-2]
                    -  r1[col] - (r1[col-1] <<< 1) - r1[col-2];

                if(Gx < 0) Gx = -Gx;
                if(Gy < 0) Gy = -Gy;

                G = Gx + Gy;

                if(G > 255)
                    pixel_out <= 8'd255;
                else
                    pixel_out <= G[7:0];

                valid_out <= 1;

            end
            else begin
                valid_out <= 0;
            end

            col <= col + 1;

            if(col == WIDTH-1) begin
                col <= 0;
                row <= row + 1;
            end

        end
    end

endmodule
