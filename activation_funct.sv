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
            -8: tanh_out = 32'h00010000;  // ~0.000015
            -7: tanh_out = 32'h00080000;  // ~0.00012
            -6: tanh_out = 32'h00200000;  // ~0.00049
            -5: tanh_out = 32'h00800000;  // ~0.00195
            -4: tanh_out = 32'h02000000;  // ~0.0078
            -3: tanh_out = 32'h08000000;  // ~0.031
            -2: tanh_out = 32'h20000000;  // 0.125
            -1: tanh_out = 32'h50000000;  // 0.3125
    
             0: tanh_out = 32'h80000000;  // 0.5
    
             1: tanh_out = 32'hB0000000;  // 0.6875
             2: tanh_out = 32'hE0000000;  // 0.875
             3: tanh_out = 32'hF8000000;  // 0.96875
             4: tanh_out = 32'hFE000000;  // 0.992
             5: tanh_out = 32'hFF800000;  // 0.998
             6: tanh_out = 32'hFFE00000;  // 0.9995
             7: tanh_out = 32'hFFF80000;  // 0.9999
             
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
