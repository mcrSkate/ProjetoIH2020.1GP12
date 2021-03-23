module div (
    input wire [31:0] regA_out,
    input wire [31:0] regB_out,
    input wire clock,
    input wire reset,
    input wire divControl,
    output reg zeroDiv,
    output reg finalDiv,
    output reg [31:0] hi_entrance,
    output reg [31:0] lo_entrance
);

reg inicial;
reg sinalA;
reg sinalB;
reg [31:0] quociente;
reg [31:0] resto;
reg [31:0] auxB;

initial begin
    inicial = 1'b1;
end

always @(posedge clock) begin
    if(reset == 1'b1) begin
        inicial = 1'b1;
        sinalA = 1'b0;
        sinalB = 1'b0;
        quociente = 32'b0;
        resto = 32'b0;
        auxB = 32'b0;
        zeroDiv = 1'b0;
        finalDiv = 1'b0;
        hi_entrance = 32'b0;
        lo_entrance = 32'b0;
    end else if (divControl == 1'b1 && inicial == 1'b1) begin
        zeroDiv = 1'b0;
        finalDiv = 1'b0;
        hi_entrance = 32'b0;
        lo_entrance = 32'b0;
        sinalA = 1'b0;
        sinalB = 1'b0;
        quociente = 32'b0;
        if(regA_out[31] == 1'b1) begin
            sinalA = 1'b1;
            resto = ~regA_out + 1;
        end else begin
            resto = regA_out;
        end
        if (regB_out[31] == 1'b1) begin
            sinalB = 1'b1;
            auxB = ~regB_out + 1;
        end else begin
            auxB = regB_out;
        end
        if(auxB == 32'b0) begin
            zeroDiv = 1'b1;
            finalDiv = 1'b1;
            hi_entrance = 32'b01111111111111111111111111111111;
            lo_entrance = 32'b01111111111111111111111111111111;
        end
    end else if (divControl == 1'b1) begin
        if(resto<auxB) begin
            if(sinalA == 1'b1) begin
                hi_entrance = ~resto + 1;
            end else begin
                hi_entrance = resto;
            end
            if (sinalA == sinalB) begin
                lo_entrance = quociente;
            end else begin
                lo_entrance = ~quociente + 1;
            end
            finalDiv = 1'b1;
        end else begin
            resto = resto - auxB;
            quociente = quociente + 1;
        end
    end else begin
        inicial = 1'b1;
    end
end
    
endmodule