// This module is loaded with a START_PATTERN on
// receiving a reset signal. On release of the
// reset, the pattern is then sent out serially
// on the positive clk edge.
//
// A tally counter is included for convenience. 
// Also to turn off wr_en at the appropriate time.

module shift_reg (
									input wire 	clk,
									input wire 	rst_n,
                  input wire [NUM_BITS-1:0]	start_word,
									output reg 	wr_en,
									output reg data_out
									);

	 parameter NUM_BITS = 8'd3;
	 
   reg [NUM_BITS-1:0] 				data_word;
	 reg [7:0] 									tally;
	 
	 always @(posedge clk, negedge rst_n) begin
			if(rst_n == 0) begin
				 data_word <= start_word;
				 tally <= NUM_BITS;
				 wr_en <= 1'b0;
				 data_out <= 1'b0;
			end else if(tally != 8'd0) begin
				 data_word <= data_word << 1;
				 tally <= tally - 1;
				 wr_en <= 1'b1;
				 data_out <= data_word[NUM_BITS-1];
			end else begin
				 wr_en <= 1'b0;
				 data_word <= data_word;
				 tally <= tally;
				 data_out <= data_word[NUM_BITS-1];
			end
			
	 end

endmodule // shift_reg 
