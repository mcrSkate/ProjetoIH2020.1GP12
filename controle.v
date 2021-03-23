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
    output reg memControl //memória
    output reg PCControl 
    output reg regControl //banco de registradores
    output reg multControl
    output reg divControl
    output reg memData
    output reg epcControl 
    output reg aluOutControl
    output reg IRControl //registrador de instruções
    output reg shiftSource
    output reg shiftArtSource
    /*o A, B, HI e LO Control eu acredito que entram nos registradores normais, por isso não estõ aqui, mas vou checar*/

    output reg[1:0] slsControl // set load size
    output reg[1:0] sssControl // set store size
    output reg[1:0] IorD 
    output reg[1:0] muxAControl 
    output reg[1:0] muxBControl 
    output reg[1:0] excptControl //execeções 
    output reg[1:0] regDest //registrador de destino 
    
    output reg[2:0] PCSource 
    output reg[2:0] shiftControl // registrador de deslocamento
    output reg[2:0] aluControl // checar como fica a ula   
            
    output reg[3:0] dataSource // writeData    
);

//opcodes
//functs
//estados

//inicial begin
// always relacionado ao clock

/* if (estado) begin
    atualiza estados de saída 
    
    ESTADO: begin
            atualiza estados 
*/