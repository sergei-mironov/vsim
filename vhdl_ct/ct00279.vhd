-- NEED RESULT: ARCH00279: Subprogram overloading passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00279
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.3 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00279)
--    ENT00279_Test_Bench(ARCH00279_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00279 of E00000 is
   function subprogram_00279 ( x,y : integer )    -- 2 integer parms
                               return integer is  -- return integer
   begin
      return 11 ;
   end subprogram_00279 ;
   function subprogram_00279 ( x,y,z : integer )  -- 3 integer parms
                               return integer is  -- return integer
   begin
      return 12 ;
   end subprogram_00279 ;
   function subprogram_00279 ( x,y,z,w : integer )  -- 4 integer parms
                                 return integer is  -- return integer
   begin
      return 13 ;
   end subprogram_00279 ;
   function subprogram_00279 ( x,y : real )       -- 2 real parms
                               return integer is  -- return integer
   begin
      return 21 ;
   end subprogram_00279 ;
   function subprogram_00279 ( x : integer; y : real )  -- integer/real parm
                               return integer is        -- return integer
   begin
      return 22 ;
   end subprogram_00279 ;
   function subprogram_00279 ( x : real; y : integer )  -- real/integer parm
                               return integer is        -- return integer
   begin
      return 23 ;
   end subprogram_00279 ;
   function subprogram_00279 ( x,y : integer )    -- 2 integer parms
                             return character is  -- return character
   begin
      return '*' ;
   end subprogram_00279 ;
   procedure subprogram_00279 ( x,y : integer ;      -- 2 integer parms
                                r : out integer) is  -- return integer
   begin
      r := 51 ;
   end subprogram_00279 ;
   procedure subprogram_00279 ( x,y,z : integer ;    -- 3 integer parms
                                r : out integer) is  -- return integer
   begin
      r := 52 ;
   end subprogram_00279 ;
   procedure subprogram_00279 ( x,y,z,w : integer ;  -- 4 integer parms
                                r : out integer) is  -- return integer
   begin
      r := 53 ;
   end subprogram_00279 ;
   procedure subprogram_00279 ( x,y : real ;         -- 2 real parms
                                r : out integer) is  -- return integer
   begin
      r := 61 ;
   end subprogram_00279 ;
   procedure subprogram_00279 ( x : integer; y : real ;  -- integer/real parm
                                r : out integer) is      -- return integer
   begin
      r := 62 ;
   end subprogram_00279 ;
   procedure subprogram_00279 ( x : real; y : integer ;  -- real/integer parm
                                r : out integer) is      -- return integer
   begin
      r := 63 ;
   end subprogram_00279 ;
   procedure subprogram_00279 ( x,y : integer ;          -- 2 integer parms
                                r : out character) is    -- return character
   begin
      r := '&' ;
   end subprogram_00279 ;
   function subprogram_00279 ( s : string )       -- resolution function
                             return character is  -- return character
   begin
      return '@' ;
   end subprogram_00279 ;
   function subprogram_00279 ( b : bit_vector )   -- resolution function
                             return bit is        -- return bit
   begin
      return '1' ;
   end subprogram_00279 ;
begin
   P :
   process
      variable i,j,k,l : integer := 0 ;
      variable u,v : real := 0.0 ;
      variable s : string (1 to 3) := "xxx" ;
      variable b : bit_vector (1 to 3) ;
      variable result_1,result_2,result_3,
               result_5,result_6,result_7           : integer := 0 ;
      variable result_8 : character := 'x' ;
   begin
      b(1) := '0' ;  b(2) := '1' ;  b(3) := '0' ;
      subprogram_00279(i,j,result_1) ;
      subprogram_00279(i,j,k,result_2) ;
      subprogram_00279(x=>i,y=>j,z=>k,w=>l,r=>result_3) ;
      subprogram_00279(u,v,result_5) ;
      subprogram_00279(i,v,result_6) ;
      subprogram_00279(u,j,result_7) ;
      subprogram_00279(i,j,result_8) ;
      test_report ( "ARCH00279" ,
		    "Subprogram overloading" ,
		    (subprogram_00279(i,j) = 11) and
		    (subprogram_00279(i,j,k) = 12) and
		    (subprogram_00279(x=>i,y=>j,z=>k,w=>l) = 13) and
		    (subprogram_00279(u,v) = 21) and
		    (subprogram_00279(i,v) = 22) and
		    (subprogram_00279(u,j) = 23) and
		    (subprogram_00279(i,j) = '*') and
                    (result_1 = 51) and
                    (result_2 = 52) and
                    (result_3 = 53) and
                    (result_5 = 61) and
                    (result_6 = 62) and
                    (result_7 = 63) and
                    (result_8 = '&') and
		    (subprogram_00279(s) = '@') and
		    (subprogram_00279(b) = '1')
                  ) ;
      wait ;
   end process P ;
end ARCH00279 ;

entity ENT00279_Test_Bench is
end ENT00279_Test_Bench ;

architecture ARCH00279_Test_Bench of ENT00279_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00279 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00279_Test_Bench ;

