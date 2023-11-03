`timescale 1ns / 1ps

module AESmain(
    input [127:0]plaintext,
    input [127:0]ciphertext,
    input [127:0]key,
    input [1:0]mode,
    input clk,
    input reset,
    input start,
    output [127:0]outCipher,
    output [127:0]outPlain,
    output busy
    );
    
//instantiate Encryption Module
AESencrypt encrypt(
    .plaintext(plaintext),
    .key(key),
    .clk(clk),
    .reset(reset),
    .outCipher(outCipher)
    );
    
//instantiate Decryption Module
AESdecrypt decrypt(
    .ciphertext(ciphertext),
    .key(key),
    .clk(clk),
    .reset(reset),
    .outPlain(outPlain)
    );



endmodule
