module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
  output [63:0] NextPC; 
  reg NextPC;

  wire [63:0] SignExtShifted;  
  assign SignExtShifted = SignExtImm64 << 2; //shift the extended
always @(*)
    begin
      if (Uncondbranch==1'b1 || (ALUZero ==1'b1 && Branch == 1'b1))//B or CB
               begin
                NextPC = SignExtShifted + CurrentPC; //nextPC = shifted + current
            end
        else//no branch
            begin
                NextPC = CurrentPC +64'b100;//shifitng nextpc
            end
    end  
endmodule