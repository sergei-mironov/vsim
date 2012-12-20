-- NEED RESULT: ARCH00574: Can declare entities with same name as entities declared in a use'd pkg passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00574
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.4 (1)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00574
--    PKG00574/BODY
--    ENT00574_Test_Bench(ARCH00574_Test_Bench)
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

package PKG00574 is
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
end PKG00574 ;

package body PKG00574 is
    function F1 return REAL is  begin
        return 0.0; end;

    function F2 return REAL is  begin
        return 0.0; end;

    function F3 return REAL is  begin
        return 0.0; end;

    function F4 return REAL is  begin
        return 0.0; end;
end PKG00574 ;

use WORK.STANDARD_TYPES.all ;
use WORK.PKG00574; use PKG00574.all;
entity ENT00574_Test_Bench is
end ENT00574_Test_Bench ;

architecture ARCH00574_Test_Bench of ENT00574_Test_Bench is begin
L_X_1 : block
    type T1 is record           -- should be able to define new type T1
            TE : BOOLEAN;
    end record;

    subtype T2 is REAL range 0.0 to 256.0;      -- ditto for subtype called T2

    attribute T3 : PKG00574.T3 ;                -- ditto for attribute called T3

    signal T4 : PKG00574.T1;                    -- ditto for object called T4

    type S1 is record           -- should be able to define new type S1
            SE : BOOLEAN;
    end record;

    subtype S2 is REAL range 0.0 to 256.0;      -- ditto for subtype called S2

    attribute S3 : PKG00574.T3 ;                -- ditto for attribute called S3

    signal S4 : PKG00574.T1;                     -- ditto for object called S4

    type F1 is record           -- should be able to define new type F1
            FE : BOOLEAN;
    end record;

    subtype F2 is REAL range 0.0 to 256.0;      -- ditto for subtype called F2

    attribute F3 : PKG00574.T3 ;                -- ditto for attribute called F3

    signal F4 : PKG00574.T1;                    -- ditto for object called F4

  begin
    process
      variable T1 : PKG00574.T1;                 -- ditto for object called T1
      variable F1 : PKG00574.T1;                 -- ditto for object called F1
      variable S1 : PKG00574.T1;                 -- ditto for object called S1
    begin
      test_report ( "ARCH00574" ,
		    "Can declare entities with same name as entities "&
                    "declared in a use'd pkg" ,
		    True ) ;
      wait ;
    end process;

  end block;
end ARCH00574_Test_Bench ;

