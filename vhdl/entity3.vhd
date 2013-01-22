-- Simple entity test, array and indexed mappings

library ieee;
use ieee.std_logic_1164.all ;

entity main is
end entity main;

library ieee;
use ieee.std_logic_1164.all ;

entity unit1 is
    port (
       inum : in std_ulogic_vector (0 to 1);
       oled : out std_ulogic);
begin
end;

architecture unit1 of unit1 is
begin
    oled <= inum(0) and inum(1);
end architecture unit1;

architecture main of main is
    constant CYCLES : integer := 100;
    signal clk : integer := 0;
	signal o1 : std_ulogic;
	signal o2 : std_ulogic;
    signal o  : std_ulogic;
    signal const_1 : std_ulogic := '1';
    signal i : std_ulogic_vector (0 to 1);
begin

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		end if;
	end process;

    u1:entity unit1(unit1) port map(inum=>(0=>'0', 1=>const_1), oled=>o1);
    u2:entity unit1(unit1) port map(inum=>i, oled=>o2);

    i <= (others => '0');
	o <= o1 and o2;

    clk <= clk + 1 after 1 us;

end architecture main;

