module div (
    input wire [31:0] regA_out,
    input wire [31:0] regB_out,
    input wire clock,
    input wire reset,
    input wire divControl,
    output reg zeroDiv,
    output reg [31:0] hi_entrance,
    output reg [31:0] lo_entrance
);

reg signed[63:0] Divisor;
reg signed[63:0] Resto;
reg signed[63:0] RestoAux;
reg signed[31:0] Quociente;
reg ativado;
integer Ciclos;
reg[31:0] aux;
reg[31:0] aux1;
 
initial begin
ativado = 1'b0;
Ciclos = 0;
end
 
always @(posedge clock) begin
        if (reset == 1) begin
                hi_entrance = 32'b0;
                lo_entrance = 32'b0;
                Resto = 64'b0;
                Divisor = 64'b0;
                Ciclos = 0;
                RestoAux = 64'b0;
                ativado = 1'b0;
                zeroDiv = 1'b0;
                end
        if (divControl == 1) begin
                zeroDiv = 0;
                Divisor = {regB_out,32'b0};
                Resto = {32'b0,regA_out};
                RestoAux = 64'b0;
                Quociente = 32'b0;
                ativado = 1'b1;
                if (regB_out[31] == 1'b1) begin
                        aux = ~regB_out + 1;
                        Divisor = {aux, 32'b0};
                        end
                if (regA_out[31] == 1'b1) begin
                        aux1 = ~regA_out + 1;
                        Resto = {32'b0,aux1};
                        end
                end
        if(ativado && regB_out == 32'b0) begin
                zeroDiv = 1'b1;
                hi_entrance = 32'b0;
                lo_entrance = 32'b0;
                end
        if (ativado == 1'b1 && zeroDiv == 1'b0) begin             
                if (Ciclos < 33) begin
                        RestoAux = ~Divisor + 1;
                        Ciclos = Ciclos + 1;
                        RestoAux = RestoAux + Resto;
                        case(RestoAux[63])
                                        1'b1: begin
                                                Quociente = Quociente <<< 1;                                             
                                                Divisor = Divisor >>> 1;
                                                Quociente[0] = 1'b0;
                                                end
                                        1'b0: begin
                                                Quociente = Quociente <<< 1;
                                                Resto = RestoAux;
                                                Divisor = Divisor >>> 1;
                                                Quociente[0] = 1'b1;
                                                end
                                endcase
                        end
                else begin                     
                        hi_entrance = Resto;
                        lo_entrance = Quociente;
                        ativado = 1'b0;
                        if (regA_out[31] == 1'b1 && regB_out[31] == 1'b1) begin
                                hi_entrance = ~hi_entrance + 1;
                                end
                        else if (regB_out[31] == 1'b1) begin
                                lo_entrance = ~lo_entrance+ 1;
                                end
                        else if (regA_out[31] == 1'b1) begin
                                hi_entrance = ~hi_entrance + 1;
                                lo_entrance= ~lo_entrance + 1;
                                end
                        end
                end
        end
    
endmodule