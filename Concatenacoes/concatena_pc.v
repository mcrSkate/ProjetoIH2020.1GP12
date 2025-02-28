module concatena_pc (
    input wire [27:0] shift_left_2_out,
    input wire [31:28] pc_out,
    output reg [31:0] concatena_pc_out
);
always @(*) begin
    concatena_pc_out <= {pc_out,shift_left_2_out};
end
    
endmodule