module mux_pc_source (
    input wire [2:0] mux_pc_source_control;
    input wire [31:0] ULA_out;
    input wire [31:0] AluOut_out;
    input wire [31:0] concatena_28_32_out;
    input wire [31:0] mdr_out;
    input wire [31:0] epc_out;
    output wire [31:0] mux_pc_source_out;
);
always @* begin
    case (mux_pc_source_control)
        3'b000 : mux_pc_source_out = ULA_out;
        3'b001 : mux_pc_source_out = AluOut_out;
        3'b010 : mux_pc_source_out = concatena_28_32_out;
        3'b011 : mux_pc_source_out = mdr_out;
        3'b100 : mux_pc_source_out = epc_out;
    endcase
end
    
endmodule