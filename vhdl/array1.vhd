-- basic array declarations

entity test is
end entity test;

architecture test_arch of test is
    constant size : integer := 10;
    type vector is array (0 to size-1) of integer;

    constant c1 : integer := 1;
    constant c2 : integer := 2;
    constant c3 : integer := 3;
    signal x1 : vector := (c1 => c1, 2=>2, others => c3);

    type infvector is array (integer range <>) of integer;
    constant x2 : infvector := (0 => 0, 1 => 1, 2 => 2);

begin

    main: process
    begin
        report integer'image(x2'left);
        report integer'image(x2'right);
        assert false report "end of simulation" severity failure;
    end process;

end architecture test_arch;


