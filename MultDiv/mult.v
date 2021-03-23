module mult (
    input wire [31:0] regA_out;
    input wire [31:0] regB_out;
    input wire [0:0] multControl;
    input wire clock;
    input wire reset;
    output wire finalMult;
    output wire [31:0] hi_entrance;
    output wire [31:0] lo_entrance;
);

reg inicio;
reg ultimoBitAnt;
reg [6:0] contador;
reg signed [63:0] produto;
reg signed [63:0] multiplicador;
reg signed [31:0] complemento_b;
reg signed [63:0] complemento_b_ext;

initial begin
    inicio = 1'b1;
end

always @(posedge clock) begin
    
    if(reset == 1'b1)begin
        inicio = 1'b1;
        contador = 7'b0;
        produto = 64'b0;
        complemento_b = 32'b0;
        complemento_b_ext = 64'b0;
        multiplicador = 64'b0;
        ultimoBitAnt = 1'b0;
        finalMult = 1'b0;
        hi_entrance = 32'b0;
        lo_entrance = 32'b0;
    end else if (multControl == 1'b1 && inicio == 1'b1) begin
        ultimoBitAnt = 1'b0;
        contador = 7'b0;
        produto = {32'b0, regA_out[31:0]};
        multiplicador = {regB_out[31:0], 32'b0};
        complemento_b = ~regB_out + 1'b1;
        complemento_b_ext = {complemento_b, 32'b0};
        finalMult = 1'b0;
        inicio = 1'b0;
    end else if (multControl == 1'b1) begin
        if (contador<7'b0100000) begin
            if(produto[0] == ultimoBitAnt) begin
                
            end else if (ultimoBitAnt == 1'b0 ) begin
                produto = produto + complemento_b_ext;
            end else if (ultimoBitAnt == 1'b1) begin
                produto = produto + multiplicador;
            end
            ultimoBitAnt = produto[0];
            produto = produto >>> 1;
            contador = contador + 1;
        end else if(contador == 7'b0100000)begin
            hi_entrance[31:0] = produto[63:32];
            lo_entrance[31:0] = produto[31:0];
            finalMult = 1'b1;
            inicio = 1'b1;
        end
    end

end
    
endmodule