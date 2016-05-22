iverilog -o compiled_files.out -g2012 ..\tb\parity_tb.v ..\tb\shift_reg.v ..\rtl\parity_bit_gen.v 
vvp compiled_files.out
gtkwave dump.vcd