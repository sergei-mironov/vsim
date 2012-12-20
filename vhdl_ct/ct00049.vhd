-- NEED RESULT: ARCH00049.P1: Implicit subtype conversion occurs for universal real/integer passed
-- NEED RESULT: ARCH00049.P2: Implicit subtype conversion occurs for universal real/integer passed
-- NEED RESULT: ARCH00049.P3: Implicit subtype conversion occurs for universal real/integer passed
-- NEED RESULT: ARCH00049.P4: Implicit subtype conversion occurs for universal real/integer passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00049
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.4 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00049)
--    ENT00049_Test_Bench(ARCH00049_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00049 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
      variable v_t_int1 : t_int1 :=
          c_t_int1_1 ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
      variable v_real : real :=
          c_real_1 ;
      variable v_t_real1 : t_real1 :=
          c_t_real1_1 ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_integer_vector : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_real_vector : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector : st_real1_vector :=
          c_st_real1_vector_1 ;
--
      variable correct : boolean := true ;
   begin
      v_integer := 50 ;
      v_t_int1 := 50 ;
      v_st_int1 := 50 ;
      v_real := 50.0 ;
      v_t_real1 := 50.0 ;
      v_st_real1 := 50.0 ;
      v_st_integer_vector := (others => 50) ;
      v_st_int1_vector := (others => 50) ;
      v_st_real_vector := (others => 50.0) ;
      v_st_real1_vector := (others => 50.0) ;
--
      correct := correct and
                 v_integer = 50 ;
      correct := correct and
                 v_t_int1 = 50 ;
      correct := correct and
                 v_st_int1 = 50 ;
      correct := correct and
                 v_real = 50.0 ;
      correct := correct and
                 v_t_real1 = 50.0 ;
      correct := correct and
                 v_st_real1 = 50.0 ;
      correct := correct and
                 v_st_integer_vector = st_integer_vector'((others => 50)) ;
      correct := correct and
                 v_st_int1_vector = st_int1_vector'((others => 50)) ;
      correct := correct and
                 v_st_real_vector = st_real_vector'((others => 50.0)) ;
      correct := correct and
                 v_st_real1_vector = st_real1_vector'((others => 50.0)) ;
--
      test_report ( "ARCH00049.P1" ,
                    "Implicit subtype conversion occurs "&
                    "for universal real/integer",
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
         variable v_integer : integer :=
             c_integer_1 ;
         variable v_t_int1 : t_int1 :=
             c_t_int1_1 ;
         variable v_st_int1 : st_int1 :=
             c_st_int1_1 ;
         variable v_real : real :=
             c_real_1 ;
         variable v_t_real1 : t_real1 :=
             c_t_real1_1 ;
         variable v_st_real1 : st_real1 :=
             c_st_real1_1 ;
         variable v_st_integer_vector : st_integer_vector :=
             c_st_integer_vector_1 ;
         variable v_st_int1_vector : st_int1_vector :=
             c_st_int1_vector_1 ;
         variable v_st_real_vector : st_real_vector :=
             c_st_real_vector_1 ;
         variable v_st_real1_vector : st_real1_vector :=
             c_st_real1_vector_1 ;
--
      begin
         v_integer := 50 ;
         v_t_int1 := 50 ;
         v_st_int1 := 50 ;
         v_real := 50.0 ;
         v_t_real1 := 50.0 ;
         v_st_real1 := 50.0 ;
         v_st_integer_vector := (others => 50) ;
         v_st_int1_vector := (others => 50) ;
         v_st_real_vector := (others => 50.0) ;
         v_st_real1_vector := (others => 50.0) ;
--
         correct := correct and
                    v_integer = 50 ;
         correct := correct and
                    v_t_int1 = 50 ;
         correct := correct and
                    v_st_int1 = 50 ;
         correct := correct and
                    v_real = 50.0 ;
         correct := correct and
                    v_t_real1 = 50.0 ;
         correct := correct and
                    v_st_real1 = 50.0 ;
         correct := correct and
                    v_st_integer_vector = st_integer_vector'((others => 50)) ;
         correct := correct and
                    v_st_int1_vector = st_int1_vector'((others => 50)) ;
         correct := correct and
                    v_st_real_vector = st_real_vector'((others => 50.0)) ;
         correct := correct and
                    v_st_real1_vector = st_real1_vector'((others => 50.0)) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00049.P2" ,
                    "Implicit subtype conversion occurs "&
                    "for universal real/integer",
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
      variable v_t_int1 : t_int1 :=
          c_t_int1_1 ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
      variable v_real : real :=
          c_real_1 ;
      variable v_t_real1 : t_real1 :=
          c_t_real1_1 ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_integer_vector : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_real_vector : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector : st_real1_vector :=
          c_st_real1_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_integer := 50 ;
         v_t_int1 := 50 ;
         v_st_int1 := 50 ;
         v_real := 50.0 ;
         v_t_real1 := 50.0 ;
         v_st_real1 := 50.0 ;
         v_st_integer_vector := (others => 50) ;
         v_st_int1_vector := (others => 50) ;
         v_st_real_vector := (others => 50.0) ;
         v_st_real1_vector := (others => 50.0) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_integer = 50 ;
      correct := correct and
                 v_t_int1 = 50 ;
      correct := correct and
                 v_st_int1 = 50 ;
      correct := correct and
                 v_real = 50.0 ;
      correct := correct and
                 v_t_real1 = 50.0 ;
      correct := correct and
                 v_st_real1 = 50.0 ;
      correct := correct and
                 v_st_integer_vector = st_integer_vector'((others => 50)) ;
      correct := correct and
                 v_st_int1_vector = st_int1_vector'((others => 50)) ;
      correct := correct and
                 v_st_real_vector = st_real_vector'((others => 50.0)) ;
      correct := correct and
                 v_st_real1_vector = st_real1_vector'((others => 50.0)) ;
--
      test_report ( "ARCH00049.P3" ,
                    "Implicit subtype conversion occurs "&
                    "for universal real/integer",
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
      variable v_t_int1 : t_int1 :=
          c_t_int1_1 ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
      variable v_real : real :=
          c_real_1 ;
      variable v_t_real1 : t_real1 :=
          c_t_real1_1 ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_integer_vector : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_real_vector : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector : st_real1_vector :=
          c_st_real1_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_integer : inout integer
         ; v_t_int1 : inout t_int1
         ; v_st_int1 : inout st_int1
         ; v_real : inout real
         ; v_t_real1 : inout t_real1
         ; v_st_real1 : inout st_real1
         ; v_st_integer_vector : inout st_integer_vector
         ; v_st_int1_vector : inout st_int1_vector
         ; v_st_real_vector : inout st_real_vector
         ; v_st_real1_vector : inout st_real1_vector
                      )
      is
      begin
         v_integer := 50 ;
         v_t_int1 := 50 ;
         v_st_int1 := 50 ;
         v_real := 50.0 ;
         v_t_real1 := 50.0 ;
         v_st_real1 := 50.0 ;
         v_st_integer_vector := (others => 50) ;
         v_st_int1_vector := (others => 50) ;
         v_st_real_vector := (others => 50.0) ;
         v_st_real1_vector := (others => 50.0) ;
--
      end Proc1 ;
   begin
      Proc1 (
           v_integer
         , v_t_int1
         , v_st_int1
         , v_real
         , v_t_real1
         , v_st_real1
         , v_st_integer_vector
         , v_st_int1_vector
         , v_st_real_vector
         , v_st_real1_vector
            ) ;
      correct := correct and
                 v_integer = 50 ;
      correct := correct and
                 v_t_int1 = 50 ;
      correct := correct and
                 v_st_int1 = 50 ;
      correct := correct and
                 v_real = 50.0 ;
      correct := correct and
                 v_t_real1 = 50.0 ;
      correct := correct and
                 v_st_real1 = 50.0 ;
      correct := correct and
                 v_st_integer_vector = st_integer_vector'((others => 50)) ;
      correct := correct and
                 v_st_int1_vector = st_int1_vector'((others => 50)) ;
      correct := correct and
                 v_st_real_vector = st_real_vector'((others => 50.0)) ;
      correct := correct and
                 v_st_real1_vector = st_real1_vector'((others => 50.0)) ;
--
      test_report ( "ARCH00049.P4" ,
                    "Implicit subtype conversion occurs "&
                    "for universal real/integer",
                    correct) ;
   end process P4 ;
--
end ARCH00049 ;
--
entity ENT00049_Test_Bench is
end ENT00049_Test_Bench ;
--
architecture ARCH00049_Test_Bench of ENT00049_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00049 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00049_Test_Bench ;
