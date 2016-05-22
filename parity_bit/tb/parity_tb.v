// Testbench and test to see parity_bit_gen in
// action. Generates a reset signal that will send
// out a fixed pattern from a shift register along
// with wr_en pulses.
//
// Depending on setting of EVEN_PARITY_BIT, output
// wire 'parity_bit' will indicate result.

`timescale 1ns/1ns

module parity_tb();

	 parameter SCLK_PERIOD = 20;
	 parameter START_PATTERN = 4'b1011; // Data word to check for parity.
	 parameter NUM_BITS = 8'd4; // Number of bits in data word.
	 parameter EVEN_PARITY_BIT = 1'b1; // If set, DUT will indicate even parity.
	 
	 reg sclk;
	 reg rst_n;
	 
	 wire data_in;
	 wire wr_en;
	 wire parity_bit;
	 
	 always begin // clk_gen
			#(SCLK_PERIOD/2) sclk = ~sclk;
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
	 
   parity_bit_gen 
		 #(
			 .EVEN_PARITY_BIT(EVEN_PARITY_BIT)
			 )
	 DUT (
				.data_in(data_in),
				.wr_en(wr_en),
				.clk(sclk),
				.rst_n(rst_n),
				.data_out(parity_bit)
				);

	 shift_reg 
		 #(
			 .START_PATTERN(START_PATTERN), 
			 .NUM_BITS(NUM_BITS)
			 )
	 data_gen (
						 .clk(sclk),
						 .rst_n(rst_n),
						 .wr_en(wr_en),
						 .data_out(data_in)
						 );
   
endmodule
