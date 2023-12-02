`timescale 1ns / 1ps

module tb;

// Signals
reg clk;
reg [7:0] data;
reg [127:0] data_in;
wire [127:0] shiftrows_output;

// Instantiate the modules
sbox sbox_inst(
    .data(data)
);

shiftrows shiftrows_inst(
    .clk(clk),
    .data_in(data_in),
    .data_out(shiftrows_output)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Using a default time for clock toggling
end

// Test stimulus
initial begin
    // Initialize inputs
    data = 8'h23;
    data_in = 128'h696C6F766574686973636C6173732121;

    // Apply inputs and monitor outputs
    repeat (20) begin
        #5 data = data + 1; // Change input data
    end

    // Stop simulation
    $stop;
end

endmodule
