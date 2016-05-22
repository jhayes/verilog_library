// Testbench and test to see parity_bit_gen in
// action. Generates a reset signal that will send
// out a fixed pattern from a shift register along
// with wr_en pulses.
//
// Checks output answer at the end and indicates 
// success or failure.
//
// Depending on setting of EVEN_PARITY_BIT, output
// wire 'parity_bit' will indicate result.

`timescale 1ns/1ns

module parity_tb();

	 parameter SCLK_PERIOD = 20;
	 parameter NUM_BITS = 8'd4; // Number of bits in data word.
	 parameter EVEN_PARITY_BIT = 1'b1; // If set, DUT will indicate even parity.
	 parameter NUM_TESTS = 5; // Number of times to restart simulation and rerun test.
	 
	 reg sclk;
	 reg rst_n;
	 reg start_pulse;
	 
	 wire data_in;
	 wire wr_en;
	 wire parity_bit;
	 reg 	tb_answer;
	 reg 	test_failed;
	 
   reg [NUM_BITS-1:0] data_word;
   
   integer 						test_cnt;
	 
	 always begin // clk_gen
			#(SCLK_PERIOD/2) sclk = ~sclk;
	 end
	 
	 initial begin // test
			init();
			for(test_cnt=0; test_cnt < NUM_TESTS; test_cnt=test_cnt+1) begin
         re_init();
         @(negedge wr_en); // Wait for wr_en to go low (indicates transmission is finished).
				 @(posedge sclk);
				 
         tb_answer = (^data_word) ^ (EVEN_PARITY_BIT);   // Taking our START_PATTERN and XORing it, amounts to an odd checksum. XORing with EVEN_PARITY will invert answer if required.
         
         $display("============== Test %0d ==============", test_cnt);
         $display("============== Settings ==============");
         $display("Given data %0b, and EVEN_PARITY_BIT = %0b", data_word, EVEN_PARITY_BIT);
         $display("parity_bit_gen calculated %0b, and testbench calculated %0b.", parity_bit, tb_answer);
         
         $display("=============== Answer ===============");
         if(tb_answer == parity_bit) $display("Parity bit calculation successful.");
         else begin
						$display("Parity bit calculation failed.");
						test_failed = 1'b1;
				 end
				 $display("\n\n");
      end

			$display("\n");
			$display("============= Final Check =============");
			if(test_failed) $display("Overall Test Failure.");
			else $display("All tests passed.");
      $display("======================================");
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
			 .NUM_BITS(NUM_BITS)
			 )
	 data_gen (
						 .clk(sclk),
						 .rst_n(rst_n),
						 .wr_en(wr_en),
             .start_word(data_word),
						 .data_out(data_in)
						 );


	 task init(); // Init of clk, reset and test_failed flag on startup.
			begin
				 test_failed = 1'b0;
				 sclk = 1'b0;
				 rst_n = 1'b1;
			end
	 endtask

   task re_init(); // Re-initialize reset on restart of test and set up a new data_word for transmission.
			begin
         data_word = $random;
         rst_n = 1'b1;
				 gen_reset_pulse();
			end
   endtask

   
   task gen_reset_pulse(); // Generates a reset pulse.
			begin
				 rst_n = 1'b1;
				 repeat(3) @(posedge sclk);
				 rst_n = 1'b0;
				 repeat(5) @(posedge sclk);
				 #(SCLK_PERIOD/4); // Offset the release of the reset from clk for ease in scanning waveforms.
				 rst_n = 1'b1;
			end
   endtask
   
endmodule
