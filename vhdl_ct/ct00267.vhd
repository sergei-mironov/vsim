-- NEED RESULT: ARCH00267: Parameters are initialized  passed
-- NEED RESULT: ARCH00267: Parameters are initialized  passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00267
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1.1.1 (1)
--    2.1.1.1 (2)
--    2.1.1.1 (3)
--    2.1.1.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00267)
--    ENT00267_Test_Bench(ARCH00267_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-JUL-1987   - initial revision
--    08-JUN-1988 - EL - remove tests of out params being initialize
--
-- NOTES:
--
--    ACCESS TYPES ARE FIXED AT NULL VALUES
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00267 of E00000 is
   procedure proc1( int_in : in integer ;
		    real_in : in real ;
		    bool_in : in boolean ;
                    bit_in : in bit ;
                    chr_in : in character ;
                    lev_in : in severity_level ;
                    time_in : in time ;
                    phys_in : in t_phys1 ;
                    int_inout : inout integer ;
		    real_inout : inout real ;
		    bool_inout : inout boolean ;
                    bit_inout : inout bit ;
                    chr_inout : inout character ;
                    lev_inout : inout severity_level ;
                    time_inout : inout time ;
                    phys_inout : inout t_phys1 ;
		    acc_inout : inout a_bit_vector ;
                    int_out : out integer ;
		    real_out : out real ;
		    bool_out : out boolean ;
                    bit_out : out bit ;
                    chr_out : out character ;
                    lev_out : out severity_level ;
                    time_out : out time ;
                    phys_out : out t_phys1 ;
		    acc_out : out a_bit_vector ) is
   begin
      -- this tests 2.1.1.1 (1) and 2.1.1.1 (2)
      test_report ( "ARCH00267" ,
		    "Parameters are initialized " ,
		    (int_in = 5) and
                    (real_in = 3.14159) and
                    (bool_in = true) and      -- note: bool covers enum types
                    (bit_in = '0') and
                    (chr_in = 'Z') and
                    (lev_in = WARNING) and
                    (time_in = 10ms) and
                    (phys_in = phys1_2) and
		    (int_inout = integer'right) and
                    (real_inout = real'right) and
                    (bool_inout = boolean'right) and
                    (bit_inout = bit'right) and
                    (chr_inout = character'right) and
                    (lev_inout = severity_level'right) and
                    (time_inout = time'right) and
                    (phys_inout = t_phys1'right) and
                    (acc_inout = null)
                  ) ;
      -- now set the inout & out parms
      int_inout := 20 ;
      real_inout := 25.5 ;
      bool_inout := false ;
      bit_inout := '0' ;
      chr_inout := 'Y' ;
      lev_inout := NOTE ;
      time_inout := 2 ps;
      phys_inout := phys1_3 ;
      acc_inout := null ;
      int_out := 20 ;
      real_out := 25.5 ;
      bool_out := true ;
      bit_out := '1' ;
      chr_out := 'Y' ;
      lev_out := NOTE ;
      time_out := 2 ps;
      phys_out := phys1_3 ;
      acc_out := null ;
   end proc1 ;
begin
   P :
   process
      variable int_inout   : integer := integer'right ;
      variable real_inout  : real := real'right ;
      variable bool_inout  : boolean := boolean'right ;
      variable bit_inout   : bit := bit'right ;
      variable chr_inout   : character := character'right ;
      variable lev_inout   : severity_level := severity_level'right ;
      variable time_inout  : time := time'right ;
      variable phys_inout  : t_phys1 := t_phys1'right ;
      variable acc_inout   : a_bit_vector := null ;
      variable int_out   : integer := integer'right ;
      variable real_out  : real := real'right ;
      variable bool_out  : boolean := boolean'right ;
      variable bit_out   : bit := bit'right ;
      variable chr_out   : character := character'right ;
      variable lev_out   : severity_level := severity_level'right ;
      variable time_out  : time := time'right ;
      variable phys_out  : t_phys1 := t_phys1'right ;
      variable acc_out   : a_bit_vector := null ;
   begin
      proc1( int_in => 5,
             real_in => 3.14159,
             bool_in => true,
             bit_in => '0',
             chr_in => 'Z',
             lev_in => WARNING,
             time_in => 10ms,
             phys_in => phys1_2,
	     int_inout => int_inout,
             real_inout => real_inout,
             bool_inout => bool_inout,
             bit_inout => bit_inout,
             chr_inout => chr_inout,
             lev_inout => lev_inout,
             time_inout => time_inout,
             phys_inout => phys_inout,
             acc_inout => acc_inout,
	     int_out => int_out,
             real_out => real_out,
             bool_out => bool_out,
             bit_out => bit_out,
             chr_out => chr_out,
             lev_out => lev_out,
             time_out => time_out,
             phys_out => phys_out,
             acc_out => acc_out
           ) ;
      -- this tests 2.1.1.1 (3)
      test_report ( "ARCH00267" ,
		    "Parameters are initialized " ,
		    (int_inout = 20) and
                    (real_inout = 25.5) and
                    (bool_inout = false) and
                    (bit_inout = '0') and
                    (chr_inout = 'Y') and
                    (lev_inout = NOTE) and
                    (time_inout = 2 ps) and
                    (phys_inout = phys1_3) and
                    (acc_inout = null) and
		    (int_out = 20) and
                    (real_out = 25.5) and
                    (bool_out = true) and
                    (bit_out = '1') and
                    (chr_out = 'Y') and
                    (lev_out = NOTE) and
                    (time_out = 2 ps) and
                    (phys_out = phys1_3) and
                    (acc_out = null)
                  ) ;
      wait ;
   end process P ;
end ARCH00267 ;

entity ENT00267_Test_Bench is
end ENT00267_Test_Bench ;

architecture ARCH00267_Test_Bench of ENT00267_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00267 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00267_Test_Bench ;

