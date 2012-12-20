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
-- Categories: entity, architecture, process, wait.

entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture ARCH00001_Test_Bench of ENT00001_Test_Bench is
begin
    main: process
    begin
        report "Start.";
        wait for 10 fs;
        report "Ten femtoseconds.";
        wait for 990 fs;
        report "One picosecond.";
        wait ;
    end process;
end;
