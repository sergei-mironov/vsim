-- Aggregate assignments

entity test is
end entity test;

architecture test_arch of test is
	type vector is array (0 to 10) of integer;
    signal a : vector;

begin
	main: process
	begin

        a <= (0=>0, 1=>1*1, 2=>2*1, others=>33*1) after 1 us,
             (0=>0, 1=>1*2, 2=>2*2, others=>33*2) after 2 us,
             (0=>0, 1=>1*3, 2=>2*3, others=>33*3) after 3 us;

        wait for 10 us;
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;



