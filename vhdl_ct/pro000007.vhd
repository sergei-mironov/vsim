-------------------------------------------------------------------------------
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
-- Categories: entity, architecture, process, wait-for.

entity ENT00003_Test_Bench is
end entity;

architecture ARCH00003_Test_Bench of ENT00003_Test_Bench is

	signal tst : bit;

begin
	
	process
	begin
		tst <= '0';
		wait for 1 us;
		tst <= '1';
		wait for 1 us;
	end process;
	
end ARCH00003_Test_Bench;