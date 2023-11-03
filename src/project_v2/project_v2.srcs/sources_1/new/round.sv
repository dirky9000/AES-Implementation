`timescale 1ns / 1ps

//Subbytes
//shiftrows
//mix columns
//add round key


module round(
    input clk,
    input [127:0]inData,
    input [127:0]key,
    output [127:0]outData
    );
    
//Subbytes
//shiftrows
//mix columns
//add round key

logic [127:0]subOut, shiftOut, mixOut;

subbytes sub(.clk(clk), .data(inData), .dout(subOut));
shiftrows shift(.clk(clk), .data(subOut), .dout(shiftOut));
mixcolumns mix(.clk(clk), .data(shiftOut), .dout(mixOut));
assign outData = key^mixOut;

endmodule
