-- NEED RESULT: ARCH00577: Can declare entities with same name as entities declared in a use'd pkg passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00577
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.4 (1)
--    10.4 (4)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00574_577
--    PKG00574_577/BODY
--    ENT00577_Test_Bench(ARCH00577_Test_Bench)
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--

package PKG00574_577 is
    type T1 is  (one, two, three, four) ;
    type T2 is  (one, two, three, four) ;
    type T3 is  (one, two, three, four) ;
    type T4 is  (one, two, three, four) ;
    subtype S1 is INTEGER;
    subtype S2 is INTEGER;
    subtype S3 is INTEGER;
    subtype S4 is INTEGER;
    function F1 return REAL ;
    function F2 return REAL ;
    function F3 return REAL ;
    function F4 return REAL ;
end PKG00574_577 ;

package body PKG00574_577 is
    function F1 return REAL is  begin
        return 0.0; end;

    function F2 return REAL is  begin
        return 0.0; end;

    function F3 return REAL is  begin
        return 0.0; end;

    function F4 return REAL is  begin
        return 0.0; end;
end PKG00574_577 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00577_Test_Bench is
end ENT00577_Test_Bench ;

architecture ARCH00577_Test_Bench of ENT00577_Test_Bench is
begin
L_X_1 : block

    use WORK.PKG00574_577; use PKG00574_577.all;

    type T1 is record           -- should be able to define new type T1
            TE : BOOLEAN;
    end record;

    subtype T2 is REAL range 0.0 to 256.0;      -- ditto for subtype called T2

    attribute T3 : PKG00574_577.T3 ;                -- ditto for attribute calle

    signal T4 : PKG00574_577.T1;                    -- ditto for object called T

    type S1 is record           -- should be able to define new type S1
            SE : BOOLEAN;
    end record;

    subtype S2 is REAL range 0.0 to 256.0;      -- ditto for subtype called S2

    attribute S3 : PKG00574_577.T3 ;                -- ditto for attribute calle

    signal S4 : PKG00574_577.T1;                     -- ditto for object called

    type F1 is record           -- should be able to define new type F1
            FE : BOOLEAN;
    end record;

    subtype F2 is REAL range 0.0 to 256.0;      -- ditto for subtype called F2

    attribute F3 : PKG00574_577.T3 ;                -- ditto for attribute calle

    signal F4 : PKG00574_577.T1;                    -- ditto for object called F

  begin
    process
      use PKG00574_577.all; -- This isn't necessary, but should be ok

      variable T1 : PKG00574_577.T1;                 -- ditto for object called
      variable F1 : PKG00574_577.T1;                 -- ditto for object called
      variable S1 : PKG00574_577.T1;                 -- ditto for object called
    begin
      test_report ( "ARCH00577" ,
		    "Can declare entities with same name as entities "&
                    "declared in a use'd pkg" ,
		    True ) ;
      wait ;
    end process;

  end block;
end ARCH00577_Test_Bench ;

