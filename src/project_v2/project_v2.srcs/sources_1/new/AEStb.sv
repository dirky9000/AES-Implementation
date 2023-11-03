`timescale 1ns / 1ps

//Find SystemVerilog LRN online to look for string to hex $functions
// TestStringPlain1
//`define PLAINTEXT_INPUT (128'h54657374537472696E67506C61696E31)

// TestCipherInput1
//`define CIPHERTEXT_INPUT (128'h54657374436970686572496E70757431)

// KeyKeyKeyKeyKey1
//`define KEY_SAMPLE (128'h4B65794B65794B65794B65794B657931)

module AEStb(
    );
    
    logic [127:0]plaintext;
    logic [127:0]ciphertext;
    logic [127:0]key;
    logic [127:0]outCipher;
    logic [127:0]outPlain;
    logic [1:0]mode;
    logic clk;
    logic reset;
    logic reset_n;
    logic start;
    logic busy;

assign reset = ~reset_n;
assign plaintext = 128'h54657374537472696E67506C61696E31;
assign ciphertext = 128'h54657374436970686572496E70757431;
assign key = 128'h4B65794B65794B65794B65794B657931;

//instantiate AESmain module
AESmain MainBlock(
    .plaintext(plaintext),
    .ciphertext(ciphertext),
    .key(key),
    .mode(mode),
    .clk(clk),
    .reset(reset),
    .start(start),
    .outCipher(outCipher),
    .outPlain(outPlain),
    .busy(busy)
    );

//initial begin stuff
initial begin
    clk = 0;
    while(1)
        #5 clk = ~clk;
end

initial begin
    reset_n = 0;
    #87 reset_n = 1;
end
//awlays blocks


endmodule