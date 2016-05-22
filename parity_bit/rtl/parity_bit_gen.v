// This module takes in data and if the wrte enable signal is set 
// (wr_en), it will then XOR this with the current state of our
// parity check.

module parity_bit_gen (
											 input wire data_in, // Data on which to perform a parity check.
											 input wire wr_en, // Write enable signal to indicate when new data has arrived.
											 input wire clk,
											 input wire rst_n,
											 output reg data_out // Output of our parity check. If high, indicates that an odd number of bits have been seen so far.
											 );

	 parameter EVEN_PARITY_BIT = 1'b0;
	 	 
	 always @(posedge clk, negedge rst_n) begin
			if(rst_n == 0) data_out <= EVEN_PARITY_BIT;
			else if (wr_en) data_out <= data_out ^ data_in;
			else data_out <= data_out;
	 end
	 
endmodule // parity_bit
