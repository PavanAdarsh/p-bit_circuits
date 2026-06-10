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

    //instantiate inputs and outputs
    logic clk;
    logic reset;
    logic [31:0] seed [2:0];

    logic A_state;
    logic B_state;
    logic C_state;
    
    //counter
    integer count000;
    integer count001;
    integer count010;
    integer count011;
    integer count100;
    integer count101;
    integer count110;
    integer count111;

    integer total_samples;

    // instantiate AND gate
    and_gate dut(
        .clk(clk),
        .reset(reset),
        .seed(seed),
        .A_state(A_state),
        .B_state(B_state),
        .C_state(C_state)
    );

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // stimulus
    initial begin
        // different seeds
        seed[0] = 32'hABCDE123;
        seed[1] = 32'h13579BDF;
        seed[2] = 32'h02468ACE;
        
        //initialize counters
        count000 = 0;
        count001 = 0;
        count010 = 0;
        count011 = 0;
        count100 = 0;
        count101 = 0;
        count110 = 0;
        count111 = 0;

        total_samples = 0;

        // reset
        reset = 1;
        #20;
        reset = 0;
    end
    
    // state counting
    always @(posedge clk) begin
        // wait some time after reset for settling
        if($time > 100) begin
            total_samples = total_samples + 1;
            case({A_state,B_state,C_state})
                3'b000: count000 = count000 + 1;
                3'b001: count001 = count001 + 1;
                3'b010: count010 = count010 + 1;
                3'b011: count011 = count011 + 1;
                3'b100: count100 = count100 + 1;
                3'b101: count101 = count101 + 1;
                3'b110: count110 = count110 + 1;
                3'b111: count111 = count111 + 1;
            endcase
        end
    end
    
    //end simulation
    initial begin

        #5000;

        $display("\n===== STATE COUNTS =====");

        $display("000 : %0d", count000);
        $display("001 : %0d", count001);
        $display("010 : %0d", count010);
        $display("011 : %0d", count011);
        $display("100 : %0d", count100);
        $display("101 : %0d", count101);
        $display("110 : %0d", count110);
        $display("111 : %0d", count111);

        $display("\nTotal Samples : %0d", total_samples);
    end

endmodule
