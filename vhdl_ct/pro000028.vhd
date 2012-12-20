-- Prosoft VHDL tests.
--
-- Copyright (C) 2011 Prosoft.
--
-- Author: Zefirov, Scherbinin.
--
-- This is a set of simplest tests for isolated tests of VHDL features.
--
-- Nothing more than standard package should be required.
--
-- Categories: entity, architecture, process, type, subtype, case, enumerations, array, for-loop, function, Attributes-of-the-array-type-or-objects-of-the-array-type

use work.std_logic_1164_for_tst.all;

entity test_generate is
generic(N:natural:=8);
port
    (
        in_bit  :   in  bit;
        out_bit :   out bit
    );
end entity test_generate;

architecture test_generate_arch of test_generate is

signal tst_signal   : bit := '0';
signal tst_vector   : bit_vector(0 to N-1):=('0','0','0','0','0','0','0','0');

begin

    tst_signal <= '1';

    G2:
    if (N > 5) generate
        tst_vector(7) <= '1';
        tst_vector(6) <= '1';
    end generate G2;
    
    
    
    validate_g1: process (tst_vector) is
    variable i : bit;
    begin
            i := tst_signal;
            
            assert (  ( (tst_vector(6) = '1') and (tst_vector(7) = '1') and i='1' )  or i = '0')
                report "PRO000028: failure: wrong value."
                severity ERROR;
    end process validate_g1;
end architecture test_generate_arch;


entity ENT00028_Test_Bench is
end ENT00028_Test_Bench;

architecture ARCH00028_Test_Bench of ENT00028_Test_Bench is

signal input, output : bit;
    
begin
    input <= not input after 10 ns;

    test_entity: entity work.test_generate
        port map
        (
        in_bit  =>  input,
        out_bit =>  output
        );
    
end ARCH00028_Test_Bench ;
