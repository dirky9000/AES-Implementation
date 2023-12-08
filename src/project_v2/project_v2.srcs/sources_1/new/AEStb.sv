`timescale 1ns / 1ps

module AEStb(
    );
    
    logic [127:0]plaintextInput;
    logic [127:0]ciphertextInput;
    logic [127:0]keyInput;
    logic [127:0]outCipher;
    logic [127:0]outPlain;
    logic [1:0]mode;
    logic clk;
    logic reset;
    logic start;
    logic busy;

AESmain MainBlock(
    .clk(clk),
    .reset(reset),
    .plaintextInput(plaintextInput),
    .key(keyInput),
    .ciphertextInput(ciphertextInput),
    .mode(mode),
    .start(start),
    .encryptedOutput(outCipher),
    .decryptedOutput(outPlain),
    .busy(busy)
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

initial begin
    start = 0;
    #100 start = 1;
end


always_ff@(posedge clk)
begin
    if(reset)
    begin
        plaintextInput <= 0;
        ciphertextInput <= 0;
        keyInput <= 0;
    end
    else
    begin
        plaintextInput = "testEncryptAlexD";
        ciphertextInput = 128'h63a2dabeddb7ba72a8df33bc7aaac091;
        keyInput = "SecretKeyAlexD!!";
        mode <= 2'b11;
    end
end

endmodule