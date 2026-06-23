module Timer (
    output Timer_exceed,
	 input reset,
    input clock,
	 input Timer_on
);  
    reg [28:0] Timerflag; 
	 
	 assign Timer_exceed = Timerflag == 29'd10;
	 //assign Timer_exceed = Timerflag == 29'd399999999;
	 
	 // Outputs a pulse signal every 8 seconds
    always @ (posedge clock or posedge reset) begin
	   if(reset) begin
		   Timerflag <= 0;
		end
		else if (Timer_on)begin
		 // SET 29'd399999999 (8 seconds), for testing, set 29'd10
         if (Timerflag == 29'd10) begin
//		    if (Timerflag == 29'd399999999) begin
            Timerflag <= 0;
         end 
         else begin // Counting time
             Timerflag <= Timerflag + 1; 
         end
		end
		else begin // State when no signal input
		   Timerflag <= 29'd0;
		end
   end 
endmodule  