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
-- Categories: entity, architecture, process, after, if-then-else, procedure, function.

entity ENT00008_Test_Bench is
end ENT00008_Test_Bench;

architecture ARCH00008_Test_Bench of ENT00008_Test_Bench is

	procedure Comp_3(In1,R:in real; Step :in integer; W1,W2:out real) is
	variable counter: Integer;
	variable W2_t, W1_t : real;
	begin
	  W1_t := 1.43 * In1;
	  W1 := 1.43 * In1;
	  W2_t := 1.0;
	  W2 := 1.0;
	  L1: for counter in 1 to Step loop
	    W2_t := W2_t * W1_t;
	    exit L1 when W2_t > R;
	  end loop L1;
	  W2 := W2_t;
	  W1 := W1_t;
	  assert ( W2_t < R )
	    report "Out of range"
		  severity Error;
	  
	end procedure Comp_3;
	
	procedure Transcoder_1 (variable Value: inout bit_vector (0 to 7)) is
	begin
	  case Value is
	    when "00000000" => Value:="01010101";
	    when "01010101" => Value:="00000000";
	    when others => Value:="11111111";
	  end case;
	end procedure Transcoder_1;
	
	procedure Proc_3 (X,Y : inout Integer) is
	  subtype Word_16 is integer range 0 to 65536;
	  variable Vb1,Vb2,Vb3,Vb4 : Real;
	  constant Pi : Real :=3.14;
	  function convToInt16 (r: real) return integer is
	  variable w16 : Word_16;
	  begin
		  if integer(r) > 65536 then
			  w16 := 65536;
          elsif integer(r) < 0 then
			  w16 := 0;
		  else
			  w16 := integer(r);
		  end if;
		  return w16;
	  end;
	  procedure Compute (variable V1, V2: Real) is
	  begin
		  Vb3 := V1 * V2;
	  end procedure Compute;
	  variable Vb3_int : integer;
	begin
		Vb1 := real(X)*Pi;
		Vb2 := real(Y)*Pi;
		Vb3 := real(X*Y)*Pi;
		Vb4 := 0.1;
		Compute(Vb3,Vb4);
		Vb3_int := convToInt16(Vb3);
		X := integer(Vb1) + Vb3_int;
		Y := integer(Vb2) - Vb3_int;
	end procedure Proc_3;
	
	signal p1o, p2o : real;
	
	signal do_comp : boolean := false;
	
begin
	
	do_comp <= not do_comp after 1 us;
	
	process(do_comp)
		variable v1, v2 : real;
		variable vbv : bit_vector(0 to 7) := "01010101";
		variable x : integer := 1;
		variable y : integer := 2;
	begin
		if do_comp then
			Comp_3(30.0,11.0,1,v1,v2);
			p1o <= v1;
			p2o <= v2;
			Transcoder_1(vbv);
			Proc_3(x,y);
		end if;
	end process;

end ARCH00008_Test_Bench ;