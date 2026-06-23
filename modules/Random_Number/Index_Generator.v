
module Index_Generator (
    output [5:0] index,
    input  clock, reset, enable, stop 
);

    reg [5:0] random_value;       // Initial value for random_value
    integer Cell_ptr;

	 reg state;
	 parameter state_waiting = 1'b0, state_working = 1'b1;
	 
	 
	initial 
		begin
			random_value <= 0;
			Cell_ptr <= 58;
			state <= state_waiting;	 
		end
    
	 // Output index equals to current value
	 assign index = random_value;
	 
	 // Code for delivering the random number to register(counter)
	always @(posedge clock or posedge reset) begin
	
      if (reset)
	     begin
           random_value <= 0;
           Cell_ptr <= 58;
           state <= state_waiting;
        end
	   else 
	      begin
            if (state == state_working) begin // If system is in state_working
               if (random_value <= (Cell_ptr - 1)) // If not reaches to the maximum
                  random_value <= random_value + 1;
               else
                  random_value <= 0; // If reaches to the maximum
 
               if (stop)
                  state <= state_waiting; // Jump to next stage
					else 
					   state <= state_working;
            end
				
		      else if (state == state_waiting) // If system is in state_waiting
		         begin
				      if(enable) begin
                     Cell_ptr <= Cell_ptr - 1; // If an index is delivered and timer exceeds
                     state <= state_working;
                  end
				      else begin
				         state <= state_waiting; // Remain at the same state
				      end
				   end
			
		      else
			      state <= state_waiting;	// Automatically jumps to the waiting state 
				
      end
   end
endmodule

