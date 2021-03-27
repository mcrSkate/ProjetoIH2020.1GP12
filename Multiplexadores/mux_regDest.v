module mux_regDest(
    input wire  [1:0]  mux_regDest_control,
    input wire [25:21] inst25_21_out,
    input wire  [20:16] inst20_16_out,
    input wire  [15:11] inst15_11_out,
    output reg [4:0] mux_regDest_out
);

always @(*) begin
    case (mux_regDest_control)
         
        3'b000 : mux_regDest_out <= inst20_16_out;
        3'b001 : mux_regDest_out <= inst15_11_out;
        3'b010 : mux_regDest_out <= 5'd31;
        3'b011 : mux_regDest_out <= 5'd29;
        3'b100 : mux_regDest_out <= inst25_21_out;
        
    endcase
end
    
endmodule