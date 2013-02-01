entity test is
end entity test;

architecture test_arch of test is

    type arr01 is array (0 to 1) of integer;

    function p1(a1 : arr01) return integer is
	begin
        return a1(0);
    end function;

begin

    main: process
        variable x : integer := 10;
	begin
		x := p1( (others => 0) ); -- <- HERE
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;


