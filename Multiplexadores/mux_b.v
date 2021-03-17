module mux_b (
    input wire  [1:0]  mux_b_control;
    input wire  [31:0] regB_out;
    input wire  [31:0] num4_out;
    input wire  [31:0] singExtend16_32_out;
    input wire  [31:0] shiftleft_2_out;
    output wire [31:0] mux_b_out;
);

always @(*) begin
    case(mux_b_control)

        2'b00 : mux_b_out <= regB_out;
        2'b01 : mux_b_out <= 32'd4;
        2'b10 : mux_b_out <= singExtend16_32_out;
        2'b11 : mux_b_out <= shiftleft_2_out;

    endcase
end

    
endmodule