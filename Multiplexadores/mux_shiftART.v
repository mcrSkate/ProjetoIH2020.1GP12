module mux_shiftART(
    input wire  mux_shiftART_control,
    input wire  [4:0] regB_out,
    input wire  [10:6] Instr15_0,
    output reg [4:0] mux_shiftART_out
);

always @(*) begin
    case (mux_shiftART_control)
         
        1'b0 : mux_shiftART_out <= regB_out;
        1'b1 : mux_shiftART_out <= Instr15_0;

    endcase
end
    
endmodule