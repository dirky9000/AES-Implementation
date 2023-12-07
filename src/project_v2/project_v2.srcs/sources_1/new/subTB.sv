`timescale 1ns / 1ps

module subTB();

    logic clk;
    logic reset;
    logic [127:0] testInData;
    logic [127:0] testOutData;
    
    subbytes SubB(
    .clk(clk),
    .reset(reset),
    .data(testInData),
    .dout(testOutData)
    );
    
    
initial begin
    clk = 0;
    while (1)
        #5 clk = ~clk;
end
    
initial begin
    reset = 1;
    #87 reset = 0;
end

always_ff@(posedge clk)
begin
    if(reset)
        testInData <= 0;
    else 
        testInData <= 128'h0123_4567_89ab_cdef_fedc_ba98_7654_3210;
end
    

endmodule