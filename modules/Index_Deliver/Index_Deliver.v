
module Index_Deliver (
    input shift, clock, reset,
	 input [5:0] index,
    output [5:0] random_number
);
   parameter Cell_ptr = 58;
	reg [5:0] memory [Cell_ptr-1:0];
	integer i;
	 
	initial	// this will get done on programming
		begin
			for (i = 0; i < Cell_ptr; i = i + 1) 
				begin // Define a scope from 0 to 57, with 57 abandoned in later number selections
					memory[i] <= i + 6'b1; // Clear the memory
				end
		end 
	 
	 assign random_number = memory[index];
    // Comparing the stored and new generated value (register)
    always @(posedge clock or posedge reset) 
		begin
			if (reset) 
				begin
					for (i = 0; i < Cell_ptr; i = i + 1) 
						begin // Define a scope from 0 to 57, with 57 abandoned in later number selections
							memory[i] <= i + 6'b1; // Clear the memory
						end
				end 
		  else 
				begin
					if (shift == 1'b1) 
						begin
							// Start detection, if not duplicate, output valid signal
							for(i = 0; i < (Cell_ptr - 1); i = i + 1) 
								begin
									if(i >= index) 
									   begin
									      memory[i] <= memory[i + 1]; // Regist the stored values
									      memory[Cell_ptr-1] <= memory[Cell_ptr-1];
									end		
								end
						end
				end
		end
endmodule

