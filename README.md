# verilog_library
Library of small verilog modules, for convenience.

## parity_bit
Module that indicates the parity of a stream of serialized data provided to it.

The module takes in serialized data and updates the parity indicator, depending 
on if a write enable signal is present.

A parameter is used to setup for even or odd parity (so if EVEN_PARITY_BIT == 1 
then it will output a high signal if an even number of ones has been seen so 
far in the data).

### structure
3 folders. 'rtl' holds the parity_bit_gen module. 'tb' holds the testbench and a 
block of logic to stimulate the design. 'sim' holds a run script for a setup 
under win10-icarus_verilog-gtkwave.

Design is small enough that it can be run using EDAPlayground also.

## crc_4
Module that calculates the CRC on a stream of serialized data provided to it.

The generator polynomial is x^3 + x + 1.

