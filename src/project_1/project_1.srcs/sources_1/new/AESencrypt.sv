`timescale 1ns / 1ps

module AESencrypt(
      input [127:0]plaintext,
      input [127:0]key,
      input clk,
      input reset,
      output [127:0]outCipher
     );
     
   logic data0;
   logic inByte;
   logic outByte;
   logic [127:0]key0,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10;
   logic [127:0]result1,result2,result3,result4,result5,result6,result7,result8,result9,result10;
//instantiate SBOX
sbox sbox(
    .data(inByte),
    .dout(outByte)
    );

//instantiate key_expand
key_expand keyexpand(
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

//add initial key to plaintext
assign data0 = key^plaintext;

round e1(.clk(clk), .inData(data0), .key(key0), .outData(result1));
round e2(.clk(clk), .inData(result1), .key(key1), .outData(result2));
round e3(.clk(clk), .inData(result2), .key(key2), .outData(result3));
round e4(.clk(clk), .inData(result3), .key(key3), .outData(result4));
round e5(.clk(clk), .inData(result4), .key(key4), .outData(result5));
round e6(.clk(clk), .inData(result5), .key(key5), .outData(result6));
round e7(.clk(clk), .inData(result6), .key(key6), .outData(result7));
round e8(.clk(clk), .inData(result7), .key(key7), .outData(result8));
round e9(.clk(clk), .inData(result8), .key(key8), .outData(result9));
round e10(.clk(clk), .inData(result9), .key(key9), .outData(outCipher));


endmodule