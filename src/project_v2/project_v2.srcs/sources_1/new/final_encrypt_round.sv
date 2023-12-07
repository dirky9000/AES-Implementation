`timescale 1ns / 1ps

module final_encrypt_round(
    input clk,
    input reset,
    input [127:0]inData,
    input [127:0]key,
    output logic [127:0]outData
    );
    
//Subbytes
//shiftrows
//add round key

logic [127:0]subOut, shiftOut;

subbytes sub(.clk(clk), .reset(reset), .data(inData), .dout(subOut));
shiftrows shift(.clk(clk), .reset(reset), .data(subOut), .dout(shiftOut));
assign outData = key^shiftOut;

endmodule
