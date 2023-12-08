`timescale 1ns / 1ps

module AESdecrypt(
    input [127:0]ciphertext,
    input [127:0]key,
    input clk,
    input reset,
    output [127:0]outPlain
   );
    
   logic [127:0]data0;
   logic [7:0]inByte;
   logic [7:0]outByte;
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
assign data0 = key10^ciphertext;

d_round d1(.clk(clk), .inData(data0),   .key(key9), .outData(result1));
d_round d2(.clk(clk), .inData(result1), .key(key8), .outData(result2));
d_round d3(.clk(clk), .inData(result2), .key(key7), .outData(result3));
d_round d4(.clk(clk), .inData(result3), .key(key6), .outData(result4));
d_round d5(.clk(clk), .inData(result4), .key(key5), .outData(result5));
d_round d6(.clk(clk), .inData(result5), .key(key4), .outData(result6));
d_round d7(.clk(clk), .inData(result6), .key(key3), .outData(result7));
d_round d8(.clk(clk), .inData(result7), .key(key2), .outData(result8));
d_round d9(.clk(clk), .inData(result8), .key(key1), .outData(result9));

//final round without mixcolumns
final_decrypt_round d10(.clk(clk), .inData(result9), .key(key1), .outData(outPlain));
endmodule

