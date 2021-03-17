module mux_a (
    input wire  [1:0]  mux_a_control;
    input wire  [31:0] pc_out;
    input wire  [31:0] regA_out;
    input wire  [31:0] mdr_out;
    output wire [31:0] mux_a_out;
);

always @(*) begin
    case(mux_a_control)

       assign 2'b00 : mux_a_out = pc_out;
       assign 2'b01 : mux_a_out = regA_out;
       assign 2'b10 : mux_a_out = mdr_out;

    endcase
end

    
endmodule