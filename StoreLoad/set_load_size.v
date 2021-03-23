module set_load_size (
    input wire [31:0] memory_data_register_out,
    input wire [1:0] set_load_size_control,
    output reg [31:0] set_load_size_out
);
always @(*) begin
    case (set_load_size_control)
        1'b00 : set_load_size_out = {24'd0,memory_data_register_out[7:0]};
        1'b01 : set_load_size_out = {16'd0,memory_data_register_out[15:0]}
        1'b10 : set_load_size_out = memory_data_register_out;
    endcase
end
    
endmodule