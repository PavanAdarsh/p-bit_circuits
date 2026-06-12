`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 15:02:55
// Design Name: 
// Module Name: full_adder
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


module full_adder(clk,reset,seed,select,clamp,A_state,B_state,Cin_state,S_state,Cout_state);
    
    input logic clk,reset;
    input logic [4:0] select,clamp;
    input logic [31:0] seed [4:0];
    
    output logic A_state,B_state,Cin_state,S_state,Cout_state;
    
    
    //bias and interconnection values from paper
    parameter J_AB = -8'sd2, J_ACin = -8'sd2, J_AS = 8'sd2, J_ACout = 8'sd4,
            J_BCin = -8'sd2, J_BS = 8'sd2, J_BCout = 8'sd4,
            J_CinS = 8'sd2, J_CinCout = 8'sd4, 
            J_SCout = -8'sd4;
    parameter BIAS_A = 8'sd0, BIAS_B = 8'sd0, BIAS_Cin = 8'sd0, 
            BIAS_S = 8'sd0, BIAS_Cout = 8'sd0;
            
            
    //input assignment
    logic [3:0] m_A,m_B,m_Cin,m_S,m_Cout;
    assign m_A = {B_state,Cin_state,S_state,Cout_state};
    assign m_B = {A_state,Cin_state,S_state,Cout_state};
    assign m_Cin = {A_state,B_state,S_state,Cout_state};
    assign m_S = {A_state,B_state,Cin_state,Cout_state};
    assign m_Cout = {A_state,B_state,Cin_state,S_state};

    
    //interconnection assignment
    logic signed [7:0] J_A [3:0];
    assign J_A = {J_AB,J_ACin,J_AS,J_ACout};
    logic signed [7:0] J_B [3:0];
    assign J_B = {J_AB,J_BCin,J_BS,J_BCout};
    logic signed [7:0] J_Cin [3:0];
    assign J_Cin = {J_ACin,J_BCin,J_CinS,J_CinCout};
    logic signed [7:0] J_S [3:0];
    assign J_S = {J_AS,J_BS,J_CinS,J_SCout};
    logic signed [7:0] J_Cout [3:0];
    assign J_Cout = {J_ACout,J_BCout,J_CinCout,J_SCout};
    
    
    //enable assignment and implementation
    logic [4:0] enable;
    always_ff @(posedge clk) begin
        if(reset) enable <= 5'b00001;
        else enable <= {enable[3:0],enable[4]};
    end
    
    
    //p-bit instantiations
    weighted_pbit #(.N(4)) A (.clk(clk),.reset(reset),.enable(enable[0]),
                    .m(m_A),.J(J_A),.h(BIAS_A),.select(select[0]),
                    .clamp(clamp[0]),.seed(seed[0]),.out_bit(A_state));
                    
    weighted_pbit #(.N(4)) B (.clk(clk),.reset(reset),.enable(enable[1]),
                    .m(m_B),.J(J_B),.h(BIAS_B),.select(select[1]),
                    .clamp(clamp[1]),.seed(seed[1]),.out_bit(B_state));   
                    
    weighted_pbit #(.N(4)) C_in (.clk(clk),.reset(reset),.enable(enable[2]),
                    .m(m_Cin),.J(J_Cin),.h(BIAS_Cin),.select(select[2]),
                    .clamp(clamp[2]),.seed(seed[2]),.out_bit(Cin_state));   
                            
    weighted_pbit #(.N(4)) S (.clk(clk),.reset(reset),.enable(enable[3]),
                    .m(m_S),.J(J_S),.h(BIAS_S),.select(select[3]),
                    .clamp(clamp[3]),.seed(seed[3]),.out_bit(S_state));
                    
    weighted_pbit #(.N(4)) C_out (.clk(clk),.reset(reset),.enable(enable[4]),
                    .m(m_Cout),.J(J_Cout),.h(BIAS_Cout),.select(select[4]),
                    .clamp(clamp[4]),.seed(seed[4]),.out_bit(Cout_state));

endmodule
