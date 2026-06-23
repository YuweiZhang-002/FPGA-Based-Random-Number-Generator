module Controller (
    System_Start, Generate_on, Timer_on, Counter_on, clear, Require_clear,
    clock, Key_A, Key_B, Timer_out, Counter_out
);

//Define the input and output signals
    input clock;
    input Key_A; // First input signal 
    input Key_B; // Second input signal
	 input Counter_out; // Counter reaches to the maximum
	 input Timer_out; // Timer exceed signal
    output System_Start; // Signal to mention the generator start the counter
	 output Generate_on; // Start to mention the generator to generate the value
	 output Timer_on; // Start the timer
	 output Counter_on; // Start the counter and mention index controller to give the shift signal
	 output clear;
    output Require_clear;// Reset signal
	 
    parameter State_Finish = 0, State_Work = 1, State_Display = 2; 
    reg [1:0] state;
	 
	 assign System_Start = (state == State_Work) && Key_B == 1'b0; // Set Status System_Start
	 assign Generate_on = ((state == State_Work) && Key_B == 1'b1); // Set Status of Generate_on (start the random number generator)
	 assign Timer_on = (state == State_Display); // Set Status of Timer_on(Including display)
	 assign Counter_on = ((state == State_Display) && Timer_out == 1'b1); // Set status of Counter_on
	 assign clear = Key_A; // Define clear signal(clear the RNG)
	 assign Require_clear = state == State_Finish; // Define LED to highlight the system needs to be reset
	 
    always @(posedge clock or posedge Key_A)
    begin
	 
        //pstate <= nstate; // Set the states
		  
		  if (Key_A) begin // Set the working state if pushed the button
            state <= State_Work;
        end
        else begin  // Set the initial state

            case (state)
				
					 State_Finish: begin
						 
					 end
				
                State_Work: begin  // Signal Delivery state (to start the system)
						  
                   if (Key_B == 1'b1) begin // If pushed the button: jump to next state
                       state <= State_Display;
                   end
						 else if (Counter_out == 1'b1) begin
						     state <= State_Finish;
						 end
						 
                end
					 
                State_Display: begin  // Signal Delivery state (to fetch the random value)
						  
                    if (Timer_out == 1'b1) begin
                        state <= State_Work; // Back to previous state if time is up
                    end
						  
                end
					 
					 default: begin
					    
						 state <= State_Finish;
						 
					 end
					 
            endcase
        end
    end
	 
endmodule // SM1
