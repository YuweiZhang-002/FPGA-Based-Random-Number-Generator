module Synchronizer_Cntout(
   output reset,  // Output synchronized signal
   input Counter_out, clock  // Input asynchronous signals
);

   reg middle, reset_sig_temp;
	assign reset = reset_sig_temp;// Define the single clock cycle output 
	
	always @(posedge clock) begin
	   middle <= Counter_out;
	   reset_sig_temp <= middle; // Two Stages
	end
endmodule
	