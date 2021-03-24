/* vou fazer o código comentado pra td mundo poder entender e depois apagamos os comentarios */

module Controle(
    //inputs
    input clk, // clock
    input reset,
    input [5:0] opcode, //só checar depois os nomes que vamos deixar esses dois
    input [5:0] funct,
    
    input greater, //flags
    input equals,
    input lesser,
    input overflow,
    input zeroDiv,
    input noOpcode, //é o que a gente chamou de BR, pelo que eu vi serve pra opcode inexistente, checar isso

    //outputs
    output reg memControl, //memória
    output reg PCControl, 
    output reg regControl, //banco de registradores
    output reg multControl,
    output reg divControl,
    output reg memData,
    output reg epcControl, 
    output reg aluOutControl,
    output reg IRControl, //registrador de instruções
    output reg shiftSource,
    output reg shiftArtSource,
    output reg RegWrite,
    output reg muxHI,
    output reg muxLO,

    /*o A, B, HI e LO Control eu acredito que entram nos registradores normais, por isso não estõ aqui, mas vou checar*/

    output reg[1:0] slsControl, // set load size
    output reg[1:0] sssControl, // set store size
    output reg[1:0] IorD, 
    output reg[1:0] muxAControl,
    output reg[1:0] muxBControl, 
    output reg[1:0] excptControl, //execeções 
    output reg[1:0] regDest, //registrador de destino 
    
    output reg[2:0] PCSource, 
    output reg[2:0] shiftControl, // registrador de deslocamento
    output reg[2:0] aluControl, // checar como fica a ula   
            
    output reg[3:0] dataSource // writeData    
);


//parameters --mudar tamanho necessário depois
    reg [6:0] state
    reg [31:0] counter


//opcodes
//functs
//estados --passar pra binário depois --como fazer os waits
    parameter RESET = 0;
    parameter FETCH = 0; //checar nomes
    parameter FETCH2 = 0;
    parameter DECODE = 0;
    parameter BRANCH = 0;
    parameter ENDBRANCH = 0;
    parameter ADD = 0;
    parameter AND = 0;
    parameter SUB = 0;
    parameter ADD_AND_SUB = 0; //write em comum
    parameter ADDI = 0; 
    parameter ADDIU = 0;
    parameter ADDI_ADDIU = 0; //write em comum
    parameter DIV = 0;
    parameter MULT = 0;
    parameter JR = 0;
    parameter MFHI = 0;
    parameter MFLO = 0;
    parameter SLL = 0;
    parameter SRA = 0;
    parameter SRL = 0;
    parameter SLLV = 0;
    parameter SRAV = 0;
    parameter SREG_OUT = 0; //comum para sll, sra, srl, sllv e srav
    parameter SLT = 0;
    parameter BREAK = 0;
    parameter RTE = 0;
    parameter LUI = 0;
    parameter J = 0;
    parameter SLTI = 0;
    parameter JAL1 = 0;
    parameter JAL2 = 0;
    parameter XCHG1 = 0;
    parameter XCHG2 = 0;
    parameter LW_LH_LB = 0;
    parameter LOAD_WAIT = 0; //checar se dá pra usar o mesmo
    parameter LW = 0;
    parameter LB = 0;
    parameter LH = 0;
    parameter SW = 0; //parte3
    parameter SH = 0; //parte3
    parameter SB = 0; //parte3
    parameter SW_SH_SB1 = 0;
    parameter SW_SH_SB2 = 0;
    parameter STORE_WAIT = 0;
    parameter BEQ = 0;
    parameter BNE = 0;
    parameter OVERFLOW = 0;
    parameter BRANCHPC = 0;
    parameter BLE = 0;
    parameter BGT = 0;
    parameter BLM = 0;
    parameter EXCEPTION = 0;
    parameter DIV0 = 0;
    parameter NO_OPCODE = 0;
    parameter BLM_WAIT = 0;
    parameter BLM2 = 0;
    parameter STORE_PC = 0; //armazena em pc


//inicial begin (reset)
    initial begin
        counter = 31'b0
        state <= RESET;
    end

// always relacionado ao clock
//EXCEÇÕES
    RESET: begin //(Reset --> valor 227 no reg 29, vai pro fetch)
        
    end
/* if (estado) begin
    atualiza estados de saída 
    
    ESTADO: begin
            atualiza estados 
*/

endmodule