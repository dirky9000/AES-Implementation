`timescale 1ns / 1ps

module invShiftRows(
    input clk,
    input reset,
    input [127:0] data,
    output logic [127:0] dout
    );

//input data = b0_b1_b2_b3_b4_b5_b6_b7_b8_b9_b10_b11_b12_b13_b14_b15

//  Input matrix        |       Output Matrix 
//  b0  b4  b8  b12     |   b0  b4  b8  b12
//  b1  b5  b9  b13     |   b13 b1  b5  b9
//  b2  b6  b10 b14     |   b10 b14 b2  b6
//  b3  b7  b11 b15     |   b7  b11 b15 b3
//  
//  Data Input                      |   Data Output 
//  127:120  95:88   63:56   31:24  |   127:120  95:88    63:56    31:24
//  119:112  87:80   55:48   23:16  |   23:16    119:112  87:80    55:48
//  111:104  79:72   47:40   15:8   |   47:40    15:8     111:104  79:72
//  103:96   71:64   39:32   7:0    |   71:64    39:32    7:0      103:96
//

always_ff@(posedge clk)
begin
    if(reset)
        dout <= 0;
    else
        dout[127:120]<= data[127:120]; 
        dout[119:112]<= data[23:16]; 
        dout[111:104]<= data[47:40]; 
        dout[103:96] <= data[71:64]; 
        
        dout[95:88]  <= data[95:88]; 
        dout[87:80]  <= data[119:112]; 
        dout[79:72]  <= data[15:8]; 
        dout[71:64]  <= data[39:32]; 
        
        dout[63:56]  <= data[63:56]; 
        dout[55:48]  <= data[87:80]; 
        dout[47:40]  <= data[111:104]; 
        dout[39:32]  <= data[7:0]; 
        
        dout[31:24]  <= data[31:24]; 
        dout[23:16]  <= data[55:48]; 
        dout[15:8]   <= data[79:72]; 
        dout[7:0]    <= data[103:96]; 
end

endmodule
