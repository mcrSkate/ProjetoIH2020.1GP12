module cpu (
    ports
);

wire AControl;
    Registrador A (clock, reset, AControl, br_out_A, regA_out);
    Registrador B (clock, reset, BControl, br_out_B, regB_out);
    Banco_reg br (clock, reset, regControl, )
endmodule