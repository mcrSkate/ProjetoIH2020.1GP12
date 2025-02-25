module shift_left_2_mux (
    input wire [31:0] inst_concatener_out,
    output reg [31:0] shift_left_2_mux_out
);
always @(*) begin
    shift_left_2_mux_out <= inst_concatener_out << 2;
end
    
endmodule