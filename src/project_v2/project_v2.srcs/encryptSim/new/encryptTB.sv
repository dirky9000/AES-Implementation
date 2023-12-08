`timescale 1ns / 1ps

module encryptTB(
    );

logic clk;
logic reset;
logic [127:0] plaintextHex;
logic [127:0] ciphertextHex;
logic [127:0] secretKeyHex;

AESencrypt EncryptBlock(
    .clk(clk),
    .reset(reset),
    .plaintextHex(plaintextHex),
    .key(secretKeyHex),
    .ciphertextHex(ciphertextHex)
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
            plaintextHex <= 0;
            secretKeyHex <= 0;
        end
    else
        begin
            plaintextHex <= "testEncryptAlexD";
            secretKeyHex <= "SecretKeyAlexD!!"; 
        end
end



endmodule
