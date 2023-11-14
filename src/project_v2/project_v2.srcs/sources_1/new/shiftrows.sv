`timescale 1ns / 1ps

module shiftrows(
    input clk,
    input [127:0] data,
    output reg [127:0] dout
);

    // Internal state for each row
    reg [31:0] row0, row1, row2, row3;

    always @(posedge clk) begin
        // Row 0: No shift
        row0 <= data[95:64];

        // Row 1: Shift one position to the left
        row1 <= {data[55:32], data[31:0]};

        // Row 2: Shift two positions to the left
        row2 <= {data[23:0], data[63:32]};

        // Row 3: Shift three positions to the left
        row3 <= {data[7:0], data[39:8]};
    end

    // Concatenate the rows to form the output
    always @* begin
        dout = {row0, row1, row2, row3};
    end

endmodule

/*
`timescale 1ns / 1ps

module tb_shiftrows();

    // Inputs
    reg clk;
    reg [127:0] data;

    // Outputs
    wire [127:0] dout;

    // Instantiate the shiftrows module
    shiftrows uut (
        .clk(clk),
        .data(data),
        .dout(dout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Initialize input data
        data = 128'h0123456789ABCDEF0123456789ABCDEF;

        // Apply stimulus for a few clock cycles
        #10 data = 128'hFEDCBA9876543210FEDCBA9876543210;
        #10 data = 128'h87654321FEDCBA9087654321FEDCBA90;
        #10 data = 128'h45678901ABCDEF2345678901ABCDEF23;

        // Add more test cases if needed

        // Stop simulation
        #10 $finish;
    end

    // Monitor to display results
    always @(posedge clk) begin
        $display("Time %0t: data = %h, dout = %h", $time, data, dout);
    end

endmodule
*/