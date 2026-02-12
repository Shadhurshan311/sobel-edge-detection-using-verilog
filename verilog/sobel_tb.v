`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2026 12:01:35 AM
// Design Name: 
// Module Name: sobel_tb
// Project Name: 
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

module sobel_tb;

    parameter WIDTH  = 512;
    parameter HEIGHT = 512;

    reg clk;
    reg [7:0] pixel_in;
    reg valid_in;

    wire [7:0] pixel_out;
    wire valid_out;

    integer infile, outfile;
    integer scan;
    integer count = 0;

    // Instantiate DUT
    sobel_core uut (
        .clk(clk),
        .pixel_in(pixel_in),
        .valid_in(valid_in),
        .pixel_out(pixel_out),
        .valid_out(valid_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        infile = $fopen("C:\\Users\\94772\\Desktop\\university tools\\SEMESTER 7\\EE587-Digital Design and Synthesis\\Sobel Edge Detector\\nature_decimal.txt", "r");
        outfile = $fopen("edge_output.txt", "w");

        if(infile == 0) begin
            $display("Error opening input file");
            $finish;
        end

        valid_in = 0;

        #20;

        while(!$feof(infile)) begin
            @(posedge clk);
            scan = $fscanf(infile, "%d\n", pixel_in);
            valid_in = 1;
            count = count + 1;
        end

        valid_in = 0;

        #1000;

        $display("Simulation Completed.");
        $fclose(infile);
        $fclose(outfile);
        $finish;

    end

    // Write output
    always @(posedge clk) begin
        if(valid_out)
            $fwrite(outfile, "%d\n", pixel_out);
    end

endmodule

