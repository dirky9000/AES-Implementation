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


endmodule
