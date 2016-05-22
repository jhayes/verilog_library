module shift_reg (
									input wire 	clk,
									input wire 	rst_n,
									output reg 	wr_en,
									output wire data_out
									);

	 parameter START_PATTERN = 3'b101;
	 parameter NUM_BITS = 8'd3;
	 
   reg [NUM_BITS-1:0] 				data_word;
	 reg [7:0] 									tally;
	 
	 always @(posedge clk, negedge rst_n) begin
			if(rst_n == 0) begin
				 data_word <= START_PATTERN;
				 tally <= NUM_BITS;
				 wr_en <= 1'b0;
				 
			end else if(tally != 8'd0) begin
				 data_word <= data_word << 1;
				 tally <= tally - 1;
				 wr_en <= 1'b1;
				 
			end else begin
				 wr_en <= 1'b0;
				 data_word <= data_word;
				 tally <= tally;
			end
			
	 end

   assign data_out = data_word[NUM_BITS-1];

	 
endmodule // shift_reg 
