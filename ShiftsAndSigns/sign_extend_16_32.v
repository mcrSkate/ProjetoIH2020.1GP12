module sign_extend_16_32 (
    input wire [15:0] Instr15_0,
    output reg [31:0] sign_extend_16_32_out
);
    always @(*) sign_extend_16_32_out <= $signed(Instr15_0);

endmodule