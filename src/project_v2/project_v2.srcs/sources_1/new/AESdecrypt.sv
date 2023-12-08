`timescale 1ns / 1ps

module AESdecrypt(
    input [127:0]ciphertextHex,
    input [127:0]key,
    input clk,
    input reset,
    output [127:0]plaintextHex
   );
    
   logic [127:0]data0;
   logic [127:0]key0,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10;
   logic [127:0]result1,result2,result3,result4,result5,result6,result7,result8,result9,result10;
   
//instantiate key_expand
key_expand KeysGen2(
    .clk(clk),
    .key(key),
    .key0(key0),
    .key1(key1),
    .key2(key2),
    .key3(key3),
    .key4(key4),
    .key5(key5),
    .key6(key6),
    .key7(key7),
    .key8(key8),
    .key9(key9),
    .key10(key10)
    );
    
    
//add key10 to cipher (XOR)
assign data0 = key10^ciphertextHex;

d_round d1(.clk(clk), .reset(reset), .inData(data0),   .key(key9), .outData(result1));
d_round d2(.clk(clk), .reset(reset), .inData(result1), .key(key8), .outData(result2));
d_round d3(.clk(clk), .reset(reset), .inData(result2), .key(key7), .outData(result3));
d_round d4(.clk(clk), .reset(reset), .inData(result3), .key(key6), .outData(result4));
d_round d5(.clk(clk), .reset(reset), .inData(result4), .key(key5), .outData(result5));
d_round d6(.clk(clk), .reset(reset), .inData(result5), .key(key4), .outData(result6));
d_round d7(.clk(clk), .reset(reset), .inData(result6), .key(key3), .outData(result7));
d_round d8(.clk(clk), .reset(reset), .inData(result7), .key(key2), .outData(result8));
d_round d9(.clk(clk), .reset(reset), .inData(result8), .key(key1), .outData(result9));

//final round without mixcolumns
final_decrypt_round d10(.clk(clk), .reset(reset), .inData(result9), .key(key0), .outData(plaintextHex));
endmodule

