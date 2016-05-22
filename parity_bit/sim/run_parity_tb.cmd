iverilog -o compiled_files.out ..\tb\parity_tb.v ..\tb\shift_reg.v ..\rtl\parity_bit_gen.v 
vvp compiled_files.out
gtkwave dump.vcd