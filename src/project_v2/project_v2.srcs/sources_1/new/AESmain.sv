`timescale 1ns / 1ps

module AESmain(
    input clk,
    input reset,
    input [127:0] plaintextInput,
    input [127:0] key,
    input [127:0] ciphertextInput,
    input [1:0] mode,
    input start,
    output logic [127:0] encryptedOutput, 
    output logic [127:0] decryptedOutput,
    output logic busy
    );

    logic [127:0] decryptedOutput, encryptedOutput, tmp_ciphertext, tmp_key, tmp_decrypt_key, tmp_decrypt_output, tmp_ciphertext_output, tmp_start;
    
AESencrypt encrypt(
    .clk(clk),
    .reset(reset),
    .key(tmp_key),
    .plaintextHex(plaintextInput),
    .ciphertextHex(tmp_ciphertext_output)
    );

AESdecrypt decrypt(
    .clk(clk),
    .reset(reset),
    .key(tmp_decrypt_key),
    .ciphertextHex(tmp_ciphertext),
    .plaintextHex(tmp_decrypt_output)
    );

    always @(posedge clk) 
    begin
        if (reset) 
        begin
        tmp_ciphertext <= 128'b0;
        tmp_key <= 128'b0;
        tmp_decrypt_key <= 128'b0;
        decryptedOutput <= 128'b0;
        encryptedOutput <= 128'b0;
        busy <= 1'b0; 
        end 
        else 
        begin
            if (start)
            begin
                tmp_start <= 1'b1;
            end

            if (tmp_start) 
            begin
                case (mode)
                2'b00: 
                begin //Encryption
                tmp_ciphertext <= 128'b0;
                tmp_key <= key;
                decryptedOutput <= 128'b0;
                encryptedOutput <= tmp_ciphertext_output;
                busy <= ~|(encryptedOutput);
                end
                2'b01: 
                begin //Decryption
                tmp_ciphertext <= ciphertextInput;
                tmp_key <= 128'b0;
                tmp_decrypt_key <= key;
                decryptedOutput <= tmp_decrypt_output;
                busy <= ~|(decryptedOutput);
                end
                2'b10, 2'b11: 
                begin //Both Encryption and Decryption
                encryptedOutput <= tmp_ciphertext_output;
                tmp_ciphertext <= ciphertextInput;
                tmp_key <= key;
                tmp_decrypt_key <= key;
                decryptedOutput <= tmp_decrypt_output;
                busy <= ~|(encryptedOutput | decryptedOutput);  
                end
                    default: begin
                    end
                endcase
            end
        end
    end
endmodule


