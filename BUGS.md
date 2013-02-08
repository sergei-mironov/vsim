### MDo Bug

MDo notation works weirdly and causes 'thread blocked indefinitely in an MVar
operation'. Testes on GHC 7.6.1 and 7.4.2

### Arrays indexing

All low-level array indexes should start with 0 independently
of VHDL type. Currently they are mixed with first used user type.
