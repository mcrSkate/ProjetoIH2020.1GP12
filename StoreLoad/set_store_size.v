module set_store_size (
    input wire [1:0] set_store_size_control,
    input wire [31:0] b_out,
    input wire [31:0] memory_data_register_out,
    output reg [31:0] set_store_size_out
);
    always @(*) begin
        case (set_store_size_control)
            2'b00 : set_store_size_out <= {memory_data_register_out[31:8],b_out[7:0]};
            2'b01 : set_store_size_out <= {memory_data_register_out[31:16],b_out[15:0]};
            2'b10 : set_store_size_out <= b_out[31:0];
        endcase
    end
endmodule