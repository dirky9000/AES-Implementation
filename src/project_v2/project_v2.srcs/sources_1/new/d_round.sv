`timescale 1ns / 1ps

module d_round(
    input clk,
    input reset,
    input [127:0]inData,
    input [127:0]key,
    output logic [127:0]outData
    );
    
//Inv Shift Rows
//Inv SubBytes
//Add Round Key
//Inv MixColumns

logic [127:0]invSubOut, invShiftOut, invMixOut, invMixIn;

invShiftRows invshift(.clk(clk), .reset(reset), .data(inData), .dout(invShiftOut));
invSubBytes invsub(.clk(clk), .reset(reset), .data(invShiftOut), .dout(invSubOut));
assign invMixIn = invSubOut^key;
invMixColumns invmix(.clk(clk), .reset(reset), .data(invMixIn), .dout(outData));

endmodule