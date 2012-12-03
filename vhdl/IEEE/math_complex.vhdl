--------------------------------------------------------------- 
--
-- This source file may be used and distributed without restriction.
-- No declarations or definitions shall be included in this package.
-- This package cannot be sold or distributed for profit. 
--
--   ****************************************************************
--   *                                                              *
--   *                      W A R N I N G		 	    *
--   *								    *
--   *   This DRAFT version IS NOT endorsed or approved by IEEE     *
--   *								    *
--   ****************************************************************
--
-- Title:    PACKAGE MATH_COMPLEX
--
-- Purpose:  VHDL declarations for mathematical package MATH_COMPLEX
--	     which contains common complex constants and basic complex
--	     functions and operations.
--
-- Author:   IEEE VHDL Math Package Study Group 
--
-- Notes:     
--	The package body uses package IEEE.MATH_REAL
--
-- 	The package body shall be considered the formal definition of 
-- 	the semantics of this package. Tool developers may choose to implement 
-- 	the package body in the most efficient manner available to them.
--
-- History:
-- 	Version	0.1  (Strawman) Jose A. Torres	6/22/92
-- 	Version	0.2		Jose A. Torres	1/15/93
-- 	Version	0.3		Jose A. Torres	4/13/93
-- 	Version	0.4		Jose A. Torres 	4/19/93
-- 	Version	0.5		Jose A. Torres 	4/20/93
--	Version 0.6		Jose A. Torres  4/23/93  Added unary minus
--							 and CONJ for polar
--	Version 0.7		Jose A. Torres	5/28/93 Rev up for compatibility
--							with package body.
-------------------------------------------------------------
Library IEEE;

Package MATH_COMPLEX is


    type COMPLEX        is record RE, IM: real; end record;
    type COMPLEX_VECTOR is array (integer range <>) of COMPLEX;
    type COMPLEX_POLAR  is record MAG: real; ARG: real; end record;

    constant  CBASE_1: complex := COMPLEX'(1.0, 0.0);
    constant  CBASE_j: complex := COMPLEX'(0.0, 1.0);
    constant  CZERO: complex := COMPLEX'(0.0, 0.0);

    function CABS(Z: in complex ) return real;
    	-- returns absolute value (magnitude) of Z

    function CARG(Z: in complex ) return real;
    	-- returns argument (angle) in radians of a complex number

    function CMPLX(X: in real;  Y: in real:= 0.0 ) return complex;
    	-- returns complex number X + iY

    function "-" (Z: in complex ) return complex;
    	-- unary minus

    function "-" (Z: in complex_polar ) return complex_polar;
    	-- unary minus

    function CONJ (Z: in complex) return complex;
    	-- returns complex conjugate

    function CONJ (Z: in complex_polar) return complex_polar;
    	-- returns complex conjugate

    function CSQRT(Z: in complex ) return complex_vector;
    	-- returns square root of Z; 2 values

    function CEXP(Z: in complex ) return complex;
    	-- returns e**Z

    function COMPLEX_TO_POLAR(Z: in complex ) return complex_polar;
    	-- converts complex to complex_polar

    function POLAR_TO_COMPLEX(Z: in complex_polar ) return complex;
    	-- converts complex_polar to complex

    		
    -- arithmetic operators

    function "+" ( L: in complex;  R: in complex ) return complex;
    function "+" ( L: in complex_polar; R: in complex_polar) return complex;
    function "+" ( L: in complex_polar; R: in complex ) return complex;
    function "+" ( L: in complex;  R: in complex_polar) return complex;
    function "+" ( L: in real;     R: in complex ) return complex;
    function "+" ( L: in complex;  R: in real )    return complex;
    function "+" ( L: in real;  R: in complex_polar) return complex;
    function "+" ( L: in complex_polar;  R: in real) return complex;

    function "-" ( L: in complex;  R: in complex ) return complex;
    function "-" ( L: in complex_polar; R: in complex_polar) return complex;
    function "-" ( L: in complex_polar; R: in complex ) return complex;
    function "-" ( L: in complex;  R: in complex_polar) return complex;
    function "-" ( L: in real;     R: in complex ) return complex;
    function "-" ( L: in complex;  R: in real )    return complex;
    function "-" ( L: in real;  R: in complex_polar) return complex;
    function "-" ( L: in complex_polar;  R: in real) return complex;

    function "*" ( L: in complex;  R: in complex ) return complex;
    function "*" ( L: in complex_polar; R: in complex_polar) return complex;
    function "*" ( L: in complex_polar; R: in complex ) return complex;
    function "*" ( L: in complex;  R: in complex_polar) return complex;
    function "*" ( L: in real;     R: in complex ) return complex;
    function "*" ( L: in complex;  R: in real )    return complex;
    function "*" ( L: in real;  R: in complex_polar) return complex;
    function "*" ( L: in complex_polar;  R: in real) return complex;


    function "/" ( L: in complex;  R: in complex ) return complex;
    function "/" ( L: in complex_polar; R: in complex_polar) return complex;
    function "/" ( L: in complex_polar; R: in complex ) return complex;
    function "/" ( L: in complex;  R: in complex_polar) return complex;
    function "/" ( L: in real;     R: in complex ) return complex;
    function "/" ( L: in complex;  R: in real )    return complex;
    function "/" ( L: in real;  R: in complex_polar) return complex;
    function "/" ( L: in complex_polar;  R: in real) return complex;
end  MATH_COMPLEX;

--------------------------------------------------------------- 
--
-- This source file may be used and distributed without restriction.
-- No declarations or definitions shall be included in this package.
-- This package cannot be sold or distributed for profit. 
--
--   ****************************************************************
--   *                                                              *
--   *                      W A R N I N G		 	    *
--   *								    *
--   *   This DRAFT version IS NOT endorsed or approved by IEEE     *
--   *								    *
--   ****************************************************************
--
-- Title:    PACKAGE BODY MATH_COMPLEX
--
-- Purpose:  VHDL declarations for mathematical package MATH_COMPLEX
--	     which contains common complex constants and basic complex
--	     functions and operations.
--
-- Author:   IEEE VHDL Math Package Study Group 
--
-- Notes:     
--	The package body uses package IEEE.MATH_REAL
--
-- 	The package body shall be considered the formal definition of 
-- 	the semantics of this package. Tool developers may choose to implement 
-- 	the package body in the most efficient manner available to them.
--
--   Source code for this package body comes from the following
--	following sources: 
--		IEEE VHDL Math Package Study Group participants,
--		U. of Mississippi, Mentor Graphics, Synopsys,
--		Viewlogic/Vantage, Communications of the ACM (June 1988, Vol
--		31, Number 6, pp. 747, Pierre L'Ecuyer, Efficient and Portable
--		Random Number Generators, Handbook of Mathematical Functions
--	        by Milton Abramowitz and Irene A. Stegun (Dover).
--
-- History:
-- 	Version	0.1	Jose A. Torres	4/23/93	First draft
-- 	Version	0.2	Jose A. Torres	5/28/93	Fixed potentially illegal code
--
-------------------------------------------------------------
Library IEEE;

Use IEEE.MATH_REAL.all;		-- real trascendental operations

Package body MATH_COMPLEX is

    function CABS(Z: in complex ) return real is
    	-- returns absolute value (magnitude) of Z
	variable ztemp : complex_polar;
    begin
		ztemp := COMPLEX_TO_POLAR(Z);
		return ztemp.mag;
    end CABS;

    function CARG(Z: in complex ) return real is
    	-- returns argument (angle) in radians of a complex number
     variable ztemp : complex_polar;
    begin
    		ztemp := COMPLEX_TO_POLAR(Z);
		return ztemp.arg;
    end CARG;

    function CMPLX(X: in real;  Y: in real := 0.0 ) return complex is
    	-- returns complex number X + iY
    begin
		return COMPLEX'(X, Y);
    end CMPLX;

    function "-" (Z: in complex ) return complex is
    	-- unary minus; returns -x -jy for z= x + jy
    begin
    		return COMPLEX'(-z.Re, -z.Im);
    end "-";

    function "-" (Z: in complex_polar ) return complex_polar is
    	-- unary minus; returns (z.mag, z.arg + MATH_PI)
    begin
    		return COMPLEX_POLAR'(z.mag, z.arg + MATH_PI);
    end "-";

    function CONJ (Z: in complex) return complex is
    	-- returns complex conjugate (x-jy for z = x+ jy)
    begin
    		return COMPLEX'(z.Re, -z.Im);
    end CONJ;

    function CONJ (Z: in complex_polar) return complex_polar is
    	-- returns complex conjugate (z.mag, -z.arg)
    begin
    		return COMPLEX_POLAR'(z.mag, -z.arg);
    end CONJ;

    function CSQRT(Z: in complex ) return complex_vector is
    	-- returns square root of Z; 2 values
		variable ztemp : complex_polar;
		variable zout : complex_vector (0 to 1);
		variable temp : real;
    begin
		ztemp := COMPLEX_TO_POLAR(Z);
		temp := SQRT(ztemp.mag);
		zout(0).re := temp*COS(ztemp.arg/2.0);
		zout(0).im := temp*SIN(ztemp.arg/2.0); 
    		
		zout(1).re := temp*COS(ztemp.arg/2.0 + MATH_PI);
		zout(1).im := temp*SIN(ztemp.arg/2.0 + MATH_PI);
		
		return zout;
    end CSQRT;

    function CEXP(Z: in complex ) return complex is
    	-- returns e**Z
    begin
		return COMPLEX'(EXP(Z.re)*COS(Z.im), EXP(Z.re)*SIN(Z.im));
    end CEXP;

    function COMPLEX_TO_POLAR(Z: in complex ) return complex_polar is
    	-- converts complex to complex_polar
    begin
    		return COMPLEX_POLAR'(sqrt(z.re**2 + z.im**2),atan2(z.re,z.im));
    end COMPLEX_TO_POLAR;

    function POLAR_TO_COMPLEX(Z: in complex_polar ) return complex is
    	-- converts complex_polar to complex
    begin
    		return COMPLEX'( z.mag*cos(z.arg), z.mag*sin(z.arg) ); 
    end POLAR_TO_COMPLEX;

    		
    --
    -- arithmetic operators
    --

    function "+" ( L: in complex;  R: in complex ) return complex is
    begin
    		return COMPLEX'(L.Re + R.Re, L.Im + R.Im);
    end "+";

    function "+" (L: in complex_polar; R: in complex_polar) return complex is
		variable zL, zR : complex;
    begin
		zL := POLAR_TO_COMPLEX( L );
		zR := POLAR_TO_COMPLEX( R );
		return COMPLEX'(zL.Re + zR.Re, zL.Im + zR.Im);
    end "+";

    function "+" ( L: in complex_polar; R: in complex ) return complex is
    		variable zL : complex;
    begin
    		zL := POLAR_TO_COMPLEX( L );
		return COMPLEX'(zL.Re + R.Re, zL.Im + R.Im);
    end "+";

    function "+" ( L: in complex;  R: in complex_polar) return complex is
    		variable zR : complex;
    begin
    		zR := POLAR_TO_COMPLEX( R );
		return COMPLEX'(L.Re + zR.Re, L.Im + zR.Im);
    end "+";

    function "+" ( L: in real;     R: in complex ) return complex is
    begin
    		return COMPLEX'(L + R.Re, R.Im);
    end "+";

    function "+" ( L: in complex;  R: in real )    return complex is
    begin
    		return COMPLEX'(L.Re + R, L.Im);
    end "+";

    function "+" ( L: in real;  R: in complex_polar) return complex is
    		variable zR : complex;
    begin
    		zR := POLAR_TO_COMPLEX( R );
		return COMPLEX'(L + zR.Re, zR.Im);
    end "+";

    function "+" ( L: in complex_polar;  R: in real) return complex is
    		variable zL : complex;
    begin
    		zL := POLAR_TO_COMPLEX( L );
		return COMPLEX'(zL.Re + R, zL.Im);
    end "+";

    function "-" ( L: in complex;  R: in complex ) return complex is
    begin
    		return COMPLEX'(L.Re - R.Re, L.Im - R.Im);
    end "-";

    function "-" ( L: in complex_polar; R: in complex_polar) return complex is
    		variable zL, zR : complex;
    begin
    		zL := POLAR_TO_COMPLEX( L );
		zR := POLAR_TO_COMPLEX( R );
		return COMPLEX'(zL.Re - zR.Re, zL.Im - zR.Im);
    end "-";

    function "-" ( L: in complex_polar; R: in complex ) return complex is
    		variable zL : complex;
    begin
    		zL := POLAR_TO_COMPLEX( L );
		return COMPLEX'(zL.Re - R.Re, zL.Im - R.Im);
    end "-";

    function "-" ( L: in complex;  R: in complex_polar) return complex is
    		variable zR : complex;
    begin
    		zR := POLAR_TO_COMPLEX( R );
		return COMPLEX'(L.Re - zR.Re, L.Im - zR.Im);
    end "-";

    function "-" ( L: in real;     R: in complex ) return complex is
    begin
    		return COMPLEX'(L - R.Re, -1.0 * R.Im);
    end "-";

    function "-" ( L: in complex;  R: in real )    return complex is
    begin
    		return COMPLEX'(L.Re - R, L.Im);
    end "-";

    function "-" ( L: in real;  R: in complex_polar) return complex is
    		variable zR : complex;
    begin
    		zR := POLAR_TO_COMPLEX( R );
		return COMPLEX'(L - zR.Re, -1.0*zR.Im);
    end "-";

    function "-" ( L: in complex_polar;  R: in real) return complex is
    		variable zL : complex;
    begin
    		zL := POLAR_TO_COMPLEX( L );
		return COMPLEX'(zL.Re - R, zL.Im);
    end "-";

    function "*" ( L: in complex;  R: in complex ) return complex is
    begin
        return COMPLEX'(L.Re * R.Re - L.Im * R.Im, L.Re * R.Im + L.Im * R.Re);
    end "*";

    function "*" ( L: in complex_polar; R: in complex_polar) return complex is
		variable zout : complex_polar;
    begin
		zout.mag := L.mag * R.mag;
		zout.arg := L.arg + R.arg;
		return POLAR_TO_COMPLEX(zout);
    end "*";

    function "*" ( L: in complex_polar; R: in complex ) return complex is
		variable zL : complex;
    begin
	zL := POLAR_TO_COMPLEX( L );
	return COMPLEX'(zL.Re*R.Re - zL.Im * R.Im, zL.Re * R.Im + zL.Im*R.Re);
    end "*";

    function "*" ( L: in complex;  R: in complex_polar) return complex is
    		variable zR : complex;
    begin
    	zR := POLAR_TO_COMPLEX( R );
	return COMPLEX'(L.Re*zR.Re - L.Im * zR.Im, L.Re * zR.Im + L.Im*zR.Re);
    end "*";

    function "*" ( L: in real;     R: in complex ) return complex is
    begin
    		return COMPLEX'(L * R.Re, L * R.Im);
    end "*";

    function "*" ( L: in complex;  R: in real )    return complex is
    begin
    		return COMPLEX'(L.Re * R, L.Im * R);
    end "*";

    function "*" ( L: in real;  R: in complex_polar) return complex is
    		variable zR : complex;
    begin
    		zR := POLAR_TO_COMPLEX( R );
    		return COMPLEX'(L * zR.Re, L * zR.Im);
    end "*";

    function "*" ( L: in complex_polar;  R: in real) return complex is
    		variable zL : complex;
    begin
    		zL := POLAR_TO_COMPLEX( L );
    		return COMPLEX'(zL.Re * R, zL.Im * R);
    end "*";

    function "/" ( L: in complex;  R: in complex ) return complex is
    		variable magrsq : REAL := R.Re ** 2 + R.Im ** 2;
   begin 
      if (magrsq = 0.0) then
         assert FALSE report "Attempt to divide by (0,0)"
         	severity ERROR;
         return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      else 
         return COMPLEX'( (L.Re * R.Re + L.Im * R.Im) / magrsq,
                    (L.Im * R.Re - L.Re * R.Im) / magrsq);
      end if;
    end "/";

    function "/" ( L: in complex_polar; R: in complex_polar) return complex is
		variable zout : complex_polar;
    begin
    	if (R.mag = 0.0) then
         	assert FALSE report "Attempt to divide by (0,0)"
         		severity ERROR;
         	return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      	else 
         	zout.mag := L.mag/R.mag;
		zout.arg := L.arg - R.arg;
		return POLAR_TO_COMPLEX(zout);
      	end if;
    end "/";

    function "/" ( L: in complex_polar; R: in complex ) return complex is
		variable zL : complex;
		variable temp : REAL := R.Re ** 2 + R.Im ** 2;
    begin
    	if (temp = 0.0) then
         	assert FALSE report "Attempt to divide by (0.0,0.0)"
         		severity ERROR;
         	return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      	else 
         	zL := POLAR_TO_COMPLEX( L );
         	return COMPLEX'( (zL.Re * R.Re + zL.Im * R.Im) / temp,
                    (zL.Im * R.Re - zL.Re * R.Im) / temp);
      	end if; 
    end "/";

    function "/" ( L: in complex;  R: in complex_polar) return complex is
    		variable zR : complex := POLAR_TO_COMPLEX( R );
		variable temp : REAL := zR.Re ** 2 + zR.Im ** 2;
    begin
    	if (R.mag = 0.0) or (temp = 0.0) then
         	assert FALSE report "Attempt to divide by (0.0,0.0)"
         		severity ERROR;
         	return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      	else 
         	return COMPLEX'( (L.Re * zR.Re + L.Im * zR.Im) / temp,
                    (L.Im * zR.Re - L.Re * zR.Im) / temp);
      	end if; 
    end "/";

    function "/" ( L: in real;     R: in complex ) return complex is
    		variable temp : REAL := R.Re ** 2 + R.Im ** 2;
    begin 
      	if (temp = 0.0) then
         	assert FALSE report "Attempt to divide by (0.0,0.0)"
         		severity ERROR;
         	return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      	else 
         	temp := L / temp;
         	return  COMPLEX'( temp * R.Re, -temp * R.Im );
      	end if; 
    end "/";

    function "/" ( L: in complex;  R: in real )    return complex is
    begin
    	if (R = 0.0) then
         	assert FALSE report "Attempt to divide by (0.0,0.0)"
         		severity ERROR;
         	return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      	else 
         	return COMPLEX'(L.Re / R, L.Im / R);
      	end if; 
    end "/";

    function "/" ( L: in real;  R: in complex_polar) return complex is
    		variable zR : complex := POLAR_TO_COMPLEX( R );
		variable temp : REAL := zR.Re ** 2 + zR.Im ** 2;
    begin
    	if (R.mag = 0.0) or (temp = 0.0) then
         	assert FALSE report "Attempt to divide by (0.0,0.0)"
         		severity ERROR;
         	return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      	else 
         	temp := L / temp;
         	return  COMPLEX'( temp * zR.Re, -temp * zR.Im );
      	end if; 
    end "/";

    function "/" ( L: in complex_polar;  R: in real) return complex is
    		variable zL : complex := POLAR_TO_COMPLEX( L );
    begin
    	if (R = 0.0) then
         	assert FALSE report "Attempt to divide by (0.0,0.0)"
         		severity ERROR;
         	return COMPLEX'(REAL'RIGHT, REAL'RIGHT);
      	else 
         	return COMPLEX'(zL.Re / R, zL.Im / R);
      	end if; 
    end "/";
end  MATH_COMPLEX;
