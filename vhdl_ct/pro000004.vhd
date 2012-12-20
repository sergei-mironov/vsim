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
-- Categories: entity, architecture, process, if-then-else.


entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture ARCH00001_Test_Bench of ENT00001_Test_Bench is
begin
    main: process
    type enumeration is (a,b,c);
    begin
        if true then
            report "Correct THEN selected.";
        else
            report "Incorrect ELSE selected." severity FAILURE;
        end if;
        if false then
            report "Incorrect THEN selected." severity FAILURE;
        else
            report "Correct ELSE selected.";
        end if;
        case a is
            when a => report "Correct A selected.";
            when others => report "Incorrect others selected." severity failure;
        end case;
        case b is
            when a => report "Incorrect A selected." severity failure;
            when others => report "Correct others selected.";
        end case;
        wait;
    end process;
end;
