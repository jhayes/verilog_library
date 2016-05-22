iverilog -g2012 ..\tb\parity_tb.v ..\tb\shift_reg.v ..\rtl\parity_bit_gen.v 
vvp a.out
gtkwave dump.vcd