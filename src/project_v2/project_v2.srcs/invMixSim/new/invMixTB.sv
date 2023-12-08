`timescale 1ns / 1ps

module invMixTB(
    );
    
logic clk;
logic reset;
logic [127:0]invMixInData;
logic [127:0]invMixOutData;

invMixColumns invMix(
    .clk(clk),
    .reset(reset),
    .data(invMixInData),
    .dout(invMixOutData)
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
        invMixInData <= 0;
    else
        invMixInData <= 128'h11c1bea4_789e9e34_1739357d_1fa97ed2;        
end

endmodule
