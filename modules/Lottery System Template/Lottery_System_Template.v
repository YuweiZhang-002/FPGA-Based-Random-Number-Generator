module Lottery_System_Template (
    output [6:0] sevenseg_ten,
    output [6:0] sevenseg_one,
	 output Require_clear, // LED output to indicate system meets the maximum
    input clock,
	 input Key_V,
	 input Key_W
);
 
    // Define inner signals  
	 wire Sync_A;
	 wire Sync_B;
    wire Pulser_A;       
    wire Pulser_B;  
    wire enable;             
    wire generate_on;       
	 wire Timer_on; 
    wire timer_exceed;       
    wire display;            
    wire Counter_on;         
    wire clear;                  
    wire Counter_exceed;  
 
    // Synchronize the asynchronous signal
	 Synchronizer Sync_V (
	     .sync_out(Sync_A),
		  .clock(clock),
		  .async_in(Key_V)
	 );
	 
	  Synchronizer Sync_W (
	     .sync_out(Sync_B),
		  .clock(clock),
		  .async_in(Key_W)
	 );
    // Generate a positive pulse
    Single_Pulser sp_A (           
        .key_A(Pulser_A),
        .clock(clock),
        .key_V(Sync_A)
    );
 
    
    Single_Pulser sp_B (    
        .key_A(Pulser_B),
        .clock(clock),
        .key_V(Sync_B)   
    );
	 
    // Controller, controlling the random_number generator, timer and counter
    Controller controller (         
        .System_Start(enable),       
        .Generate_on(generate_on),   
        .Timer_on(Timer_on),                 
        .Counter_on(Counter_on), 
		  .clear(clear),
        .Require_clear(Require_clear),		  
        .clock(clock),     
        .Key_A(Pulser_A),        
        .Key_B(Pulser_B),        
        .Timer_out(timer_exceed),
        .Counter_out(Counter_exceed)    
    );

 
    // Timer, define the time
    Timer timer (
        .Timer_exceed(timer_exceed),            
        .Timer_on(Timer_on),          
        .reset(clear),
        .clock(clock)
    );
 
    // Counter, count the number of element and deliver a clear signal to counter
    Counter counter (
        .Counter_exceed(Counter_exceed),  
        .clock(clock),
        .clear(clear),              
        .signal(Counter_on)
    );
 
    // A combination of index controller, generator, deliver, value transformer and displayer
    Random_Number_Generator random_num_generator (
        .sevenseg_ten(sevenseg_ten), 
        .sevenseg_one(sevenseg_one),  
        .clock(clock),
        .reset(clear),
        .enable(enable),             
        .generate_on(generate_on),   
        .timer_exceed(timer_exceed), 
        .display(Timer_on)           
    );
endmodule