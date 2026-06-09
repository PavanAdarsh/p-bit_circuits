`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:26:18
// Design Name: 
// Module Name: activation_funct
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


module activation_funct(in,tanh_out);
    input logic signed [7:0] in;
    output logic [31:0] tanh_out;
    
    //simplified tanh LUT, can be made non-linear later
    always_comb begin
        case (in) 
            -8: tanh_out = 32'h20000000;
            -7: tanh_out = 32'h28000000;
            -6: tanh_out = 32'h30000000;
            -5: tanh_out = 32'h38000000;
            -4: tanh_out = 32'h40000000;
            -3: tanh_out = 32'h50000000;
            -2: tanh_out = 32'h60000000;
            -1: tanh_out = 32'h70000000;
             0: tanh_out = 32'h80000000;
             1: tanh_out = 32'h90000000;
             2: tanh_out = 32'hA0000000;
             3: tanh_out = 32'hB0000000;
             4: tanh_out = 32'hC0000000;
             5: tanh_out = 32'hC8000000;
             6: tanh_out = 32'hD0000000;
             7: tanh_out = 32'hD8000000;
             
//            -8: tanh_out = 32'h00100000;
//            -7: tanh_out = 32'h00800000;
//            -6: tanh_out = 32'h01000000;
//            -5: tanh_out = 32'h04000000;
//            -4: tanh_out = 32'h08000000;
//            -3: tanh_out = 32'h10000000;
//            -2: tanh_out = 32'h20000000;
//            -1: tanh_out = 32'h40000000;
//            0: tanh_out = 32'h80000000;
//            1: tanh_out = 32'hc0000000;
//            2: tanh_out = 32'he0000000;
//            3: tanh_out = 32'hf0000000;
//            4: tanh_out = 32'hf8000000;
//            5: tanh_out = 32'hfc000000;
//            6: tanh_out = 32'hfe000000;
//            7: tanh_out = 32'hff000000;
            default: begin
                if(in>7) tanh_out = 32'hFFFFFFFF;
                else tanh_out = 32'h00000000;
            end
        endcase
    end
    
endmodule
