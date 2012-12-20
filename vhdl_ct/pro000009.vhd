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
-- Categories: entity, architecture, process, after, component, if-then-else, procedure, constant.

entity ENT00006 is
    port(
        latch : in boolean
    );
end entity;

architecture ARCH00006 of ENT00006 is

constant flag_const : boolean := true;
signal flag : boolean := false;
signal cond : boolean;


procedure print_report_valid (cond : in boolean) is
begin
    if cond then
        report "OK. flag = flag_const" severity NOTE;
    else
        report "error: flag /= flag_const" severity NOTE;
    end if;
end procedure;

type boolVec is array (integer range <>) of boolean;
signal step : boolVec(1 to 3) := (others => false);

signal flag2 : boolean;

begin

    flag2 <= flag_const;
    
    process(step)
        variable init : boolean := true;
        variable v : boolean;
    begin
        if init then
            step(1) <= true;
            init := false;
        elsif step(1) then
            step(1) <= false;
            step(2) <= true;
            flag <= flag_const;
            v := cond;
        elsif step(2) then
            cond <= flag = flag_const;
            step(2) <= false;
            step(3) <= true;
            v := cond;
        elsif step(3) then
            v := cond;
            print_report_valid(cond);
            step(3) <= false;
        else
            null;
        end if;
    end process;
        
    
end ARCH00006;

entity ENT00006_Test_Bench is
end entity;

architecture ARCH00006_Test_Bench of ENT00006_Test_Bench is

component ENT00006 is
    port(
        latch : in boolean
    );
end component;

signal latch : boolean := false;

begin

    latch <= not latch after 1 us;
    
    UUT1: ENT00006
    port map (
        latch => latch
    );
    
    UUT2: ENT00006
    port map (
        latch => latch
    );
    
end ARCH00006_Test_Bench;