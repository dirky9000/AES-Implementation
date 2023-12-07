module shiftrows (
    input clk,
    input reset,
    input [127:0]data,
    output logic [127:0]dout
    );

// input data     |  output dout
// b0 b4 b8  b12  |  b0  b4  b8  b12
// b1 b5 b9  b13  |  b5  b9  b13 b1
// b2 b6 b10 b14  |  b10 b14 b2  b6
// b3 b7 b11 b15  |  b15 b3  b7  b11

//input data  = b15_b14_b13_b12_b11_b10_b9__b8_b7_b6__b5_b4_b3__b2__b1_b0
//output dout = b11_b6__b1__b12_b7__b2__b13_b8_b3_b14_b9_b4_b15_b10_b5_b0

always_ff@(posedge clk)
begin
    if(reset)
        dout <= 0;
    else
        dout[7:0]     <= data[7:0];     //b0 <= b0
        dout[15:8]    <= data[47:40];   //b1 <= b5
        dout[23:16]   <= data[87:80];   //b2 <= b10
        dout[31:24]   <= data[127:120]; //b3 <= b15
        dout[39:32]   <= data[39:32];   //b4 <= b4
        dout[47:40]   <= data[79:72];   //b5 <= b9
        dout[55:48]   <= data[119:112]; //b6 <= b14
        dout[63:56]   <= data[31:24];   //b7 <= b3    
        dout[71:64]   <= data[71:64];   //b8 <= b8
        dout[79:72]   <= data[111:104]; //b9 <= b13
        dout[87:80]   <= data[23:16];   //b10 <= b2
        dout[95:88]   <= data[63:56];   //b11 <= b7
        dout[103:96]  <= data[103:96];  //b12 <= b12
        dout[111:104] <= data[15:8];    //b13 <= b1
        dout[119:112] <= data[55:48];   //b14 <= b6
        dout[127:120] <= data[95:88];   //b15 <= b11
end

endmodule
