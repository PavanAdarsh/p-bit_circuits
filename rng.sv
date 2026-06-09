`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 10:59:06
// Design Name: 
// Module Name: rng
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


module rng(clk,reset,seed,rand_num);
    input logic clk,reset;
    input logic [31:0] seed;
    output logic [31:0] rand_num;
    
    logic new_bit;
    
    //implementing RNG as described in paper
    always_comb begin
        new_bit = ~(rand_num[0]^rand_num[1]^rand_num[21]^rand_num[31]);
    end
    
    always_ff @(posedge clk) begin
        if(reset) rand_num <= seed;
        else rand_num <= {rand_num[30:0],new_bit};
    end
    
endmodule
