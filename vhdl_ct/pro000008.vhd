-- Prosoft VHDL tests.
--
-- Copyright (C) 2011 Prosoft.
--
-- Author: Zefirov, Karavaev.
--
-- This is a set of simplest tests for isolated tests of VHDL features.
--
-- Nothing more than standard package should be required.
--
-- Categories: entity, architecture, process, after, component, resolved, when-else.

use work.std_logic_1164_for_tst.all;

entity ENT00005 is
    port(
        latch : in boolean;
        io : inout std_logic
    );
end entity;

architecture ARCH00005 of ENT00005 is

signal power : boolean := false;
signal en_out_z : boolean := false;

begin

    power <= not power after 4 us;
    
    en_out_z <= not en_out_z after 10 us;

    io <=
         'Z' when en_out_z
    else '1' when latch and power
    else 'H' when latch and not(power)
    else 'L' when not(latch) and not(power)
    else '0';
    
end ARCH00005;

use work.std_logic_1164_for_tst.all;

entity ENT00005_Test_Bench is
end entity;

architecture ARCH00005_Test_Bench of ENT00005_Test_Bench is

component ENT00005 is
    port(
        latch : in boolean;
        io : inout std_logic
    );
end component;

signal latch : boolean := false;
signal io1, io2 : std_logic;

signal input_z : std_logic;
signal en_z : boolean := false;
signal en_in_z : boolean := false;

begin

    en_z <= not en_z after 3 us;
    
    en_in_z <= not en_in_z after 5 us;
    
    input_z <= 'Z' when en_z else 'H';

    io1 <= 'H' when (not latch) else input_z when en_in_z else '0';
    io2 <= 'H' when (not latch) else input_z when en_in_z else '0';
    latch <= not latch after 1 us;
    
    UUT1: ENT00005
    port map (
          latch => latch
        , io => io1
    );
    
end ARCH00005_Test_Bench;