module mux_lo (
    input wire mux_lo_control,
    input wire [31:0] lo_div_out,
    input wire [31:0] lo_mult_out,
    output reg [31:0] mux_lo_out

);
    always @* begin
        case (mux_lo_control)
            1'b0: mux_lo_out <= lo_div_out;
            1'b1: mux_lo_out <= lo_mult_out;
        endcase
    end
endmodule