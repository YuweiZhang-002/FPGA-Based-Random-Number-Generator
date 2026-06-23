module Seven_Segment_Decoder (
    input [3:0] ten,
    input [3:0] one,
    input display,          // Display signal
    output [6:0] sevenseg_ten, // Tens digit output
    output [6:0] sevenseg_one  // Ones digit output
);

    
	 function [6:0] decode_digit; // Function to decode the value
	    input [3:0] digit;
		 begin
		    case (digit)
		       4'h0: decode_digit = 7'b1000000;
			    4'h1: decode_digit = 7'b1111001;
			    4'h2: decode_digit = 7'b0100100;
			    4'h3: decode_digit = 7'b0110000;
             4'h4: decode_digit = 7'b0011001;
             4'h5: decode_digit = 7'b0010010;
             4'h6: decode_digit = 7'b0000010;
             4'h7: decode_digit = 7'b1111000;
             4'h8: decode_digit = 7'b0000000;
             4'h9: decode_digit = 7'b0010000;
			    default: decode_digit = 7'b1111111;
		    endcase
		 end
	 endfunction
	 
	 assign sevenseg_ten = display ? decode_digit(ten) : 7'b1111111; // Assign the output tens signal
	 assign sevenseg_one = display ? decode_digit(one) : 7'b1111111; // Assign the output ones signal

endmodule
