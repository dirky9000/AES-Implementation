`timescale 1ns / 1ps

module subbytes(
    input clk,
    input reset,
    input [127:0] data,
    output logic [127:0] dout
);

    logic [127:0] tmp_out;

    sbox sub1(data[127:120], tmp_out[127:120]);
    sbox sub2(data[119:112], tmp_out[119:112]);
    sbox sub3(data[111:104], tmp_out[111:104]);
    sbox sub4(data[103:96], tmp_out[103:96]);

    sbox sub5(data[95:88], tmp_out[95:88]);
    sbox sub6(data[87:80], tmp_out[87:80]);
    sbox sub7(data[79:72], tmp_out[79:72]);
    sbox sub8(data[71:64], tmp_out[71:64]);

    sbox sub9(data[63:56], tmp_out[63:56]);
    sbox sub10(data[55:48], tmp_out[55:48]);
    sbox sub11(data[47:40], tmp_out[47:40]);
    sbox sub12(data[39:32], tmp_out[39:32]);

    sbox sub13(data[31:24], tmp_out[31:24]);
    sbox sub14(data[23:16], tmp_out[23:16]);
    sbox sub15(data[15:8], tmp_out[15:8]);
    sbox sub16(data[7:0], tmp_out[7:0]);

    always_ff @(posedge clk) begin
        dout <= tmp_out;
    end

endmodule