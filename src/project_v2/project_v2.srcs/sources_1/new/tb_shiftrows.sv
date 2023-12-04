module tb_shiftrows;

// Signals
reg clk;
reg reset; // Change signal name to reflect active-low convention
reg [7:0] data;
reg [127:0] data_in;
wire [127:0] shiftrows_output;
wire [7:0] sbox_output;

// Instantiate the modules
sbox sbox_inst(
    .data(data),
    .dout(sbox_output)
);

shiftrows shiftrows_inst(
    .clk(clk),
    .reset(reset), // Change signal name to reflect active-low convention
    .data_in(data_in),
    .data_out(shiftrows_output)
);

// Clock generation
initial begin
    clk = 0;
    forever #10 clk = ~clk;  // Using a longer time for clock toggling
end

// Test stimulus
initial begin
    // Initialize inputs
    data = 8'h23;
    data_in = 128'h696C6F766574686973636C6173732121;
    reset = 1; // Change signal name to reflect active-low convention

    // Apply inputs
    #10 reset = 0; // Change signal name to reflect active-low convention
    #10 reset = 1; // Change signal name to reflect active-low convention

    // Monitor outputs for debugging
    $monitor("Time=%0t, data=%h, data_in=%h, sbox_output=%h, shiftrows_output=%h", $time, data, data_in, sbox_output, shiftrows_output);

    // Stop simulation
    #100 $stop;
end

endmodule
