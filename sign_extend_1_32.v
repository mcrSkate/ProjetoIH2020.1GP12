module sign_extend_1_32(
    input wire [0:0] onebit_LT_out;
    output wire [31:0] sign_extend_out;
);

always @(*) sign_extend_out <= $signed(onebit_LT_out);

    
endmodule