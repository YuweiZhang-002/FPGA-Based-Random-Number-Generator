module HexToBin (
   input [5:0]Index,
	output [3:0] Tens_Index, Ones_Index
);
   reg [3:0]temp_tens, temp_ones;
	
	assign Tens_Index = temp_tens;
	assign Ones_Index = temp_ones;
	
	always@ (*) begin
	   temp_tens = Index / 10;
		temp_ones = Index % 10;
	end
  
endmodule
  