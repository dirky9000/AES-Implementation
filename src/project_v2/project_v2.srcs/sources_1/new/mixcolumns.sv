`timescale 1ns / 1ps

module mixcolumns(
    input clk,
    input reset,
    input [127:0]data,
    output logic [127:0]dout
    );
//              127:120 ----------------------------------------- 7:0
//input data  = b0_b1_b2_b3_b4_b5_b6_b7_b8_b9_b10_b11_b12_b13_b14_b15

// Mixcolumns matrix       Data input matrix
//  
//   2 3 1 1                127:120  95:88   63:56   31:24    
//   1 2 3 1                119:112  87:80   55:48   23:16
//   1 1 2 3                111:104  79:72   47:40   15:8
//   3 1 1 2                103:96   71:65   39:32   7:0
//

always_ff@(posedge clk)
begin
    if(reset)
        dout <= 0;
    else
    //column 1 
    dout[127:120]  = (data[127:120]<<1) ^ ((data[119:112]<<1)^data[119:112]) ^ data[111:104] ^ data[103:96]; // 2 3 1 1  CORRECT
    dout[119:112] =  data[127:120] ^ (data[119:112]<<1) ^ ((data[111:104]<<1)^data[111:104]) ^ data[103:96]; // 1 2 3 1  CORRECT
    dout[111:104]=  data[127:120] ^ data[119:112] ^ (data[111:104]<<1) ^ ((data[103:96]<<1) ^ data[103:96]); // 1 1 2 3  WRONG
    dout[103:96]=  ((data[127:120]<<1)^data[127:120]) ^ data[119:112] ^ data[111:104] ^ (data[103:96]<<1);   // 3 1 1 2  WRONG
    
    //column 2 
    dout[95:88]= (data[95:88]<<1) ^ ((data[87:80]<<1)^data[87:80]) ^ data[79:72] ^ data[71:65]; //CORRECT
    dout[87:80]=  data[95:88] ^ (data[87:80]<<1) ^ ((data[79:72]<<1)^data[79:72]) ^ data[71:65];//CORRECT
    dout[79:72]=  data[95:88] ^ data[87:80] ^ (data[79:72]<<1) ^ ((data[71:65]<<1) ^ data[71:65]);//WRONG
    dout[71:65]= ((data[95:88]<<1)^data[95:88]) ^ data[87:80] ^ data[79:72] ^ (data[71:65]<<1); //WRONG
    
    //column 3 
    dout[63:56]= (data[63:56]<<1) ^ ((data[55:48]<<1)^data[55:48]) ^ data[47:40] ^ data[39:32];//WRONG
    dout[55:48]= data[63:56] ^ (data[55:48]<<1) ^ ((data[47:40]<<1)^data[47:40]) ^ data[39:32];//WRONG
    dout[47:40]= data[63:56] ^ data[55:48] ^ (data[47:40]<<1) ^ ((data[39:32]<<1) ^ data[39:32]);//WRONG
    dout[39:32]= ((data[63:56]<<1)^data[63:56]) ^ data[55:48] ^ data[47:40] ^ (data[39:32]<<1); //WRONG
    
    //column 4 
    dout[31:24] = (data[31:24]<<1) ^ ((data[23:16]<<1)^data[23:16]) ^ data[15:8] ^ data[7:0];//WRONG
    dout[23:16]= data[31:24] ^ (data[23:16]<<1) ^ ((data[15:8]<<1)^data[15:8]) ^ data[7:0];//WRONG
    dout[15:8]= data[31:24] ^ data[23:16] ^ (data[15:8]<<1) ^ ((data[7:0]<<1) ^ data[7:0]);//CORRECT
    dout[7:0]= ((data[31:24]<<1)^data[31:24]) ^ data[23:16] ^ data[15:8] ^ (data[7:0]<<1); //CORRECT

end


endmodule