module sign_extend_16_32 (
    input wire [15:0] Instr15_0,
    output wire [31:0] sign_extend_16_32_out
);
    always @(*) begin
        assign sign_extend_16_32_out = {16'd0, Instr15_0};
    end
endmodule