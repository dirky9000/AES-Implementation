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
            plaintextHex <= 128'h74_65_73_74_45_6E_63_72_79_70_74_41_6C_65_78_44; //testEncryptAlexD
            secretKeyHex <= 128'h53_65_63_72_65_74_4B_65_79_41_6C_65_78_44_21_21; //SecretKeyAlexD!!
        end
end



endmodule
