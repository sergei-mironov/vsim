library IEEE;
use ieee.std_logic_1164.all;

entity clk_test is
end entity clk_test;

architecture arch_test of clk_test is
signal clk : std_logic := '0';
signal counter : integer := 0;
signal next_counter : integer := 0;


begin
    clk <= not clk after 500 ns;
--    clk <= not counter after 500 ns;
    next_counter <= counter + 1 + 3 mod (2 rem 6);
    main: process (clk)
    begin
       if clk'event and clk = '1' then
            counter <= next_counter;
       end if;

    end process;
end architecture arch_test;


