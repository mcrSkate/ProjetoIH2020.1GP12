// Copyright (C) 1991-2010 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II"
// VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Web Edition"
// CREATED		"Fri Mar 26 17:28:27 2021"

module cpu(
	CLOCK,
	RESET,
	Instr15_0,
	Mem_in,
	Instr20_16,
	Instr25_21,
	Write_data,
	Instr31_26,
	Saida_b,
	Write_reg
	
	
);


input	CLOCK;
input	RESET;


output wire	[15:0] Instr15_0;
wire	[31:0] Saida;
 output wire	[31:0] Saida_b;
wire	SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_90;
wire	SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_91;
 wire	[31:0] HI_in;
wire	SYNTHESIZED_WIRE_10;
 wire	[31:0] SYNTHESIZED_WIRE_11;
output wire	[31:0] Mem_in;
wire	[31:0] SYNTHESIZED_WIRE_92;
wire	[1:0] SYNTHESIZED_WIRE_14;
wire	[1:0] SYNTHESIZED_WIRE_16;
 wire	[31:0] SYNTHESIZED_WIRE_17;
  wire	[4:0] SYNTHESIZED_WIRE_18;
wire	[2:0] SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_22;
output wire	[4:0] Instr20_16;
output wire	[4:0] Instr25_21;
wire	[25:0] SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_27;
 wire	[31:0] SYNTHESIZED_WIRE_95;
wire	[27:0] SYNTHESIZED_WIRE_29;
 wire	[31:0] SYNTHESIZED_WIRE_96;
wire	SYNTHESIZED_WIRE_97;
wire	[1:0] SYNTHESIZED_WIRE_32;
wire	[31:0] SYNTHESIZED_WIRE_98;
wire	[31:0] SYNTHESIZED_WIRE_34;
wire	[1:0] SYNTHESIZED_WIRE_35;
wire	SYNTHESIZED_WIRE_37;
wire	SYNTHESIZED_WIRE_39;
 wire	Reg_write;
output wire	[31:0] Write_data;
 output wire	[4:0] Write_reg;
wire	[31:0] SYNTHESIZED_WIRE_46;
wire	[31:0] SYNTHESIZED_WIRE_47;
wire	[31:0] SYNTHESIZED_WIRE_48;
wire	[3:0] SYNTHESIZED_WIRE_49;
wire	[31:0] SYNTHESIZED_WIRE_51;
 wire	[31:0] SYNTHESIZED_WIRE_52;
wire	[31:0] SYNTHESIZED_WIRE_54;
wire	[1:0] SYNTHESIZED_WIRE_56;
 wire	[31:0] SYNTHESIZED_WIRE_57;
wire	SYNTHESIZED_WIRE_58;
  wire	[31:0] SYNTHESIZED_WIRE_59;
wire	[31:0] SYNTHESIZED_WIRE_60;
wire	SYNTHESIZED_WIRE_61;
  wire	[31:0] SYNTHESIZED_WIRE_62;
wire	[31:0] SYNTHESIZED_WIRE_63;
wire	[31:0] SYNTHESIZED_WIRE_65;
 wire	[31:0] EPC_out;
wire	[2:0] SYNTHESIZED_WIRE_68;
wire	[1:0] SYNTHESIZED_WIRE_70;
wire	[31:0] SYNTHESIZED_WIRE_71;
wire	[2:0] SYNTHESIZED_WIRE_74;
 wire	[31:0] muxA_out;
 wire	[31:0] muxB_out;
wire	[2:0] SYNTHESIZED_WIRE_77;
wire	SYNTHESIZED_WIRE_78;
wire	SYNTHESIZED_WIRE_79;
wire	SYNTHESIZED_WIRE_81;
wire	SYNTHESIZED_WIRE_82;
output wire	[5:0] Instr31_26;
 wire	[31:0] LO_in;
wire	SYNTHESIZED_WIRE_86;
wire	SYNTHESIZED_WIRE_88;
 wire	[31:0] PC_in;

wire inst25_21;



Registrador	b2v_A(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_0),
	.Entrada(SYNTHESIZED_WIRE_1),
	.Saida(SYNTHESIZED_WIRE_57));


Registrador	b2v_ALUout(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_2),
	.Entrada(SYNTHESIZED_WIRE_90),
	.Saida(SYNTHESIZED_WIRE_98));


Registrador	b2v_B(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_4),
	.Entrada(SYNTHESIZED_WIRE_5),
	.Saida(Saida_b));


Registrador	b2v_EPC(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_6),
	.Entrada(SYNTHESIZED_WIRE_90),
	.Saida(EPC_out));


Registrador	b2v_HI(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_91),
	.Entrada(HI_in),
	.Saida(SYNTHESIZED_WIRE_46));


Memoria	b2v_inst1(
	.Clock(CLOCK),
	.Wr(SYNTHESIZED_WIRE_10),
	.Address(SYNTHESIZED_WIRE_11),
	.Datain(Mem_in),
	.Dataout(SYNTHESIZED_WIRE_95));


set_store_size	b2v_inst10(
	.b_out(Saida_b),
	.memory_data_register_out(SYNTHESIZED_WIRE_92),
	.set_store_size_control(SYNTHESIZED_WIRE_14),
	.set_store_size_out(Mem_in));


set_load_size	b2v_inst11(
	.memory_data_register_out(SYNTHESIZED_WIRE_92),
	.set_load_size_control(SYNTHESIZED_WIRE_16),
	.set_load_size_out(SYNTHESIZED_WIRE_54));


RegDesloc	b2v_inst12(
	.Clk(CLOCK),
	.Reset(RESET),
	.Entrada(SYNTHESIZED_WIRE_17),
	.N(SYNTHESIZED_WIRE_18),
	.Shift(SYNTHESIZED_WIRE_19),
	.Saida(SYNTHESIZED_WIRE_52));


mult	b2v_inst14(
	.multControl(SYNTHESIZED_WIRE_20),
	.clock(CLOCK),
	.reset(RESET),
	.regA_out(SYNTHESIZED_WIRE_57),
	.regB_out(Saida_b),
	.hi_entrance(SYNTHESIZED_WIRE_60),
	.lo_entrance(SYNTHESIZED_WIRE_63));


div	b2v_inst15(
	.clock(CLOCK),
	.reset(RESET),
	.divControl(SYNTHESIZED_WIRE_22),
	.regA_out(SYNTHESIZED_WIRE_57),
	.regB_out(Saida_b),
	.zeroDiv(SYNTHESIZED_WIRE_82),
	.hi_entrance(SYNTHESIZED_WIRE_59),
	.lo_entrance(SYNTHESIZED_WIRE_62));


inst_concatener	b2v_inst18(
	.Instr15_0(Instr15_0),
	.Instr20_16(Instr20_16),
	.Instr25_21(Instr25_21),
	.inst_concatener_out(SYNTHESIZED_WIRE_26));


shift_left_2	b2v_inst19(
	.inst_concatener_out(SYNTHESIZED_WIRE_26),
	.shift_left_2_out(SYNTHESIZED_WIRE_29));


Instr_Reg	b2v_inst2(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load_ir(SYNTHESIZED_WIRE_27),
	.Entrada(SYNTHESIZED_WIRE_95),
	.Instr15_0(Instr15_0),
	.Instr20_16(Instr20_16),
	.Instr25_21(Instr25_21),
	.Instr31_26(Instr31_26));


concatena_pc	b2v_inst20(
	.pc_out(Saida[31:28]),
	.shift_left_2_out(SYNTHESIZED_WIRE_29),
	.concatena_pc_out(SYNTHESIZED_WIRE_65));


shift_left_2_mux	b2v_inst21(
	.inst_concatener_out(SYNTHESIZED_WIRE_96),
	.shift_left_2_mux_out(SYNTHESIZED_WIRE_71));


sign_extend_1_32	b2v_inst22(
	.onebit_LT_out(SYNTHESIZED_WIRE_97),
	.sign_extend_out(SYNTHESIZED_WIRE_48));


shift_left_16	b2v_inst23(
	.Instr15_0(Instr15_0),
	.shift_left_16_out(SYNTHESIZED_WIRE_51));


mux_excpt	b2v_inst25(
	.excpt_Control(SYNTHESIZED_WIRE_32),
	.mux_excpt_out(SYNTHESIZED_WIRE_34));


mux_iord	b2v_inst26(
	.aluOut_out(SYNTHESIZED_WIRE_98),
	.exec_out(SYNTHESIZED_WIRE_34),
	.mux_iord_control(SYNTHESIZED_WIRE_35),
	.pc_out(Saida),
	.ula_out(SYNTHESIZED_WIRE_90),
	.mux_iord_out(SYNTHESIZED_WIRE_11));


mux_shiftSource	b2v_inst27(
	.mux_shiftSource_control(SYNTHESIZED_WIRE_37),
	.regA_out(SYNTHESIZED_WIRE_57),
	.regB_out(Saida_b),
	.mux_shiftSource_out(SYNTHESIZED_WIRE_17));


mux_shiftART	b2v_inst28(
	.mux_shiftART_control(SYNTHESIZED_WIRE_39),
	.Instr15_0(Instr15_0[10:6]),
	.regB_out(Saida_b[4:0]),
	.mux_shiftART_out(SYNTHESIZED_WIRE_18));


Banco_reg	b2v_inst3(
	.Clk(CLOCK),
	.Reset(RESET),
	.RegWrite(Reg_write),
	.ReadReg1(Instr25_21),
	.ReadReg2(Instr20_16),
	.WriteData(Write_data),
	.WriteReg(Write_reg),
	.ReadData1(SYNTHESIZED_WIRE_1),
	.ReadData2(SYNTHESIZED_WIRE_5));


mux_data_source	b2v_inst30(
	.AluOut_out(SYNTHESIZED_WIRE_98),
	.HI_out(SYNTHESIZED_WIRE_46),
	.LO_out(SYNTHESIZED_WIRE_47),
	.LT_out(SYNTHESIZED_WIRE_48),
	.mux_dataSource_control(SYNTHESIZED_WIRE_49),
	.regA_out(SYNTHESIZED_WIRE_57),
	.regB_out(Saida_b),
	.shiftleft16_out(SYNTHESIZED_WIRE_51),
	.shiftReg_out(SYNTHESIZED_WIRE_52),
	.signalExtend_out(SYNTHESIZED_WIRE_96),
	.SLS_out(SYNTHESIZED_WIRE_54),
	.mux_dataSource_out(Write_data));


mux_a	b2v_inst31(
	.mdr_out(SYNTHESIZED_WIRE_92),
	.mux_a_control(SYNTHESIZED_WIRE_56),
	.pc_out(Saida),
	.regA_out(SYNTHESIZED_WIRE_57),
	.mux_a_out(muxA_out));


mux_hi	b2v_inst33(
	.mux_hi_control(SYNTHESIZED_WIRE_58),
	.hi_div_out(SYNTHESIZED_WIRE_59),
	.hi_mult_out(SYNTHESIZED_WIRE_60),
	.mux_hi_out(HI_in));


mux_lo	b2v_inst34(
	.mux_lo_control(SYNTHESIZED_WIRE_61),
	.lo_div_out(SYNTHESIZED_WIRE_62),
	.lo_mult_out(SYNTHESIZED_WIRE_63),
	.mux_lo_out(LO_in));


mux_pc_source	b2v_inst35(
	.AluOut_out(SYNTHESIZED_WIRE_98),
	.concatena_pc_out(SYNTHESIZED_WIRE_65),
	.epc_out(EPC_out),
	.mdr_out(SYNTHESIZED_WIRE_92),
	.mux_pc_source_control(SYNTHESIZED_WIRE_68),
	.ULA_out(SYNTHESIZED_WIRE_90),
	.mux_pc_source_out(PC_in));


mux_b	b2v_inst36(
	.mux_b_control(SYNTHESIZED_WIRE_70),
	.regB_out(Saida_b),
	.shift_left_2_mux_out(SYNTHESIZED_WIRE_71),
	.singExtend16_32_out(SYNTHESIZED_WIRE_96),
	.mux_b_out(muxB_out));


mux_regDest	b2v_inst37(
	.inst15_11_out(Instr15_0[15:11]),
	.inst20_16_out(Instr20_16),
	.inst25_21_out(Instr25_21),
	.mux_regDest_control(SYNTHESIZED_WIRE_74),
	.mux_regDest_out(Write_reg));
	


sign_extend_16_32	b2v_inst38(
	.Instr15_0(Instr15_0),
	.sign_extend_16_32_out(SYNTHESIZED_WIRE_96));


Ula32	b2v_inst6(
	.A(muxA_out),
	.B(muxB_out),
	.Seletor(SYNTHESIZED_WIRE_77),
	.Overflow(SYNTHESIZED_WIRE_81),
	
	
	.Igual(SYNTHESIZED_WIRE_79),
	.Maior(SYNTHESIZED_WIRE_78),
	.Menor(SYNTHESIZED_WIRE_97),
	.S(SYNTHESIZED_WIRE_90));


controle	b2v_inst7(
	.clk(CLOCK),
	.reset(RESET),
	.greater(SYNTHESIZED_WIRE_78),
	.equals(SYNTHESIZED_WIRE_79),
	.lesser(SYNTHESIZED_WIRE_97),
	.overflow(SYNTHESIZED_WIRE_81),
	.zeroDiv(SYNTHESIZED_WIRE_82),
	.funct(Instr15_0[5:0]),
	.opcode(Instr31_26),
	.memControl(SYNTHESIZED_WIRE_10),
	.PCControl(SYNTHESIZED_WIRE_88),
	.regControl(Reg_write),
	.multControl(SYNTHESIZED_WIRE_20),
	.divControl(SYNTHESIZED_WIRE_22),
	.memData(SYNTHESIZED_WIRE_86),
	.epcControl(SYNTHESIZED_WIRE_6),
	.aluOutControl(SYNTHESIZED_WIRE_2),
	.IRControl(SYNTHESIZED_WIRE_27),
	.shiftSource(SYNTHESIZED_WIRE_37),
	.shiftArtSource(SYNTHESIZED_WIRE_39),
	.AControl(SYNTHESIZED_WIRE_0),
	.BControl(SYNTHESIZED_WIRE_4),
	.HILOControl(SYNTHESIZED_WIRE_91),
	.muxHI(SYNTHESIZED_WIRE_58),
	.muxLO(SYNTHESIZED_WIRE_61),
	.aluControl(SYNTHESIZED_WIRE_77),
	.dataSource(SYNTHESIZED_WIRE_49),
	.excptControl(SYNTHESIZED_WIRE_32),
	.IorD(SYNTHESIZED_WIRE_35),
	.muxAControl(SYNTHESIZED_WIRE_56),
	.muxBControl(SYNTHESIZED_WIRE_70),
	.PCSource(SYNTHESIZED_WIRE_68),
	.regDest(SYNTHESIZED_WIRE_74),
	.shiftControl(SYNTHESIZED_WIRE_19),
	.slsControl(SYNTHESIZED_WIRE_16),
	.sssControl(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst7.ADD = 7'b0000001;
	defparam	b2v_inst7.ADD_AND_SUB = 7'b0000010;
	defparam	b2v_inst7.ADDI = 7'b0000011;
	defparam	b2v_inst7.ADDI_ADDIU = 7'b0000100;
	defparam	b2v_inst7.ADDIU = 7'b0000101;
	defparam	b2v_inst7.AND = 7'b0000110;
	defparam	b2v_inst7.BEQ = 7'b0000111;
	defparam	b2v_inst7.BEQ2 = 7'b1010101;
	defparam	b2v_inst7.BGT = 7'b0001000;
	defparam	b2v_inst7.BGT2 = 7'b0111011;
	defparam	b2v_inst7.BLE = 7'b0001001;
	defparam	b2v_inst7.BLE2 = 7'b0111010;
	defparam	b2v_inst7.BLM = 7'b0001010;
	defparam	b2v_inst7.BLM2 = 7'b0001011;
	defparam	b2v_inst7.BLM3 = 7'b0111101;
	defparam	b2v_inst7.BLM_WAIT = 7'b0001100;
	defparam	b2v_inst7.BNE = 7'b0001101;
	defparam	b2v_inst7.BNE2 = 7'b1101011;
	defparam	b2v_inst7.BREAK = 7'b0001111;
	defparam	b2v_inst7.DECODE = 7'b0010000;
	defparam	b2v_inst7.DIV = 7'b0010001;
	defparam	b2v_inst7.DIV0 = 7'b0010010;
	defparam	b2v_inst7.DIV2 = 7'b1000011;
	defparam	b2v_inst7.DIV_WAIT = 7'b1000001;
	defparam	b2v_inst7.EXCEPTION = 7'b0010011;
	defparam	b2v_inst7.fADD = 6'b100000;
	defparam	b2v_inst7.fAND = 6'b100100;
	defparam	b2v_inst7.fBREAK = 6'b001101;
	defparam	b2v_inst7.fDIV = 6'b011010;
	defparam	b2v_inst7.FETCH = 7'b0010100;
	defparam	b2v_inst7.FETCH2 = 7'b0010101;
	defparam	b2v_inst7.FINAL_EXCEPTION = 7'b0001110;
	defparam	b2v_inst7.fJR = 6'b001000;
	defparam	b2v_inst7.fMFHI = 6'b010000;
	defparam	b2v_inst7.fMFLO = 6'b010010;
	defparam	b2v_inst7.fMULT = 6'b011000;
	defparam	b2v_inst7.fRTE = 6'b010011;
	defparam	b2v_inst7.fSLL = 6'b000000;
	defparam	b2v_inst7.fSLLV = 6'b000100;
	defparam	b2v_inst7.fSLT = 6'b101010;
	defparam	b2v_inst7.fSRA = 6'b000011;
	defparam	b2v_inst7.fSRAV = 6'b000111;
	defparam	b2v_inst7.fSRL = 6'b000010;
	defparam	b2v_inst7.fSUB = 6'b100010;
	defparam	b2v_inst7.fXCHG = 6'b000101;
	defparam	b2v_inst7.J = 7'b0010110;
	defparam	b2v_inst7.JAL1 = 7'b0010111;
	defparam	b2v_inst7.JAL2 = 7'b0011000;
	defparam	b2v_inst7.JR = 7'b0011001;
	defparam	b2v_inst7.LOAD_SET = 7'b0111111;
	defparam	b2v_inst7.LOAD_WAIT = 7'b0011100;
	defparam	b2v_inst7.LUI = 7'b0011101;
	defparam	b2v_inst7.LW_LH_LB = 7'b0011111;
	defparam	b2v_inst7.MFHI = 7'b0100000;
	defparam	b2v_inst7.MFLO = 7'b0100001;
	defparam	b2v_inst7.MULT = 7'b0100010;
	defparam	b2v_inst7.MULT2 = 7'b1000010;
	defparam	b2v_inst7.MULT_WAIT = 7'b1000000;
	defparam	b2v_inst7.NO_OPCODE = 7'b0100011;
	defparam	b2v_inst7.opADDI = 6'b001000;
	defparam	b2v_inst7.opADDIU = 6'b001001;
	defparam	b2v_inst7.opBEQ = 6'b000100;
	defparam	b2v_inst7.opBGT = 6'b000111;
	defparam	b2v_inst7.opBLE = 6'b000110;
	defparam	b2v_inst7.opBLM = 6'b000001;
	defparam	b2v_inst7.opBNE = 6'b000101;
	defparam	b2v_inst7.opJ = 6'b000010;
	defparam	b2v_inst7.opJAL = 6'b000011;
	defparam	b2v_inst7.opLB = 6'b100000;
	defparam	b2v_inst7.opLH = 6'b100001;
	defparam	b2v_inst7.opLUI = 6'b001111;
	defparam	b2v_inst7.opLW = 6'b100011;
	defparam	b2v_inst7.opRTYPE = 6'b000000;
	defparam	b2v_inst7.opSB = 6'b101000;
	defparam	b2v_inst7.opSH = 6'b101001;
	defparam	b2v_inst7.opSLTI = 6'b001010;
	defparam	b2v_inst7.opSW = 6'b101011;
	defparam	b2v_inst7.OVERFLOWS = 7'b0100100;
	defparam	b2v_inst7.RTE = 7'b0100101;
	defparam	b2v_inst7.SB = 7'b0100110;
	defparam	b2v_inst7.SH = 7'b0100111;
	defparam	b2v_inst7.SLL = 7'b0101000;
	defparam	b2v_inst7.SLLV = 7'b0101001;
	defparam	b2v_inst7.SLT = 7'b0101010;
	defparam	b2v_inst7.SLTI = 7'b0101011;
	defparam	b2v_inst7.SRA = 7'b0101100;
	defparam	b2v_inst7.SRAV = 7'b0101101;
	defparam	b2v_inst7.SREG_OUT = 7'b0101110;
	defparam	b2v_inst7.SRL = 7'b0101111;
	defparam	b2v_inst7.START = 7'b0000000;
	defparam	b2v_inst7.STORE_PC = 7'b0110000;
	defparam	b2v_inst7.STORE_SET = 7'b0011110;
	defparam	b2v_inst7.STORE_WAIT = 7'b0110001;
	defparam	b2v_inst7.SUB = 7'b0110010;
	defparam	b2v_inst7.SW = 7'b0110011;
	defparam	b2v_inst7.SW_SH_SB1 = 7'b0110100;
	defparam	b2v_inst7.SW_SH_SB2 = 7'b0110101;
	defparam	b2v_inst7.WAIT = 7'b0110110;
	defparam	b2v_inst7.WAIT_FINAL = 7'b0111001;
	defparam	b2v_inst7.XCHG1 = 7'b0110111;
	defparam	b2v_inst7.XCHG2 = 7'b0111000;


Registrador	b2v_LO(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_91),
	.Entrada(LO_in),
	.Saida(SYNTHESIZED_WIRE_47));


Registrador	b2v_Memory_Data_Register(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_86),
	.Entrada(SYNTHESIZED_WIRE_95),
	.Saida(SYNTHESIZED_WIRE_92));


Registrador	b2v_PC(
	.Clk(CLOCK),
	.Reset(RESET),
	.Load(SYNTHESIZED_WIRE_88),
	.Entrada(PC_in),
	.Saida(Saida));


endmodule
