module DSPadder(input1,input2,out);
	input[31:0] input1;
	input[31:0] input2;
	output[31:0] out;

	SB_MAC16 i_sbmac16(
		.A(input1[31:16]),
		.B(input1[15:0]),
		.C(input2[31:16]),
		.D(input2[15:0]),
		.O(out),
		.CLK(),
		.CE(0),
		.AHOLD(1),//not sure it even matters -> using just combinatorial
		.BHOLD(1),
		.CHOLD(1),
		.DHOLD(1),
		.IRSTTOP(0),
		.IRSTBOT(0),
		.ORSTTOP(0),
		.ORSTBOT(0),
		.OLOADTOP(0),//keep output from adder
		.OLOADBOT(0),//keep output from adder
		.ADDSUBTOP(0),//set to add
		.ADDSUBBOT(0),
		.OHOLDTOP(1),//not sure it matters
		.OHOLDBOT(1),
		.CI(0),
		.ACCUMCI(0),
		.SIGNEXTIN(),
		.CO(),
		.ACCUMCO(),
		.SIGNEXTOUT()
	);

	// add_sub_32_all_pipelined_unsigned[24:0] = 001_0010001_1010001_0000_1111;	
	//add_sub_32_bypassed_unsigned[24:0] = 001_0010000_1010000_0000_0000
	defparam i_sbmac16.B_SIGNED			= 1'b0;
	defparam i_sbmac16.A_SIGNED			= 1'b0;
	defparam i_sbmac16.MODE_8x8			= 1'b1;

	defparam i_sbmac16.BOTADDSUB_CARRYSELECT	= 2'b00; // CARRY IN = 0
	defparam i_sbmac16.BOTADDSUB_UPPERINPUT	= 1'b1; // Y = D
	defparam i_sbmac16.BOTADDSUB_LOWERINPUT	= 2'b00; // Z = B
	defparam i_sbmac16.BOTOUTPUT_SELECT		= 2'b00;// OUTPUT = COMBINATORIAL
	defparam i_sbmac16.TOPADDSUB_CARRYSELECT	= 2'b10; //USE CARRY IN FROM LOWER
	defparam i_sbmac16.TOPADDSUB_UPPERINPUT	= 1'b1;  //W = C
	defparam i_sbmac16.TOPADDSUB_LOWERINPUT	= 2'b00; //X = A
	defparam i_sbmac16.TOPOUTPUT_SELECT		= 2'b00; //OUTPUT = COMBINATORIAL

	defparam i_sbmac16.PIPELINE_16x16_MULT_REG2	= 1'b0;
	defparam i_sbmac16.PIPELINE_16x16_MULT_REG1	= 1'b0;
	defparam i_sbmac16.BOT_8x8_MULT_REG		= 1'b0;
	defparam i_sbmac16.TOP_8x8_MULT_REG		= 1'b0;
	defparam i_sbmac16.D_REG			= 1'b0;//NOT CLOCKED
	defparam i_sbmac16.B_REG			= 1'b0;
	defparam i_sbmac16.A_REG			= 1'b0;
	defparam i_sbmac16.C_REG			= 1'b0;
endmodule
