module Index_Controller (
    output count,       // Output counting signal(Mention to fetch the index)
	 output stop,        // Output stop signal(pause the shifting progress)
    output shift,       // Output shifting signal
    input clock,
    input reset,
    input enable,
	 input generate_on,  // Fetch a value
    input timer_exceed  // Timer meets the maximum
);
 

    parameter state_idle = 2'b00, state_count = 2'b01, state_shift = 2'b10;
 
    reg [1:0]state; 
 
    // The system will reacts on the input signals
    always @(posedge clock or posedge reset) begin
        if (reset) 
            state <= state_idle;  // Reset
        else begin
            case(state)
				    state_idle: begin
					     if(enable)
						      state <= state_count;
							else
							   state <= state_idle;
					 end
                state_count: begin
                    if (generate_on) 
                        state <= state_shift;  // If enable is HIGH, system will jumps to state shift
                    else
                        state <= state_count;  // Else: remain at state count
                end
                state_shift: begin
                    if (timer_exceed)
                        state <= state_count;  // If timer exceeds, remain at state count
                    else
                        state <= state_shift;  // if not: remain at state shift
                end
					 
                default: state <= state_count;  // Default
            endcase
        end
    end
 
    // Output logic
	 assign count = ((state == state_idle) && enable) || (state == state_shift) && timer_exceed;// define count signal 
    assign stop = (state == state_count) && generate_on;             // define stop signal
    assign shift = (state == state_shift) && timer_exceed;           // define shift signal 
 
endmodule