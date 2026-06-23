module Single_Pulser_KeyW(
	output key_B,
   input reset, clock, key_W
);
	
	reg state;
	parameter state_1 = 1'b0, state_2 = 1'b1;
	// Assigning the output signal key_B
	assign key_B = ((state == state_1) & ~key_W);
	
	always@(posedge clock or posedge reset)
	begin
		if(reset) 
		   state = state_1;
			
		else begin
		   case(state)
		      state_1: begin
			   
				   if(key_W == 1'b0)
				      state = state_2;
					
				   else state = state_1;
				
			   end
			
			   state_2: begin
			   
				   if (key_W == 1'b1)
				      state = state_1;
					
				   else state = state_2;
					
				end
		   endcase
		end
	end
endmodule
		
		
  