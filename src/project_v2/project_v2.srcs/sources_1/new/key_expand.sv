`timescale 1ns / 1ps

module key_expand(
    input [127:0]key,
    input clk,
    input reset,
    output logic [127:0]key0,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10
    );

//32 bit words for keys Left -> Right go from Low -> High number
// Ex. Key0 = w0_w1_w2_w3
logic [31:0] w0, w1, w2, w3;        //Key0 (original)
logic [31:0] w4, w5, w6, w7;        //Key1
logic [31:0] w8, w9, w10, w11;      //Key2
logic [31:0] w12, w13, w14, w15;    //Key3
logic [31:0] w16, w17, w18, w19;    //Key4
logic [31:0] w20, w21, w22, w23;    //Key5
logic [31:0] w24, w25, w26, w27;    //Key6
logic [31:0] w28, w29, w30, w31;    //Key7
logic [31:0] w32, w33, w34, w35;    //Key8
logic [31:0] w36, w37, w38, w39;    //Key9
logic [31:0] w40, w41, w42, w43;    //Key10

// Round constants
logic [7:0]rcon1 = 8'h01; 
logic [7:0]rcon2 = 8'h02;   
logic [7:0]rcon3 = 8'h04;
logic [7:0]rcon4 = 8'h08;
logic [7:0]rcon5 = 8'h10;
logic [7:0]rcon6 = 8'h20;
logic [7:0]rcon7 = 8'h40;
logic [7:0]rcon8 = 8'h80;
logic [7:0]rcon9 = 8'h1B;
logic [7:0]rcon10 = 8'h36;

logic [31:0] subw1, subw2, subw3, subw4, subw5, subw6, subw7, subw8, subw9, subw10;


//sbox instances Round constant part
sbox s3_0(w3[23:16],    subw1[31:24]);
sbox s3_1(w3[15:8],     subw1[23:16]);
sbox s3_2(w3[7:0],      subw1[15:8]);
sbox s3_3(w3[31:24],    subw1[7:0]);

sbox s7_0(w7[23:16],    subw2[31:24]);
sbox s7_1(w7[15:8],     subw2[23:16]);
sbox s7_2(w7[7:0],      subw2[15:8]);
sbox s7_3(w7[31:24],    subw2[7:0]);

sbox s11_0(w11[23:16],  subw3[31:24]);
sbox s11_1(w11[15:8],   subw3[23:16]);
sbox s11_2(w11[7:0],    subw3[15:8]);
sbox s11_3(w11[31:24],  subw3[7:0]);

sbox s15_0(w15[23:16],  subw4[31:24]);
sbox s15_1(w15[15:8],   subw4[23:16]);
sbox s15_2(w15[7:0],    subw4[15:8]);
sbox s15_3(w15[31:24],  subw4[7:0]);

sbox s19_0(w19[23:16],  subw5[31:24]);
sbox s19_1(w19[15:8],   subw5[23:16]);
sbox s19_2(w19[7:0],    subw5[15:8]);
sbox s19_3(w19[31:24],  subw5[7:0]);

sbox s23_0(w23[23:16],  subw6[31:24]);
sbox s23_1(w23[15:8],   subw6[23:16]);
sbox s23_2(w23[7:0],    subw6[15:8]);
sbox s23_3(w23[31:24],  subw6[7:0]);

sbox s27_0(w27[23:16],  subw7[31:24]);
sbox s27_1(w27[15:8],   subw7[23:16]);
sbox s27_2(w27[7:0],    subw7[15:8]);
sbox s27_3(w27[31:24],  subw7[7:0]);

sbox s31_0(w31[23:16],  subw8[31:24]);
sbox s31_1(w31[15:8],   subw8[23:16]);
sbox s31_2(w31[7:0],    subw8[15:8]);
sbox s31_3(w31[31:24],  subw8[7:0]);

sbox s35_0(w35[23:16],  subw9[31:24]);
sbox s35_1(w35[15:8],   subw9[23:16]);
sbox s35_2(w35[7:0],    subw9[15:8]);
sbox s35_3(w35[31:24],  subw9[7:0]);

sbox s39_0(w39[23:16],  subw10[31:24]);
sbox s39_1(w39[15:8],   subw10[23:16]);
sbox s39_2(w39[7:0],    subw10[15:8]);
sbox s39_3(w39[31:24],  subw10[7:0]);

always_ff@(posedge clk)
begin
    if(reset)
    begin
        key0 <= 0;
        key1 <= 0;
        key2 <= 0;
        key3 <= 0;
        key4 <= 0;
        key5 <= 0;
        key6 <= 0;
        key7 <= 0;
        key8 <= 0;
        key9 <= 0;
        key10 <= 0;
    end
    else
        w0 = key[127:96];
        w1 = key[95:64];
        w2 = key[63:32];
        w3 = key[31:0];
        
        w4 = w0^subw1^{rcon1,24'b0};
        w5 = w1^w4;
        w6 = w2^w5;
        w7 = w3^w6;
        
        w8 = w4^subw2^{rcon2,24'b0};
        w9 = w5^w8;
        w10 = w6^w9; 
        w11 = w7^w10;
        
        w12 = w8^subw3^{rcon3,24'b0};
        w13 = w9^w12;
        w14 = w10^w13;
        w15 = w11^w14;
        
        w16 = w12^subw4^{rcon4,24'b0};
        w17 = w13^w16;
        w18 = w14^w17;
        w19 = w15^w18;
        
        w20 = w16^subw5^{rcon5,24'b0};
        w21 = w17^w20;
        w22 = w18^w21;
        w23 = w19^w22;
        
        w24 = w20^subw6^{rcon6,24'b0};
        w25 = w21^w24;
        w26 = w22^w25;
        w27 = w23^w26;
        
        w28 = w24^subw7^{rcon7,24'b0};
        w29 = w25^w28;
        w30 = w26^w29;
        w31 = w27^w30;
        
        w32 = w28^subw8^{rcon8,24'b0};
        w33 = w29^w32;
        w34 = w30^w33;
        w35 = w31^w34;
        
        w36 = w32^subw9^{rcon9,24'b0};
        w37 = w33^w36;
        w38 = w34^w37;
        w39 = w35^w38;

        w40 = w36^subw10^{rcon10,24'b0};
        w41 = w37^w40;
        w42 = w38^w41;
        w43 = w39^w42;
end

assign key0  = {w0,w1,w2,w3};
assign key1  = {w4,w5,w6,w7};
assign key2  = {w8,w9,w10,w11};
assign key3  = {w12,w13,w14,w15};
assign key4  = {w16,w17,w18,w19};
assign key5  = {w20,w21,w22,w23};
assign key6  = {w24,w25,w26,w27};
assign key7  = {w28,w29,w30,w31};
assign key8  = {w32,w33,w34,w35};
assign key9  = {w36,w37,w38,w39};
assign key10 = {w40,w41,w42,w43};

endmodule
