`timescale 1ns / 1ps

module invMixColumns(
    input clk,
    input reset,
    input [127:0]data,
    output logic [127:0]dout
    );
    
//  Multiplication Matrix
//  
//  0E  0B  0D  09
//  09  0E  0B  0D
//  0D  09  0E  0B
//  0B  0D  09  0E

logic  [31:0] n1,n2,n3,n4;
logic  [31:0] n_tmp_out1, n_tmp_out2, n_tmp_out3, n_tmp_out4;

assign n1 = data[127:96];
assign n2 = data[95:64];
assign n3 = data[63:32];
assign n4 = data[31:0];

mul_9_thru_14 m1 (clk,n1,n_tmp_out1);
mul_9_thru_14 m2 (clk,n2,n_tmp_out2);
mul_9_thru_14 m3 (clk,n3,n_tmp_out3);
mul_9_thru_14 m4 (clk,n4,n_tmp_out4);

assign dout={n_tmp_out1,n_tmp_out2,n_tmp_out3,n_tmp_out4};

endmodule


module mul_9 (
    input clk,
    input [7:0]data_in,
    output logic [7:0]data_out
    );

logic [7:0] tmp_9_1, tmp_9_2, tmp_9_3;

mul_2 m9_2_1(.clk(clk), .data_in(data_in),    .data_out(tmp_9_1));
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

module mul_9_thru_14 (
    input clk,
    input [31:0]m_data_in,
    output logic [31:0]m_data_out
    );

logic [7:0] tmp1, tmp2, tmp3, tmp4;
logic [7:0] ma0, ma1, ma2, ma3;

logic [7:0] m9_tmp_out1, m9_tmp_out2, m9_tmp_out3, m9_tmp_out4;
logic [7:0] m11_tmp_out1, m11_tmp_out2, m11_tmp_out3, m11_tmp_out4;
logic [7:0] m13_tmp_out1, m13_tmp_out2, m13_tmp_out3, m13_tmp_out4;
logic [7:0] m14_tmp_out1, m14_tmp_out2, m14_tmp_out3, m14_tmp_out4;

assign tmp1=m_data_in[31:24];
assign tmp2=m_data_in[23:16];
assign tmp3=m_data_in[15:8];
assign tmp4=m_data_in[7:0];

begin
mul_9 m1  (.clk(clk), .data_in(tmp1), .data_out(m9_tmp_out1) );
mul_9 m2  (.clk(clk), .data_in(tmp2), .data_out(m9_tmp_out2) );
mul_9 m3  (.clk(clk), .data_in(tmp3), .data_out(m9_tmp_out3) );
mul_9 m4  (.clk(clk), .data_in(tmp4), .data_out(m9_tmp_out4) );

mul_11 m5 (.clk(clk), .data_in(tmp1), .data_out(m11_tmp_out1) );
mul_11 m6 (.clk(clk), .data_in(tmp2), .data_out(m11_tmp_out2) );
mul_11 m7 (.clk(clk), .data_in(tmp3), .data_out(m11_tmp_out3) );
mul_11 m8 (.clk(clk), .data_in(tmp4), .data_out(m11_tmp_out4) );

mul_13 m9 (.clk(clk), .data_in(tmp1), .data_out(m13_tmp_out1) );
mul_13 m10(.clk(clk), .data_in(tmp2), .data_out(m13_tmp_out2) );
mul_13 m11(.clk(clk), .data_in(tmp3), .data_out(m13_tmp_out3) );
mul_13 m12(.clk(clk), .data_in(tmp4), .data_out(m13_tmp_out4) );

mul_14 m13(.clk(clk), .data_in(tmp1), .data_out(m14_tmp_out1) );
mul_14 m14(.clk(clk), .data_in(tmp2), .data_out(m14_tmp_out2) );
mul_14 m15(.clk(clk), .data_in(tmp3), .data_out(m14_tmp_out3) );
mul_14 m16(.clk(clk), .data_in(tmp4), .data_out(m14_tmp_out4) );
end

assign ma0 =  m14_tmp_out1 ^ m11_tmp_out2 ^ m13_tmp_out3 ^ m9_tmp_out4;
assign ma1 =  m9_tmp_out1  ^ m14_tmp_out2 ^ m11_tmp_out3 ^ m13_tmp_out4;
assign ma2 =  m13_tmp_out1 ^ m9_tmp_out2 ^ m14_tmp_out3 ^ m11_tmp_out4;
assign ma3 =  m11_tmp_out1 ^ m13_tmp_out2 ^ m9_tmp_out3 ^ m14_tmp_out4;

assign m_data_out = {ma0,ma1,ma2,ma3};
endmodule
