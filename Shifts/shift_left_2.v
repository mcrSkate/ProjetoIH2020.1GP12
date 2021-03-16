module shift_left_2 (
    input wire [25:0] inst_concatener_out;
    output wire [27:0] shift_left_2_out;
);
always @(*) begin
    shift_left_2_out = inst_concatener_out << 2;
end
    
endmodule