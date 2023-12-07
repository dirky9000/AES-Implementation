`timescale 1ns / 1ps

module shiftTB();
    
    logic clk;
    logic reset;
    logic [127:0] shiftInData;
    logic [127:0] shiftOutData;
    
    shiftrows Shift(
    .clk(clk),
    .reset(reset),
    .data(shiftInData),
    .dout(shiftOutData)
    );

initial begin
    clk = 0;
    while(1)
        #5 clk = ~clk;
end

initial begin
    reset = 1;
    #87 reset = 0;
end

always_ff@(posedge clk)
begin
    if(reset)
        shiftInData <= 0;
    else 
        shiftInData <= 128'h0123_4567_89ab_cdef_fedc_ba98_7654_3210;
end

endmodule