module mux_hi (
    input wire mux_hi_control,
    input wire [31:0] hi_div_out,
    input wire [31:0] hi_mult_out,
    output reg [31:0] mux_hi_out

);
    always @* begin
        case (mux_hi_control)
            1'b0: mux_hi_out <= hi_div_out;
            1'b1: mux_hi_out <= hi_mult_out;
        endcase
    end
endmodule