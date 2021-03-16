module mux_excpt (
    input wire [1:0] excpt_Control;
    output wire [1:0] mux_excpt_out;
);

always @(*) begin
    case (excpt_Control)
        2'b00 : mux_excpt_out = 32'd253;
        2'b01 : mux_excpt_out = 32'd254;
        2'b10 : mux_excpt_out = 32'd255;
    endcase
end
    
endmodule