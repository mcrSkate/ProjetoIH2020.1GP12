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
    output reg AControl,
    output reg BControl,
    output reg HILOControl,
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
    reg [6:0] state;
    integer counter;


//opcodes --códigos em hexadecimal (especificação projeto)
    parameter opADDI = 6'h8;
    parameter opADDIU = 6'h9;
	parameter opBEQ = 6'h4; 
    parameter opBNE = 6'h5; 
    parameter opBLE = 6'h6; 
    parameter opBGT = 6'h7;
    parameter opBLM = 6'h1;
	parameter opLB = 6'h20;
    parameter opLH = 6'h21; 
    parameter opLUI = 6'hF; 
    parameter opLW = 6'h23;
	parameter opSB = 6'h28; 
    parameter opSH = 6'h29; 
    parameter opSLTI = 6'hA; 
    parameter opSW = 6'h2B;
	parameter opJ = 6'h2; 
    parameter opJAL = 6'h3;
    parameter opRTYPE = 6'h0; //tipo R (opcode 0x0)

//functs --códigos em hexadecimal (especificação projeto)
    parameter fADD = 6'h20;
    parameter fSUB = 6'h22; 
    parameter fAND = 6'h24;
	parameter fDIV = 6'h1A;
    parameter fMULT = 6'h18;
	parameter fMFHI = 6'h10;
    parameter fMFLO = 6'h12;
    parameter fSLL = 6'h0;
    parameter fSLLV = 6'h4; 
    parameter fSLT = 6'h2a;
	parameter fSRA = 6'h3;
    parameter fSRAV = 6'h7;
    parameter fSRL = 6'h2;
    parameter fJR = 6'h8;
	parameter fBREAK = 6'hD;
	parameter fRTE = 6'h13;
    parameter fXCHG = 6'h5; 

//estados
    parameter START = 7'b0000000;
    parameter ADD = 7'b0000001;
    parameter ADD_AND_SUB = 7'b0000010; //write em comum
    parameter ADDI = 7'b0000011; 
    parameter ADDI_ADDIU = 7'b0000100; //write em comum
    parameter ADDIU = 7'b0000101;
    parameter AND = 7'b0000110;
    parameter BEQ = 7'b0000111;
    parameter BGT = 7'b0001000;
    parameter BLE = 7'b0001001;
    parameter BLM = 7'b0001010;
    parameter BLM2 = 7'b0001011;
    parameter BLM_WAIT = 7'b0001100;
    parameter BNE = 7'b0001101;
    parameter BRANCHPC = 7'b0001110;
    parameter BREAK = 7'b00001111;
    parameter DECODE = 7'b0010000;
    parameter DIV = 7'b0010001;
    parameter DIV0 = 7'b0010010;
    parameter EXCEPTION = 7'b0010011;
    parameter FETCH = 7'b0010100; 
    parameter FETCH2 = 7'b0010101;
    parameter J = 7'b0010110;
    parameter JAL1 = 7'b0010111;
    parameter JAL2 = 7'b0011000;
    parameter JR = 7'b0011001;
    parameter LB = 7'b0011010;
    parameter LH = 7'b0011011;
    parameter LOAD_WAIT = 7'b0011100; 
    parameter LUI = 7'b0011101;
    parameter LW = 7'b0011110;
    parameter LW_LH_LB = 7'b0011111;
    parameter MFHI = 7'b0100000;
    parameter MFLO = 7'b0100001;
    parameter MULT = 7'b0100010;
    parameter NO_OPCODE = 7'b0100011;
    parameter OVERFLOW = 7'b0100100;
    parameter RTE = 7'b0100101;
    parameter SB = 7'b0100110; //parte3
    parameter SH = 7'b0100111; //parte3
    parameter SLL = 7'b0101000;
    parameter SLLV = 7'b0101001;
    parameter SLT = 7'b0101010;
    parameter SLTI = 7'b0101011;
    parameter SRA = 7'b0101100;
    parameter SRAV = 7'b0101101;
    parameter SREG_OUT = 7'b0101110; //comum para sll, sra, srl, sllv e srav
    parameter SRL = 7'b0101111;
    parameter STORE_PC = 7'b0110000; //armazena em pc
    parameter STORE_WAIT = 7'b0110001;
    parameter SUB = 7'b0110010;
    parameter SW = 7'b0110011; //parte3
    parameter SW_SH_SB1 = 7'b0110100;
    parameter SW_SH_SB2 = 7'b0110101;
    parameter WAIT = 7'b0110110;
    parameter WAIT_FINAL = 7'b0111001;
    parameter XCHG1 = 7'b0110111;
    parameter XCHG2 = 7'b0111000;

//inicial begin (reset)
    initial begin
        counter = 0;
        state <= FETCH; //sempre realizar reset no começo
    end

// always relacionado ao clock
    always @(posedge clk) begin
        if(reset) begin //(Reset --> valor 227 no reg 29, vai pro fetch)
            memControl = 1'b0;
            PCControl = 1'b0; 
            regControl = 1'b1; //
            multControl = 1'b0;
            divControl = 1'b0;
            memData = 1'b0;
            epcControl = 1'b0; 
            aluOutControl = 1'b0;
            IRControl = 1'b0; 
            shiftSource = 1'b0;
            shiftArtSource = 1'b0;
            RegWrite = 1'b0;
            AControl = 1'b0;
            BControl = 1'b0;
            HILOControl = 1'b0;
            muxHI = 1'b0;
            muxLO = 1'b0;
            slsControl = 2'b0; 
            sssControl = 2'b0; 
            IorD = 2'b0; 
            muxAControl = 2'b0;
            muxBControl = 2'b0; 
            excptControl = 2'b0; 
            regDest = 2'b11; // 
            PCSource = 3'b0; 
            shiftControl = 3'b0;
            aluControl = 3'b0;   
            dataSource = 4'b1010; //
            state <= FETCH;
        end
        else begin
            case(state)
               FETCH: begin
                    memControl = 1'b0; //
                    PCControl = 1'b1; // 
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; // 
                    muxAControl = 2'b0; //
                    muxBControl = 2'b01; // 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; // 
                    shiftControl = 3'b0;
                    aluControl = 3'b001; //   
                    dataSource = 4'b0;
                    state <= FETCH2;
                end
                FETCH2: begin
                    memControl = 1'b0; //
                    PCControl = 1'b1; // 
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; //
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    memControl = 1'b0;
                    PCControl = 1'b0; // 
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b1; // 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= DECODE;
                end
                DECODE: begin
                    memControl = 1'b0;
                    PCControl = 1'b0; 
                    regControl = 1'b0; //
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b1; //
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b1;
                    AControl = 1'b1; //se usa esse n precisa do regWrite
                    BControl = 1'b1;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0; //
                    muxBControl = 2'b11; // 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b001; //   
                    dataSource = 4'b0;
                    state <= START;
                end
                START: begin
                    case(opcode)
                        opRTYPE: begin
                            case(funct)
                                fADD: begin
                                    state <= ADD;
                                end
                                fSUB: begin
                                    state <= SUB;
                                end
                                fAND: begin
                                    state <= AND;
                                end
                                fDIV: begin
                                    state <= DIV;
                                end
                                fMULT: begin
                                    state <= MULT;
                                end
                                fMFHI: begin
                                    state <= MFHI;
                                end
                                fMFLO: begin
                                    state <= MFLO;
                                end
                                fSLL: begin
                                    state <= SLL;
                                end
                                fSLLV: begin
                                    state <= SLLV;
                                end
                                fSLT: begin
                                    state <= SLT;
                                end
                                fJR: begin
                                    state <= JR;
                                end
                                fBREAK: begin
                                    state <= BREAK;
                                end
                                fRTE: begin
                                    state <= RTE;
                                end
                                fXCHG: begin
                                    state <= XCHG1;
                                end
                            endcase
                        end
                        opADDI: begin
                            state <= ADDI;
                        end
                        opADDIU: begin
                            state <= ADDIU;
                        end
                        opBEQ: begin
                            state <= BEQ;
                        end
                        opBNE: begin
                            state <= BNE;
                        end
                        opBLE: begin
                            state <= BLE;
                        end
                        opBGT: begin
                            state <= BGT;
                        end
                        opBLM: begin
                            state <= BLM;
                        end
                        opLB: begin
                            state <= LW_LH_LB;
                        end
                        opLH: begin
                            state <= LW_LH_LB;
                        end
                        opLW: begin
                            state <= LW_LH_LB;
                        end
                        opSB: begin
                            state <= SW_SH_SB;
                        end
                        opSW: begin
                            state <= SW_SH_SB;
                        end  
                        opSH: begin
                            state <= SW_SH_SB;
                        end
                        opLUI: begin
                            state <= LUI;
                        end    
                        opSLTI: begin
                            state <= SLTI;
                        end
                        opJ: begin
                            state <= J;
                        end
                        opJAL: begin
                            state <= JAL1;
                        end 

                        default: begin //caso sem opcode
							state <= NO_OPCODE;
                        end       
                    endcase                    
                end
                ADD: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b1;//
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b01;//
                    muxBControl = 2'b0; //
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b001;//   
                    dataSource = 4'b0;
                    state <= ADD_AND_SUB;
                end
                AND: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b1;//
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b01;//
                    muxBControl = 2'b0; //
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b011; //   
                    dataSource = 4'b0;
                    state <= ADD_AND_SUB;
                end
                SUB: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b1;//
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b01; //
                    muxBControl = 2'b0; //
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b010;//   
                    dataSource = 4'b0;
                    state <= ADD_AND_SUB;
                end
                ADD_AND_SUB: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b1;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;//
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b01;// 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0;//
                    state <= WAIT_FINAL;
                end
                ADDI: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b1;//
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b01;//
                    muxBControl = 2'b10;// 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b001;//   
                    dataSource = 4'b0;
                    state <= ADDI_ADDIU;
                end
                ADDIU: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b1; //
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b01; //
                    muxBControl = 2'b10; //
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b001; //   
                    dataSource = 4'b0;
                    state <= ADDI_ADDIU;
                end
                ADDI_ADDIU: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b1;//
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; //
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0;//
                    state <= WAIT_FINAL;
                end
                JR: begin
                    memControl = 1'b0; 
                    PCControl = 1'b1;//  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b01;//
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; //
                    shiftControl = 3'b0;
                    aluControl = 3'b0; //  
                    dataSource = 4'b0;
                    state <= WAIT_FINAL;
                end
                MFHI: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b1;//
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b01;// 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0011;//
                    state <= WAIT_FINAL;
                end
                MFLO: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b1;//
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b01;// 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0010;//
                    state <= WAIT_FINAL;
                end
                SLL: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b1;//
                    shiftArtSource = 1'b1;//
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b010;//
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= SREG_OUT;
                end
                SRA: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b1;//
                    shiftArtSource = 1'b1;//
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b100;//
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= SREG_OUT;
                end
                SRL: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b1;//
                    shiftArtSource = 1'b1;//
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b011;//
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= SREG_OUT;
                end
                SLLV: begin 
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;//
                    shiftArtSource = 1'b0;//
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b010;//
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= SREG_OUT;
                end
                SRAV: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;//
                    shiftArtSource = 1'b0;//
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b100;//
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= SREG_OUT;
                end
                SREG_OUT: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b1;//
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b01;// 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0100; //
                    state <= WAIT_FINAL;
                end
                SLT: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b1;//
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b01;//
                    muxBControl = 2'b00; //
                    excptControl = 2'b0; 
                    regDest = 2'b01;// 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b111; //  
                    dataSource = 4'b0101;//
                    state <= WAIT_FINAL;
                end
                BREAK: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0; //
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0; //
                    muxBControl = 2'b01; // 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; //
                    shiftControl = 3'b0;
                    aluControl = 3'b010;//   
                    dataSource = 4'b0;
                    state <= WAIT_FINAL;
                end
                CONTINUAR: begin
                    memControl = 1'b0; 
                    PCControl = 1'b0;  
                    regControl = 1'b0;
                    multControl = 1'b0;
                    divControl = 1'b0;
                    memData = 1'b0;
                    epcControl = 1'b0; 
                    aluOutControl = 1'b0;
                    IRControl = 1'b0; 
                    shiftSource = 1'b0;
                    shiftArtSource = 1'b0;
                    RegWrite = 1'b0;
                    AControl = 1'b0;
                    BControl = 1'b0;
                    HILOControl = 1'b0;
                    muxHI = 1'b0;
                    muxLO = 1'b0;
                    slsControl = 2'b0; 
                    sssControl = 2'b0; 
                    IorD = 2'b0; 
                    muxAControl = 2'b0;
                    muxBControl = 2'b0; 
                    excptControl = 2'b0; 
                    regDest = 2'b0; 
                    PCSource = 3'b0; 
                    shiftControl = 3'b0;
                    aluControl = 3'b0;   
                    dataSource = 4'b0;
                    state <= WAIT_FINAL;
                end
                WAIT_FINAL: begin
                    state <= FETCH;
                end


            endcase
                 
        end
    end
//EXCEÇÕES
/* if (estado) begin
    atualiza estados de saída 
    
    ESTADO: begin
            atualiza estados 
*/

endmodule