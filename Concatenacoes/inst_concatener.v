module inst_concatener (
    input wire [15:0] Instr15_0,
    input wire [4:0] Instr20_16,
    input wire [4:0] Instr25_21,
    output wire [25:0] inst_concatener_out
);
always @(*) begin
    assign inst_concatener_out = {Instr25_21, Instr20_16, Instr15_0};
end
    
endmodule