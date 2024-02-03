module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);

	output [63:0] BusA;
	output [63:0] BusB;
	input [63:0] BusW;
	input [4:0] RA;//each register five bits wide
	input [4:0] RB;
    	input [4:0] RW;
    	input RegWr;
    	input Clk;
    	reg [63:0] registers [31:0];

	assign #2 BusA = RA == 5'd31 ? 0 : registers[RA];//assign register A and B to their buses
	assign #2 BusB = RB == 5'd31 ? 0 : registers[RB];//if x31, always read 0

	always @ (negedge Clk) begin
	   if(RegWr == 1)//assign write bus if reg wr is 1
		registers[RW] <= #3 BusW;	
	end

endmodule	