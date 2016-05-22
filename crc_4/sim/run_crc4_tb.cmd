iverilog -o compiled_files.out ..\tb\crc4_tb.v ..\rtl\crc4_gen.v ..\tb\shift_reg.v 
vvp compiled_files.out
gtkwave dump.vcd