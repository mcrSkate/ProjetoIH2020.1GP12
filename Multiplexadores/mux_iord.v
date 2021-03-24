module mux_iord(
    input wire  [1:0]  mux_iord_control,
    input wire  [31:0] pc_out,
    input wire  [31:0] aluOut_out,
    input wire  [31:0] ula_out,
    input wire  [31:0] exec_out,
    output reg [31:0] mux_iord_out
);

always @(*) begin
    case (mux_iord_control)
         
        2'b00 : mux_iord_out <= pc_out;
        2'b01 : mux_iord_out <= aluOut_out;
        2'b10 : mux_iord_out <= ula_out;
        2'b11 : mux_iord_out <= exec_out;

    endcase
end
    
endmodule