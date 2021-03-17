module mux_dataSource (
    input wire [3:0]mux_dataSource_control;
    input wire [31:0] AluOut_out;
    input wire [31:0] SLS_out;
    input wire [31:0] LO_out;
    input wire [31:0] HI_out;
    input wire [31:0] shiftReg_out;
    input wire [31:0] LT_out;
    input wire [31:0] signalExtend_out;
    input wire [31:0] shiftleft16_out;
    input wire [31:0] regA_out;
    input wire [31:0] regB_out;
    output wire [31:0] mux_dataSource_out;
);
always @(*) begin
    case (mux_dataSource_control)
        4'b0000 : mux_dataSource_out <= AluOut_out;
        4'b0001 : mux_dataSource_out <= SLS_out;
        4'b0010 : mux_dataSource_out <= LO_out;
        4'b0011 : mux_dataSource_out <= HI_out;
        4'b0100 : mux_dataSource_out <= shiftReg_out;
        4'b0101 : mux_dataSource_out <= LT_out;
        4'b0110 : mux_dataSource_out <= signalExtend_out;
        4'b0111 : mux_dataSource_out <= shiftleft16_out;
        4'b1000 : mux_dataSource_out <= regA_out;
        4'b1001 : mux_dataSource_out <= regB_out;
    endcase
    
end
    
endmodule