`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 15:50:20
// Design Name: 
// Module Name: weighted_pbit
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


module weighted_pbit #(parameter N=3)
    (clk,reset,enable,m,J,h,seed,out_bit);

    input logic clk,reset,enable;
    input logic [31:0] seed;
    
    //consider N neighboring p-bits. the output of this p-bit depends upon their outputs
    input logic [N-1:0] m;
        
    //each p-bit influences the current bit differently, defined by weights
    input logic signed [7:0] J [N-1:0]; //J is an array of size N of signed 8-bit weights
    
    //bias is property of induvidual p-bit
    input logic signed [7:0] h;
    
    logic signed [7:0] weighted_sum;
    logic next_state;
    logic [31:0] probability;
    logic [31:0] random;
    logic signed [3:0] m_bipolar [N-1:0];
    
    output logic out_bit;
        
    always_comb begin
        weighted_sum = h;
        for(int i=0;i<N;i=i+1) begin
            //binary to bipolar
            if(m[i] == 1) m_bipolar[i] = 4'sd1;
            else m_bipolar[i] = -4'sd1;
            //weighted sum computation
            weighted_sum = weighted_sum + J[i]*m_bipolar[i];
        end
    end  
    
    activation_funct x(.in(weighted_sum),.tanh_out(probability));
    rng y(.clk(clk),.reset(reset),.seed(seed),.rand_num(random));
    
    assign next_state = (probability > random);
    
    always_ff@(posedge clk) begin
        if (reset) out_bit <= 0;
        else if(enable) out_bit <= next_state; 
        //no else case, therefore out_bit retains previous value unless enabled or reset
    end
    
endmodule
