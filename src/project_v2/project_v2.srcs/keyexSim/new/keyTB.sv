`timescale 1ns / 1ps

module keyTB(
    );
    
    
logic clk;
logic reset;
logic [127:0] keyInput;
logic [127:0] key0out, key1out, key2out, key3out, key4out, key5out, key6out, key7out, key8out, key9out, key10out;

key_expand Keys(
    .clk(clk),
    .reset(reset),
    .key(keyInput),
    .key0(key0out),
    .key1(key1out),
    .key2(key2out),
    .key3(key3out),
    .key4(key4out),
    .key5(key5out),
    .key6(key6out),
    .key7(key7out),
    .key8(key8out),
    .key9(key9out),
    .key10(key10out)
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
        keyInput <= 0;
    else
        keyInput <= 128'h53_65_63_72_65_74_4B_65_79_41_6C_65_78_44_21_21;        
end
    
endmodule
