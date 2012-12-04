

library ieee;
use ieee.std_logic_1164.all;

entity test is
end entity test;

architecture atest of test is
	-- signal s : bit;
	signal t : bit;
begin
    main1: process
	begin
		t <= '1';
		t <= '0';
    end process;

    -- main2: process(s)
	-- begin
		-- t <= '0';
    -- end process;

    -- main2: process(s)
	-- begin
    -- end process;

	-- s <= '1';
end;
