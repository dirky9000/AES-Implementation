`timescale 1ns / 1ps

module invSubBytes(
    input clk,
    input reset,
    input [127:0] data,
    output logic [127:0] dout
);

    logic [127:0] tmp_out;

    inv_sbox invSub1(data[127:120], tmp_out[127:120]);
    inv_sbox invSub2(data[119:112], tmp_out[119:112]);
    inv_sbox invSub3(data[111:104], tmp_out[111:104]);
    inv_sbox invSub4(data[103:96], tmp_out[103:96]);

    inv_sbox invSub5(data[95:88], tmp_out[95:88]);
    inv_sbox invSub6(data[87:80], tmp_out[87:80]);
    inv_sbox invSub7(data[79:72], tmp_out[79:72]);
    inv_sbox invSub8(data[71:64], tmp_out[71:64]);

    inv_sbox invSub9(data[63:56], tmp_out[63:56]);
    inv_sbox invSub10(data[55:48], tmp_out[55:48]);
    inv_sbox invSub11(data[47:40], tmp_out[47:40]);
    inv_sbox invSub12(data[39:32], tmp_out[39:32]);

    inv_sbox invSub13(data[31:24], tmp_out[31:24]);
    inv_sbox invSub14(data[23:16], tmp_out[23:16]);
    inv_sbox invSub15(data[15:8], tmp_out[15:8]);
    inv_sbox invSub16(data[7:0], tmp_out[7:0]);

    always_ff @(posedge clk) begin
        dout <= tmp_out;
    end

endmodule
