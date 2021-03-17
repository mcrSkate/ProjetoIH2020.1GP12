module mux_shiftART(
    input wire  [0:0]  mux_shiftART_control;
    input wire  [4:0] regB_out;
    input wire  [10:6] inst10_6_out;
    output wire [4:0] mux_shiftART_out;
);

always @(*) begin
    case (mux_shiftART_control)
         
        1'b0 : mux_shiftART_out <= regB_out;
        1'b1 : mux_shiftART_out <= inst10_6_out;

    endcase
end
    
endmodule