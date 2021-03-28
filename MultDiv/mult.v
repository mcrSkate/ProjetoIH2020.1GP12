module mult (
    input wire [31:0] regA_out,
    input wire [31:0] regB_out,
    input wire multControl,
    input wire clock,
    input wire reset,
    output reg [31:0] hi_entrance,
    output reg [31:0] lo_entrance
);

reg [64:0] A_aux = 65'd0;
reg [31:0] Negativ;
reg [64:0] ANeg;
reg [64:0] Produto;
integer counter = 32;


always @ (posedge clock) begin
    if(reset) begin
        hi_entrance = 32'd0;
        lo_entrance = 32'd0;
        A_aux = 65'd0;
        Negativ = 32'd0;
        ANeg = 32'd0;
        Produto = 32'd0;
    end

    if(multControl) begin
        counter = 32;
        Negativ = ~regA_out+ 1;
        A_aux = {regA_out[31:0], 33'd0};
        ANeg = {Negativ[31:0], 33'd0};
        Produto = {32'd0, regB_out[31:0], 1'b0};
    end

    case(Produto[1:0])
        2'b01: begin
         Produto = Produto + A_aux;
        end
        2'b10: begin
         Produto = Produto + ANeg;
        end
    endcase
    Produto = Produto >> 1;
    if (Produto[63] == 1'b1) begin
        Produto[64] = 1'b1;
    end
    if(counter > 0) begin
        counter = counter - 1;
    end
    if(counter == 0) begin
        hi_entrance = Produto[64:33];
        lo_entrance = Produto[32:1];
        counter = -1;
    end
    if(counter == -1) begin
        A_aux = 65'd0;
        ANeg = 65'd0;
        Produto = 65'd0;
        Negativ = 32'd0;
    end
end
    
endmodule