`timescale 1ns / 1ps

module mixcolumns(
    input clk,
    input [127:0]data,
    output [127:0]dout
    );
    
endmodule

/* maybe ???
`timescale 1ns / 1ps

module mixcolumns(
    input clk,
    input [127:0] data,
    output reg [127:0] dout
);

    // Internal state for each column
    reg [7:0] col0, col1, col2, col3,
              col4, col5, col6, col7,
              col8, col9, col10, col11,
              col12, col13, col14, col15;

    // MixColumns matrix
    reg [7:0] c2 = 8'h02;
    reg [7:0] c3 = 8'h03;

    always @* begin
        // MixColumns transformation for each column
        col0 = (c2 ^ c3) & data[7:0] ^ c2 & data[15:8] ^ data[23:16] ^ data[31:24];
        col1 = c3 & data[7:0] ^ (c2 ^ c3) & data[15:8] ^ c2 & data[23:16] ^ data[31:24];
        col2 = data[7:0] ^ c3 & data[15:8] ^ (c2 ^ c3) & data[23:16] ^ c2 & data[31:24];
        col3 = data[15:8] ^ c3 & data[23:16] ^ (c2 ^ c3) & data[31:24] ^ c2 & data[7:0];

        col4 = c2 & data[39:32] ^ c3 & data[47:40] ^ data[55:48] ^ data[63:56];
        col5 = data[39:32] ^ c3 & data[47:40] ^ (c2 ^ c3) & data[55:48] ^ c2 & data[63:56];
        col6 = data[47:40] ^ c3 & data[55:48] ^ (c2 ^ c3) & data[63:56] ^ c2 & data[39:32];
        col7 = data[55:48] ^ c3 & data[63:56] ^ (c2 ^ c3) & data[39:32] ^ c2 & data[47:40];

        col8 = c2 & data[71:64] ^ c3 & data[79:72] ^ data[87:80] ^ data[95:88];
        col9 = data[71:64] ^ c3 & data[79:72] ^ (c2 ^ c3) & data[87:80] ^ c2 & data[95:88];
        col10 = data[79:72] ^ c3 & data[87:80] ^ (c2 ^ c3) & data[95:88] ^ c2 & data[71:64];
        col11 = data[87:80] ^ c3 & data[95:88] ^ (c2 ^ c3) & data[71:64] ^ c2 & data[79:72];

        col12 = c2 & data[103:96] ^ c3 & data[111:104] ^ data[119:112] ^ data[127:120];
        col13 = data[103:96] ^ c3 & data[111:104] ^ (c2 ^ c3) & data[119:112] ^ c2 & data[127:120];
        col14 = data[111:104] ^ c3 & data[119:112] ^ (c2 ^ c3) & data[127:120] ^ c2 & data[103:96];
        col15 = data[119:112] ^ c3 & data[127:120] ^ (c2 ^ c3) & data[103:96] ^ c2 & data[111:104];
    end

    // Concatenate the columns to form the output
    always @* begin
        dout = {col0, col1, col2, col3, col4, col5, col6, col7,
                col8, col9, col10, col11, col12, col13, col14, col15};
    end

endmodule
*/