module Counter(
  output Counter_exceed,
  input clock, clear, signal);
  reg [2:0] count; // Define counter 
  
  assign Counter_exceed = count == 7;// Assign the exceed signal
  
  always @(posedge clock or posedge clear) begin
  
    if(clear) begin // If clear, clean all the stored values
	   count <= 3'd0;
	 end
	
    else begin
	   
		if (signal) begin // If not reaches to the maximum value
		
		  if ((count < 7)) begin // If not reaches to the maximum value
	     count <= count + 1; // Add 1 each clock cycle
	     end
		  
      end
		else 
		   count <= count; // counted value remains unchanegd
		
	 end
  end 
endmodule