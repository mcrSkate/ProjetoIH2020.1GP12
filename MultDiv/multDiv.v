module multDiv (
    input wire [31:0] regA_out;
    input wire [31:0] regB_out;
    input wire [0:0] mdControl;
    input wire clock;
    input wire reset;
    output wire [31:0] hi_entrance;
    output wire [31:0] lo_entrance;
    integer i;
);

reg operation
reg ultimoBitAnt;
reg [5:0] contador;

initial begin
    ultimoBitAnt = 1'b0;
    contador = 6'b0;
    operation = mdControl;
    
end

always @(posedge clock) begin
    
    if (operation == 1'b0) begin
        
    end

end
    
endmodule