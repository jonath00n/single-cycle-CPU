`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111
`define MOVZ  4'b0101


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    output  [63:0] BusW;
    input   [63:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [63:0] BusW;
    wire    [1:0] MovZOp;//adding labels for our desired bits
    wire    [15:0] MovZTemp;


    assign MovZOp = BusB[17:16];//assigning bits we need for movz operations to a new name
    assign MovZTemp = BusB[15:0];//because it's easier for debugging in gtkwave
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
            `AND: begin
                BusW = BusA & BusB;
            end
            `OR: begin
		BusW = BusA | BusB;
	    end
	    `ADD: begin
		BusW = BusA + BusB;
	    end
	    `SUB: begin
		BusW = BusA - BusB;
	    end
	    `MOVZ: begin //added movz shift
		case(MovZOp)//case statement to perform different operations depending on the MovOP bits
			2'b00: BusW = {{48{1'b0}}, MovZTemp};
			2'b01: BusW = {{32{1'b0}}, MovZTemp, {16{1'b0}}};
			2'b10: BusW = {{16{1'b0}}, MovZTemp, {32{1'b0}}};
			default : BusW = {MovZTemp, {48{1'b0}}};
		endcase
	    end
	    default: begin //passb
		BusW = BusB;
	    end
        endcase
    end

    assign Zero = ((BusW == 0) ? 1'b1 : 1'b0);
endmodule
