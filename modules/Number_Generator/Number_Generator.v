
module Number_Generator (
    input enable,clock,reset,key,
    output wire [5:0] random_number
);

    wire [5:0] index;
	 wire timer_on;
	 wire valid;
    
	 // Code for delivering the random number to register(counter)
    Index_Generator Index(.enable(enable), .clock(clock), .reset(reset), .key(key), .index(index), .timer_on(timer_on), .valid(valid));
	 
	 Index_Deliver Deliver(.enable(enable), .clock(clock), .reset(reset), .valid(valid), .index(index), .random_number(random_number));

endmodule

