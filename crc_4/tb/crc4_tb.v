// Testbench and test to see parity_bit calculator in
// action. Generates a reset signal that will send
// out a fixed pattern from a shift register along
// with wr_en pulses.
//
// If odd number of bits seen, parity_bit will be high.

//`timescale 1ns/1ns

module crc4_tb();

	 parameter SCLK_PERIOD = 20;
	 parameter START_PATTERN = 'b011100110; // Data word to check for parity.
	 parameter NUM_BITS = 8'd9; // Number of bits in data word.
	 

	 reg sclk;
	 reg rst_n;
	 
	 wire data_in;
	 wire wr_en;
   wire [2:0] crc_word;
	 
	 always begin // clk_gen
			#(SCLK_PERIOD) sclk = ~sclk;
	 end
	 
	 initial begin // rst_gen
			rst_n = 1'b1;
			sclk = 1'b0;
			#100;
			rst_n = 1'b0;
			#100;
			rst_n = 1'b1;
			#1000;
			$finish;
	 end

	 initial begin // waves
      $dumpfile("dump.vcd");
      $dumpvars(0); 
	 end
	 
	 
   crc4_gen DUT (
									.data_in(data_in),
									.wr_en(wr_en),
									.clk(sclk),
									.rst_n(rst_n),
									.crc_word(crc_word)
									);

	 shift_reg #(
							 .START_PATTERN(START_PATTERN), 
							 .NUM_BITS(NUM_BITS))
	 data_gen (
						 .clk(sclk),
						 .rst_n(rst_n),
						 .wr_en(wr_en),
						 .data_out(data_in)
						 );
   
endmodule
