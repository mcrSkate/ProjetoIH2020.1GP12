module sign_extend_1_32(
    input wire onebit_LT_out,
    output reg [31:0] sign_extend_out
);

always @(*) sign_extend_out[0] <= onebit_LT_out;

    
endmodule