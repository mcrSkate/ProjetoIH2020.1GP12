module shift_left_16 (
    input wire [15:0] Instr15_0;
    output wire [31:0] shift_left_16_out;
);
    always @(*) begin
        assign shift_left_16_out = {Instr15_0, 16'd0};
    end

    
endmodule