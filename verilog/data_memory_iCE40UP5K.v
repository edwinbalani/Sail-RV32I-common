//Data memory iCE40UP5K using SPRAM

module data_memory (clk, addr, write_data, memwrite, memread, read_data);
	input clk;
	input[31:0] addr;
	input[31:0] write_data;
	input memwrite, memread;
	output [31:0] read_data;

	//internal signals
	wire[15:0] read_data_MSW;
	wire[15:0] read_data_LSW;
	wire WREN;
	wire CS;
	
	//SPRAM instantiations
	SB_SPRAM256KA datamem_MSW(
		.DATAIN(write_data[31:16]),
		.ADDRESS(addr[13:0]), //take lower 14 bits
		.WREN(WREN),
		.CHIPSELECT(CS),
		.CLOCK(clk),
		.DATAOUT(read_data_MSW),
		.MASKWREN(4'b1111), //4 bits to mask 16-bit (4-nibble) data
		.STANDBY(1'b0),
		.SLEEP(1'b0),
		.POWEROFF(1'b1)
	);
	
	SB_SPRAM256KA datamem_LSW(
		.DATAIN(write_data[15:0]),
		.ADDRESS(addr[13:0]), //take lower 14 bits
		.WREN(WREN),
		.CHIPSELECT(CS),
		.CLOCK(clk),
		.DATAOUT(read_data_LSW),
		.MASKWREN(4'b1111),
		.STANDBY(1'b0),
		.SLEEP(1'b0),
		.POWEROFF(1'b1)
	);
	
	//assignments
	assign read_data = {read_data_MSW, read_data_LSW};
	assign WREN = memwrite & (~memread);
	assign CS = memwrite | memread;
	
endmodule