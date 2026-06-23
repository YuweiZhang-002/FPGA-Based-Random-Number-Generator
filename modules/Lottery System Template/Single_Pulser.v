module Single_Pulser(
	output key_A,
   input clock, key_V
);
	
	reg state;
	parameter state_1 = 1'b0, state_2 = 1'b1; // Define the state
	// Assigning the output signal key_A
	assign key_A = ((state == state_1) & ~key_V);
	
	always@(posedge clock)
	begin
		case(state)
		   state_1: begin
			   
				if(key_V == 1'b0) 
				   state = state_2; // Jump to next state and generate a pulse
					
				else state = state_1;
				
			end
			
			state_2: begin
			   
				if (key_V == 1'b1)
				   state = state_1; // Bounce back if stop pushing the button
					
				else state = state_2;// Remain at current state when bottom is pushed
					
			end
				
			default: // Set a default state
				state = state_1;
		endcase
	end
endmodule
		
		
  