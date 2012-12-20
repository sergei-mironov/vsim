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

function resolve_bit_or(s : bit_vector) return bit is
variable v : bit := '0';
variable i : integer;
begin
    for i in s'range loop
        v := v or s(i);
    end loop;
    return v;
end function resolve_bit_or;

subtype resolved_bit is resolve_bit_or bit;

signal test_resolved_bit : resolved_bit := '0';

type int_vector is array (integer range <>) of integer;

function resolve_integer_sum(s : int_vector) return integer is
variable v : integer := 0;
variable i : integer;
begin
    for i in s'range loop
        v := v + s(i);
    end loop;
    return v;
end function resolve_integer_sum;

subtype resolved_integer is resolve_integer_sum integer;

signal test_resolved_integer : resolved_integer := 0;
signal test_vector_signal    : bit_vector(0 to 8);

signal tst_signal       : resolved_bit      :=  '0';
signal tst_vector       : bit_vector(0 to N-1):=('0','0','0','0','0','0','0','0');
signal model_vector     : bit_vector(0 to N-1):=('0','0','1','0','1','0','1','0');

begin
    g1: for i in 0 to N-1 generate
        test_resolved_bit <= '1';
    end generate g1;
    out_bit <= in_bit xor test_resolved_bit;

    g2: for i in 0 to N-1 generate
        tst_vector(i) <= model_vector(i);
        tst_signal <= '1';
    end generate g2;
    
    validate_g1: process (tst_vector) is
    variable i : bit;
    variable pooh : integer := 0;
    begin
    
        for k in 0 to N-1 loop
            i := tst_signal;
            
            assert (  ( (tst_vector(k) = model_vector(k)) and i='1' )  or i = '0')
                report "PRO000027: failure: wrong value."
                severity ERROR;
        end loop;
        if pooh /= 0 then
            report "pooh mismatch!" severity ERROR;
        end if;
    end process validate_g1;
end architecture test_generate_arch;


entity ENT00027_Test_Bench is
end ENT00027_Test_Bench;

architecture ARCH00027_Test_Bench of ENT00027_Test_Bench is

signal input, output : bit;
    
begin
    input <= not input after 10 ns;

    test_entity: entity work.test_generate
        port map
        (
        in_bit  =>  input,
        out_bit =>  output
        );
    
end ARCH00027_Test_Bench ;
