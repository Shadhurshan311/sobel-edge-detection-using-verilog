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

module sobel_edge;

    parameter WIDTH  = 512;
    parameter HEIGHT = 512;

    reg [7:0] r1 [0:WIDTH-1];
    reg [7:0] r2 [0:WIDTH-1];
    reg [7:0] r3 [0:WIDTH-1];

    reg signed [10:0] Gx, Gy;
    reg [10:0] G;

    reg [7:0] pixel;
    reg [31:0] i;
    reg [31:0] row_count;

    reg clk;

    integer infile, outfile;
    integer scan;

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Initialization
    initial begin
        i = 0;
        row_count = 0;

        infile = $fopen("C:\\Users\\94772\\Desktop\\university tools\\SEMESTER 7\\EE587-Digital Design and Synthesis\\Sobel Edge Detector\\nature_decimal.txt", "r");
        if (infile == 0) begin
            $display("ERROR: Cannot open input file.");
            $finish;
        end
        else
            $display("Input file opened successfully.");

        outfile = $fopen("edge_output.txt", "w");
        if (outfile == 0) begin
            $display("ERROR: Cannot create output file.");
            $finish;
        end
        else
            $display("Output file created.");

    end

    always @(posedge clk) begin

        // Read pixel
        if (row_count < HEIGHT) begin

            scan = $fscanf(infile, "%d\n", pixel);

            if (scan != 1) begin
                $display("Finished reading file.");
                $fclose(infile);
                $fclose(outfile);
                $finish;
            end

            // Shift rows
            r3[i] = r2[i];
            r2[i] = r1[i];
            r1[i] = pixel;

            // Start Sobel after first 2 rows and columns
            if (row_count > 1 && i > 1) begin

                Gx =  r3[i] - r3[i-2]
                    + (r2[i] <<< 1) - (r2[i-2] <<< 1)
                    +  r1[i] - r1[i-2];

                Gy =  r3[i] + (r3[i-1] <<< 1) + r3[i-2]
                    -  r1[i] - (r1[i-1] <<< 1) - r1[i-2];

                if (Gx < 0) Gx = -Gx;
                if (Gy < 0) Gy = -Gy;

                G = Gx + Gy;

                if (G > 255)
                    G = 255;

                $fwrite(outfile, "%d\n", G);

            end

            i = i + 1;

            // Move to next row
            if (i == WIDTH) begin
                i = 0;
                row_count = row_count + 1;
                $display("Processing Row: %d", row_count);
            end

        end
        else begin
            $display("Processing Completed.");
            $fclose(infile);
            $fclose(outfile);
            $finish;
        end

    end

endmodule
