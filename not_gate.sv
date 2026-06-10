`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 14:19:46
// Design Name: 
// Module Name: not_gate
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


module not_gate(clk,reset,seed,select,clamp,enable,A_state,B_state);

    input logic clk,reset;
    input logic [1:0] select,clamp,enable;
    input logic [31:0] seed [1:0];
    
    output logic A_state,B_state;
    
    parameter BIAS_A = 8'sd0, BIAS_B = 8'sd1;
    
    logic signed [7:0] J_A [0:0];
    logic signed [7:0] J_B [0:0];
    
    assign J_A[0] = -8'sd2;
    assign J_B[0] = -8'sd2;
    
    weighted_pbit #(.N(1)) A (.clk(clk),.reset(reset),.enable(enable[0]),
                    .m(B_state),.J(J_A),.h(BIAS_A),.select(select[0]),
                    .clamp(clamp[0]),.seed(seed[0]),.out_bit(A_state));
                    
    weighted_pbit #(.N(1)) B (.clk(clk),.reset(reset),.enable(enable[1]),
                    .m(A_state),.J(J_B),.h(BIAS_B),.select(select[1]),
                    .clamp(clamp[1]),.seed(seed[1]),.out_bit(B_state));
                    
endmodule
