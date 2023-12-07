`timescale 1ns / 1ps

module round(
    input clk,
    input reset,
    input [127:0]inData,
    input [127:0]key,
    output logic [127:0]outData
    );
    
//Subbytes
//shiftrows
//mix columns
//add round key

logic [127:0]subOut, shiftOut, mixOut;

subbytes sub(.clk(clk), .reset(reset), .data(inData), .dout(subOut));
shiftrows shift(.clk(clk), .reset(reset), .data(subOut), .dout(shiftOut));
mixcolumns mix(.clk(clk), .reset(reset), .data(shiftOut), .dout(mixOut));
assign outData = key^mixOut;

endmodule
