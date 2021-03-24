module mux_regDest(
    input wire  [1:0]  mux_regDest_control,
    input wire  [20:16] inst20_16_out,
    input wire  [15:11] inst15_11_out,
    input wire  [4:0] reg31_out,
    output reg [4:0] mux_regDest_out
);

always @(*) begin
    case (mux_regDest_control)
         
        2'b00 : mux_regDest_out <= inst20_16_out;
        2'b01 : mux_regDest_out <= inst15_11_out;
        2'b10 : mux_regDest_out <= 5'd31;
        2'b11 : mux_regDest_out <= 5'd29;
        
    endcase
end
    
endmodule