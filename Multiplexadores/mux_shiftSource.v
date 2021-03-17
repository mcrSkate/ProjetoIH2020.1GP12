module mux_shiftSource(
    input wire  [0:0]  mux_shiftSource_control;
    input wire  [31:0] regA_out;
    input wire  [31:0] regB_out;
    output wire [31:0] mux_shiftSource_out;
);

always @(*) begin
    case (mux_shiftSource_control)
         
        1'b0 : mux_shiftSource_out <= regA_out;
        1'b1 : mux_shiftSource_out <= regB_out;

    endcase
end
    
endmodule