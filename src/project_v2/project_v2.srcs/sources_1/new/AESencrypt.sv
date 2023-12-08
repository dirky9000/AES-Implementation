`timescale 1ns / 1ps

module AESencrypt(
    input [127:0]plaintextHex,
    input [127:0]key,
    input clk,
    input reset,
    output [127:0] ciphertextHex
   );
     
   logic [127:0]data;
   logic [127:0]key0,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10;
   logic [127:0]result1,result2,result3,result4,result5,result6,result7,result8,result9;
     
//instantiate key_expand
key_expand KeysGen(
    .clk(clk),
    .reset(reset),
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

//add initial key to plaintext (XOR)
assign data = key0^plaintextHex;

e_round e_r1(.clk(clk), .reset(reset), .inData(data),    .key(key1), .outData(result1));
e_round e_r2(.clk(clk), .reset(reset), .inData(result1), .key(key2), .outData(result2));
e_round e_r3(.clk(clk), .reset(reset), .inData(result2), .key(key3), .outData(result3));
e_round e_r4(.clk(clk), .reset(reset), .inData(result3), .key(key4), .outData(result4));
e_round e_r5(.clk(clk), .reset(reset), .inData(result4), .key(key5), .outData(result5));
e_round e_r6(.clk(clk), .reset(reset), .inData(result5), .key(key6), .outData(result6));
e_round e_r7(.clk(clk), .reset(reset), .inData(result6), .key(key7), .outData(result7));
e_round e_r8(.clk(clk), .reset(reset), .inData(result7), .key(key8), .outData(result8));
e_round e_r9(.clk(clk), .reset(reset), .inData(result8), .key(key9), .outData(result9));

final_encrypt_round e_r10(.clk(clk), .reset(reset), .inData(result9), .key(key10), .outData(ciphertextHex));


endmodule