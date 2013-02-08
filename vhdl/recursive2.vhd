-- Recursive procedures

entity test is
end entity test;

architecture test_arch of test is

    function f(constant i:integer) return integer;

    constant x : integer := f(0);

    function f(constant i:integer) return integer is
    begin
        return (i+1);
    end function;

begin

    main: process
    begin
        report integer'image(x);
        assert false report "end of simulation" severity failure;
    end process;

end architecture test_arch;

