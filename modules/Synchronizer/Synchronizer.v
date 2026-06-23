module Synchronizer (
    output sync_out,
    input clock,
    input async_in
	 
);
    reg meta, meta_2; // Middle state
	 assign sync_out = meta_2;
    always @(posedge clock) begin
	 
       meta <= async_in;
       meta_2 <= meta; // Data delivered in sequence
		 
    end
endmodule