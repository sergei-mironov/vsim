entity main is
end entity main ;

architecture arch of main is

    -- type t is range -1 to 10;
    -- type t is integer;

	signal s1 : integer;
	signal s2 : integer;
    signal s : integer;
begin
    s <= s1 + s2;

    main: process(s)
	begin
		report integer'image(s);
    end process;

end;

