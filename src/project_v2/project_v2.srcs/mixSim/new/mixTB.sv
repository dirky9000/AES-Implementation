`timescale 1ns / 1ps

module mixTB(
    );
    
logic clk;
logic reset;
logic [127:0]mixInData; 
logic [127:0]mixOutData;

mixcolumns Mix(
    .clk(clk),
    .reset(reset),
    .data(mixInData),
    .dout(mixOutData)
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
        mixInData <= 0;
    else
        mixInData <= 128'h0123_4567_89ab_cdef_fedc_ba98_7654_3210;        
end




endmodule
