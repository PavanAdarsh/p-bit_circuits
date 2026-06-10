`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 09:57:22
// Design Name: 
// Module Name: and_gate
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


module and_gate(clk,reset,seed,select,clamp,A_state,B_state,C_state);

    input logic clk,reset;
    input logic [2:0] select,clamp;
    input logic [31:0] seed [2:0];
    
    output logic A_state,B_state,C_state;
    
    //bias and interconnection matrix values from paper
    parameter BIAS_A = 8'sd1, BIAS_B = 8'sd1, BIAS_C = -8'sd2; 
    parameter J_AB = -8'sd1, J_AC = 8'sd2, J_BC = 8'sd2; 
    
    //input assignment
    logic [1:0] m_a,m_b,m_c;
    assign m_a = {B_state,C_state};
    assign m_b = {C_state,A_state};
    assign m_c = {A_state,B_state};
    
    //interconnection assignment    
    logic signed [7:0] J_A [1:0];
    assign J_A[1] = J_AB;
    assign J_A[0] = J_AC;
    logic signed [7:0] J_B [1:0];
    assign J_B[1] = J_BC;
    assign J_B[0] = J_AB;
    logic signed [7:0] J_C [1:0];
    assign J_C[1] = J_AC;
    assign J_C[0] = J_BC;
    
    //sequencer assignment
    logic [8:0] seq_seed,seq_value;
    assign seq_seed = 9'b100000000;
    
    //enable assignment
    logic [2:0] enable;
    
    //sequencer implementation
    always_ff @(posedge clk) begin
        if(reset) seq_value <= seq_seed;
        else seq_value <= {seq_value[0],seq_value[8:1]};
    end
    
    //enable signal implementation
    always_comb begin
        enable[0] = (seq_value[8] | seq_value[7]);
        enable[1] = (seq_value[5] | seq_value[4]);
        enable[2] = (seq_value[2] | seq_value[1]);
    end
        
    //p-bit instantiation
    weighted_pbit #(.N(2)) A (.clk(clk),.reset(reset),.enable(enable[0]),
                    .m(m_a),.J(J_A),.h(BIAS_A),.select(select[0]),
                    .clamp(clamp[0]),.seed(seed[0]),.out_bit(A_state));
                    
    weighted_pbit #(.N(2)) B (.clk(clk),.reset(reset),.enable(enable[1]),
                    .m(m_b),.J(J_B),.h(BIAS_B),.select(select[1]),
                    .clamp(clamp[1]),.seed(seed[1]),.out_bit(B_state));
                    
    weighted_pbit #(.N(2)) C (.clk(clk),.reset(reset),.enable(enable[2]),
                    .m(m_c),.J(J_C),.h(BIAS_C),.select(select[2]),
                    .clamp(clamp[2]),.seed(seed[2]),.out_bit(C_state));
    
endmodule
