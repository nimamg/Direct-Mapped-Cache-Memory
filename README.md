# Direct-Mapped-Cache-Memory 

A simple cache module implemented using SystemVerilog

The cache memory has 4K 32-bit memory cells, and uses Direct-Mapping to address the data. It reads the data from a 32K 32-bit memory module and based on spatial locality, fetches 4 data words every time a miss occurs.
