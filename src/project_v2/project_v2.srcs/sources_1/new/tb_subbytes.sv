`timescale 1ns / 1ps

module tb_subbytes;

    reg clk;
    reg [127:0] data;
    wire [127:0] s_data_out;

    subbytes subbytes_inst (
        .clk(clk),
        .data(data),
        .s_data_out(s_data_out)
    );

    initial begin
        // Initialize clock
        clk = 0;

        // Apply stimulus
        data = 128'h696C6F766574686973636C6173732121;

        // Toggle clock and apply input
        #5 clk = 1;
        #5 clk = 0;

        // Check the output
        $display("s_data_out: %h", s_data_out);

        // End simulation
        $finish;
    end

    always #1 clk = ~clk;

endmodule
