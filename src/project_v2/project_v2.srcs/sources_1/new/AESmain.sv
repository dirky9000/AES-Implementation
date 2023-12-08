`timescale 1ns / 1ps

module AESmain(clk, reset, plainText, keyIn, cypherText, cypherOut, cypherIn, mode, start, busy);
    input clk;
    input reset;
    input [127:0] plainText;
    input [127:0] keyIn;
    input [127:0] cypherIn;
    input [1:0] mode;
    input start;
    output [127:0] cypherText, cypherOut;
    output busy;

    reg busy;
    reg [127:0] cypherOut, cypherText;
    
    reg [127:0] intermediateCypher;
    reg [127:0] intermediateKeyIn;
    reg [127:0] intermediateCypherKeyIn;
    wire [127:0] intermediateCypherOut, intermediateCypherText;

    // start signal
    reg start_reg;

    
    //AES_Encryption e0(clk, plainText, intermediateKeyIn, intermediateCypherText);
    
    //AES_Decryption d0(clk, intermediateCypher, intermediateCypherKeyIn, intermediateCypherOut);
    
AESencrypt encrypt(
    .clk(clk),
    .reset(reset),
    .key(intermediateKeyIn),
    .plaintextHex(plainText),
    .ciphertextHex(intermediateCypherText)
    );

AESdecrypt decrypt(
    .clk(clk),
    .reset(reset),
    .key(intermediateCypherKeyIn),
    .ciphertextHex(intermediateCypher),
    .plaintextHex(intermediateCypherOut)
    );

    always @(posedge clk or posedge reset or posedge start) begin
        if (reset) begin
            // Reset logic
            intermediateCypher <= 128'b0;
            intermediateKeyIn <= 128'b0;
            intermediateCypherKeyIn <= 128'b0;
            cypherOut <= 128'b0;
            cypherText <= 128'b0;
            busy <= 1'b0; 
            
        end else begin
            if (start) begin
                start_reg <= 1'b1;
            end

            // Mode execution
            if (start_reg) begin
                case (mode)
                2'b00: begin
                    // Only AES_Encryption
                    intermediateCypher <= 128'b0;
                    intermediateKeyIn <= keyIn;
                    cypherOut <= 128'b0;
                    cypherText <= intermediateCypherText;
                    busy <= ~|(cypherText);
                end
                2'b01: begin
                    // Only AES_Decryption
                    intermediateCypher <= cypherIn;
                    intermediateKeyIn <= 128'b0;
                    intermediateCypherKeyIn <= keyIn;
                    cypherOut <= intermediateCypherOut;
                    busy <= ~|(cypherOut);
                end
                2'b10, 2'b11: begin
                    // Both AES_Encryption and AES_Decryption
                    cypherText <= intermediateCypherText;
                    intermediateCypher <= cypherIn;
                    intermediateKeyIn <= keyIn;
                    intermediateCypherKeyIn <= keyIn;
                    cypherOut <= intermediateCypherOut;
                    busy <= ~|(cypherText | cypherOut);  
                end
                    default: begin
                    end
                endcase
            end
        end
    end

endmodule


