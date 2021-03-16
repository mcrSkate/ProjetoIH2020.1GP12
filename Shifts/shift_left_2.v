module shift_left_2 (
    input wire [25:0] inst_concatener;
    output wire [27:0] shift_left_2_out;
);
always @(*) begin
    shift_left_2_out = inst_concatener << 2;
end
    
endmodule