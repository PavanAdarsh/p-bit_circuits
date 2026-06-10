`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 10:04:32
// Design Name: 
// Module Name: tb
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


`timescale 1ns/1ps

module tb;

    logic clk;
    logic reset;
    logic [1:0] enable;
    logic [31:0] seed1, seed2;

    logic A_state;
    logic B_state;

    // instantiate NOT gate
    not_gate dut(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .seed1(seed1),
        .seed2(seed2),
        .A_state(A_state),
        .B_state(B_state)
    );

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // stimulus
    initial begin
        // different seeds
        seed1 = 32'hABCDE123;
        seed2 = 32'h13579BDF;

        // reset
        reset = 1;
        enable = 2'b00;

        #20;
        reset = 0;

        // sequential update pattern
        forever begin

            // update A only
            enable = 2'b01;
            #10;

            // update B only
            enable = 2'b10;
            #10;

        end
    end

    // stop simulation
    initial begin
        #500;
        $finish;
    end

endmodule
