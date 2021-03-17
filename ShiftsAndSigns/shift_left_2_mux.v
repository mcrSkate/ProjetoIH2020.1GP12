module shift_left_2_mux (
    input wire [31:0] inst_concatener_out;
    output wire [31:0] shift_left_2_out;
);
always @(*) begin
    assign shift_left_2_out <= inst_concatener_out << 2;
end
    
endmodule