`timescale 1ns / 1ps

module subbytes(
    input clk,
    input [127:0] data,
    output reg [127:0] dout
);

    // Internal state for each byte
    reg [7:0] byte0, byte1, byte2, byte3,
              byte4, byte5, byte6, byte7,
              byte8, byte9, byte10, byte11,
              byte12, byte13, byte14, byte15;

    // Instantiate the sbox module for each byte
    sbox sbox0 (.data(data[7:0]), .dout(byte0));
    sbox sbox1 (.data(data[15:8]), .dout(byte1));
    sbox sbox2 (.data(data[23:16]), .dout(byte2));
    sbox sbox3 (.data(data[31:24]), .dout(byte3));
    sbox sbox4 (.data(data[39:32]), .dout(byte4));
    sbox sbox5 (.data(data[47:40]), .dout(byte5));
    sbox sbox6 (.data(data[55:48]), .dout(byte6));
    sbox sbox7 (.data(data[63:56]), .dout(byte7));
    sbox sbox8 (.data(data[71:64]), .dout(byte8));
    sbox sbox9 (.data(data[79:72]), .dout(byte9));
    sbox sbox10 (.data(data[87:80]), .dout(byte10));
    sbox sbox11 (.data(data[95:88]), .dout(byte11));
    sbox sbox12 (.data(data[103:96]), .dout(byte12));
    sbox sbox13 (.data(data[111:104]), .dout(byte13));
    sbox sbox14 (.data(data[119:112]), .dout(byte14));
    sbox sbox15 (.data(data[127:120]), .dout(byte15));

    // Concatenate the bytes to form the output
    always @* begin
        dout = {byte0, byte1, byte2, byte3, byte4, byte5, byte6, byte7,
                byte8, byte9, byte10, byte11, byte12, byte13, byte14, byte15};
    end

endmodule

/*
`timescale 1ns / 1ps

module tb_subbytes;

    // Inputs
    reg clk;
    reg [127:0] data;

    // Outputs
    wire [127:0] dout;

    // Instantiate the subbytes module
    subbytes uut (
        .clk(clk),
        .data(data),
        .dout(dout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        data = 128'h0123456789abcdef0123456789abcdef;

        // Apply some initial delay
        #10;

        // Display initial values
        $display("Time = %0t, Input = %h", $time, data);

        // Apply stimulus and display results
        // You can modify the data values as needed for your testing
        // For simplicity, we're not applying a comprehensive test here
        data = 128'h112233445566778899aabbccddeeff0;
        #10;
        $display("Time = %0t, Output = %h", $time, dout);

        // Add more test cases as needed

        // Finish the simulation after a certain time
        #10;
        $finish;
    end

endmodule
*/