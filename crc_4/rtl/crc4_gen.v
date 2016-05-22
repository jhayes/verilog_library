module crc4_gen (
									input wire 			 clk,
									input wire 			 rst_n,
									input wire 			 wr_en,
									input wire 			 data_in,
									output reg [2:0] crc_word
									);


	 always @(posedge clk, negedge rst_n) begin
			if(rst_n == 0) begin
				 crc_word <= 3'b0;
			end else if(wr_en) begin
         if(crc_word[2]) begin
            crc_word <= {crc_word[1:0], data_in} ^ 3'b011;
				 end else begin
            crc_word <= {crc_word[1:0], data_in};
         end
			end else begin
				 crc_word <= crc_word;
			end // else: !if(wr_en)
			
	 end
	 

endmodule // crc_4_gen
