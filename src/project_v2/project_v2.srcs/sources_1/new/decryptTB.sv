`timescale 1ns / 1ps

module decryptTB(
    );
    
logic clk;
logic reset;
logic [127:0] plaintextOutput;
logic [127:0] ciphertextInput;
logic [127:0] secretKeyHex;

AESdecrypt DecryptBlock(
    .clk(clk),
    .reset(reset),
    .key(secretKeyHex),
    .ciphertext(ciphertextInput),
    .outPlain(plaintextOutput)
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
        begin
            ciphertextInput <= 0;
            secretKeyHex <= 0;
        end
    else
        begin
            ciphertextInput <= 128'h63a2dabe_ddb7ba72_a8df33bc_7aaac091; //encoded result after encrypting testEncryptAlexD
            secretKeyHex <= "SecretKeyAlexD!!"; 
        end
end


endmodule
