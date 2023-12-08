`timescale 1ns / 1ps

module invMixColumns(
    input clk,
    input reset,
    input [127:0]data,
    output logic [127:0]dout
    );
    
//  Data Input                    
//
//  127:120  95:88   63:56   31:24
//  119:112  87:80   55:48   23:16
//  111:104  79:72   47:40   15:8 
//  103:96   71:64   39:32   7:0  

//  Multiplication Matrix
//  
//  0E  0B  0D  09
//  09  0E  0B  0D
//  0D  09  0E  0B
//  0B  0D  09  0E





endmodule


module mul_9 (
    input clk,
    input [7:0]data_in,
    output logic [7:0]data_out
    );

logic [7:0] tmp_9_1, tmp_9_2, tmp_9_3;

mul_2 m9_2_1(.clk(clk), .data_in(tmp1),    .data_out(tmp_9_1));
mul_2 m9_2_2(.clk(clk), .data_in(tmp_9_1), .data_out(tmp_9_2));
mul_2 m9_2_3(.clk(clk), .data_in(tmp_9_2), .data_out(tmp_9_3));
assign data_out = tmp_9_3 ^ data_in;
endmodule


module mul_11 (
    input clk,
    input [7:0]data_in,
    output logic [7:0]data_out
    );

logic [7:0] tmp_11_1, tmp_11_2, tmp_11_3, tmp_11_4;

mul_2 m11_2_1(.clk(clk), .data_in(data_in), .data_out(tmp_11_1));
mul_2 m11_2_2(.clk(clk), .data_in(tmp_11_1),.data_out(tmp_11_2));
assign tmp_11_3 = tmp_11_2 ^ data_in;
mul_2 m11_2_3(.clk(clk), .data_in(tmp_11_3),.data_out(tmp_11_4));
assign data_out = tmp_11_4 ^ data_in;
endmodule


module mul_13 (
    input clk,
    input [7:0]data_in,
    output logic [7:0]data_out
    );

logic [7:0] tmp_13_1, tmp_13_2, tmp_13_3, tmp_13_4;

mul_2 m13_2_1(.clk(clk), .data_in(data_in), .data_out(tmp_13_1));
assign tmp_13_2 = tmp_13_1 ^ data_in;
mul_2 m13_2_2(.clk(clk), .data_in(tmp_13_2), .data_out(tmp_13_3));
mul_2 m13_2_3(.clk(clk), .data_in(tmp_13_3), .data_out(tmp_13_4));
assign data_out = tmp_13_4 ^ data_in;
endmodule


module mul_14 (
    input clk,
    input [7:0]data_in,
    output logic [7:0]data_out
    );

logic [7:0] tmp_14_1, tmp_14_2, tmp_14_3, tmp_14_4, tmp_14_5, tmp_14_6; 

mul_2 m14_2_1(.clk(clk), .data_in(data_in), .data_out(tmp_14_1));
assign tmp_14_2 = tmp_14_1 ^ data_in;
mul_2 m14_2_2(.clk(clk), .data_in(tmp_14_2), .data_out(tmp_14_3));
assign tmp_14_4 = tmp_14_3 ^ data_in;
mul_2 m14_2_3(.clk(clk), .data_in(tmp_14_4), .data_out(tmp_14_5));
assign data_out = tmp_14_5;
endmodule
