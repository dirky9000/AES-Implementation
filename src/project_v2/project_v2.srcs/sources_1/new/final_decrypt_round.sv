`timescale 1ns / 1ps

module final_decrypt_round(
    input clk,
    input reset,
    input [127:0]inData,
    input [127:0]key,
    output logic [127:0]outData
    );
    
//inv shift rows
//inv subbytes
//add round key

logic [127:0]invSubOut, invShiftOut;

invShiftRows invshift(.clk(clk), .reset(reset), .data(inData), .dout(invShiftOut));
invSubBytes invsub(.clk(clk), .reset(reset), .data(invShiftOut), .dout(invSubOut));
assign outData = invSubOut^key;

endmodule