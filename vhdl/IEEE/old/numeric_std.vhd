-- ----------------------------------------------------------------------------
--   Title      : NUMERIC_STD arithmetic package for synthesis
--              : Rev. 1.7 (Nov. 23 1994)
--              :
--   Library    : This package shall be compiled into a library symbolically
--              : named IEEE.
--              :
--   Developers : IEEE DASC Synthesis Working Group, PAR 1076.3 
--              :
--   Purpose    : This package defines numeric types and arithmetic functions 
--              : for use with synthesis tools. Two numeric types are defined: 
--              :     --> UNSIGNED : represents UNSIGNED number in vector form
--              :     --> SIGNED   : represents a SIGNED number in vector form
--              : The base element type is type STD_LOGIC.
--              : The leftmost bit is treated as the most significant bit.
--              : Signed vectors are represented in two's complement form.
--              : This package contains overloaded arithmetic operators on 
--              : the SIGNED and UNSIGNED types. The package also contains
--              : useful type conversions functions.
--              :
--              : If any argument to a function is a null array, a null array is
--              : returned (exceptions, if any, are noted individually).
--              :
--   Note       : No declarations or definitions shall be included in, or
--              : excluded from, this package. The package declaration declares
--              : the functions that can be used by a user. The package body
--              : shall be considered the formal definition of the semantics of
--              : this package. Tool developers may choose to implement the 
--              : package body in the most efficient manner available to them.
--              :
-- ----------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;

Package numeric_std is
 
  --===========================================================================
  -- Numeric array type definitions
  --===========================================================================
 
  type UNSIGNED is array ( NATURAL range <> ) of STD_LOGIC;
  type SIGNED is array ( NATURAL range <> ) of STD_LOGIC;
 
  --===========================================================================
  -- Arithmetic Operators:
  --===========================================================================
 
     -- Id: A.1
  function "abs" ( X : SIGNED) return SIGNED;
     -- Result subtype: SIGNED(X'LENGTH-1 downto 0).
     -- Result: Returns the absolute value of a SIGNED vector X.
 
     -- Id: A.2
  function "-" ( ARG: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(ARG'LENGTH-1 downto 0).
     -- Result: Returns the value of the unary minus operation on a
     --         SIGNED vector ARG.
 
  --============================================================================

     -- Id: A.3
  function "+" (L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
     -- Result: Adds two UNSIGNED vectors that may be of different lengths.
 
     -- Id: A.4
  function "+" ( L,R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
     -- Result: Adds two SIGNED vectors that may be of different lengths.
 
     -- Id: A.5
  function "+" ( L: UNSIGNED; R: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED(L'LENGTH-1 downto 0).
     -- Result: Adds an UNSIGNED vector, L, with a non-negative INTEGER, R.
 
     -- Id: A.6
  function "+" ( L: NATURAL; R: UNSIGNED) return UNSIGNED;
     -- Result subtype: UNSIGNED(R'LENGTH-1 downto 0).
     -- Result: Adds a non-negative INTEGER, L, with an UNSIGNED vector, R.
 
     -- Id: A.7
  function "+" ( L: INTEGER; R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED (R'LENGTH-1 downto 0).
     -- Result: Adds an INTEGER, L (may be positive or negative), to a SIGNED
     --         vector, R.
 
     -- Id: A.8
  function "+" ( L: SIGNED; R: INTEGER) return SIGNED;
     -- Result subtype: SIGNED (L'LENGTH-1 downto 0).
     -- Result: Adds a SIGNED vector, L, to an INTEGER, R.
 
  --============================================================================
 
     -- Id: A.9
  function "-" (L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
     -- Result: Subtracts two UNSIGNED vectors that may be of different lengths.
 
     -- Id: A.10
  function "-" ( L,R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(MAX(L'LENGTH, R'LENGTH)-1 downto 0).
     -- Result: Subtracts a SIGNED vector, R, from another SIGNED vector, L,
     --         that may possibly be of different lengths.
 
     -- Id: A.11
  function "-" ( L: UNSIGNED;R: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED (L'LENGTH-1 downto 0).
     -- Result: Subtracts a non-negative INTEGER, R, from an UNSIGNED vector, L.
 
     -- Id: A.12
  function "-" ( L: NATURAL; R: UNSIGNED) return UNSIGNED;
     -- Result subtype: UNSIGNED(R'LENGTH-1 downto 0).
     -- Result: Subtracts an UNSIGNED vector, R, from a non-negative INTEGER, L.
 
     -- Id: A.13
  function "-" ( L: SIGNED; R: INTEGER) return SIGNED;
     -- Result subtype: SIGNED (L'LENGTH-1 downto 0).
     -- Result: Subtracts an INTEGER, R, from a SIGNED vector, L.
 
     -- Id: A.14
  function "-" ( L: INTEGER; R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(R'LENGTH-1 downto 0).
     -- Result: Subtracts a SIGNED vector, R, from an INTEGER, L.
 
  --============================================================================
 
     -- Id: A.15
  function "*" (L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED((L'length+R'length-1) downto 0).
     -- Result: Performs the multiplication operation on two UNSIGNED vectors
     --         that may possibly be of different lengths.
 
     -- Id: A.16
  function "*" ( L,R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED((L'length+R'length-1) downto 0)
     -- Result: Multiplies two SIGNED vectors that may possibly be of
     --         different lengths.
 
     -- Id: A.17
  function "*" ( L: UNSIGNED; R: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED((L'length+L'length-1) downto 0).
     -- Result: Multiplies an UNSIGNED vector, L, with a non-negative 
     --         INTEGER, R. R is converted to an UNSIGNED vector of 
     --         SIZE L'length before multiplication.
 
     -- Id: A.18
  function "*" ( L: NATURAL; R: UNSIGNED) return UNSIGNED;
     -- Result subtype: UNSIGNED((R'length+R'length-1) downto 0).
     -- Result: Multiplies an UNSIGNED vector, R, with a non-negative 
     --         INTEGER, L. L is converted to an UNSIGNED vector of 
     --         SIZE R'length before multiplication.
 
     -- Id: A.19
  function "*" ( L: SIGNED; R: INTEGER) return SIGNED;
     -- Result subtype: SIGNED((L'length+L'length-1) downto 0)
     -- Result: Multiplies a SIGNED vector, L, with an INTEGER, R. R is
     --         converted to a SIGNED vector of SIZE L'length before 
     --         multiplication.
 
     -- Id: A.20
  function "*" ( L: INTEGER; R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED((R'length+R'length-1) downto 0)
     -- Result: Multiplies a SIGNED vector, R, with an INTEGER, L. L is
     --         converted to a SIGNED vector of SIZE R'length before 
     --         multiplication.
 
  --============================================================================
  --
  --  NOTE: If second argument is zero for "/" operator, a severity level
  --        of ERROR is issued.
 
     -- Id: A.21
  function "/" (L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED (L'LENGTH-1 downto 0)
     -- Result: Divides an UNSIGNED vector, L, by another UNSIGNED vector, R.
 
     -- Id: A.22
  function "/" ( L,R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED (L'LENGTH-1 downto 0)
     -- Result: Divides an SIGNED vector, L, by another SIGNED vector, R.
 
     -- Id: A.23
  function "/" ( L: UNSIGNED; R: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED (L'LENGTH-1 downto 0)
     -- Result: Divides an UNSIGNED vector, L, by a non-negative INTEGER, R.
     --         If NO_OF_BITS(R) > L'LENGTH, then R is truncated to L'LENGTH.
 
     -- Id: A.24
  function "/" ( L: NATURAL; R: UNSIGNED) return UNSIGNED;
     -- Result subtype: UNSIGNED (R'LENGTH-1 downto 0)
     -- Result: Divides a non-negative INTEGER, L, by an UNSIGNED vector, R.
     --         If NO_OF_BITS(L) > R'LENGTH, then L is truncated to R'LENGTH.
 
     -- Id: A.25
  function "/" ( L: SIGNED; R: INTEGER) return SIGNED;
     -- Result subtype: SIGNED (L'LENGTH-1 downto 0)
     -- Result: Divides a SIGNED vector, L, by an INTEGER, R.
     --         If NO_OF_BITS(R) > L'LENGTH, then R is truncated to L'LENGTH.
 
     -- Id: A.26
  function "/" ( L: INTEGER; R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED (R'LENGTH-1 downto 0)
     -- Result: Divides an INTEGER, L, by a SIGNED vector, R.
     --         If NO_OF_BITS(L) > R'LENGTH, then L is truncated to R'LENGTH.
 
  --============================================================================
  --
  --  NOTE: If second argument is zero for "rem" operator, a severity level
  --        of ERROR is issued.
 
     -- Id: A.27
  function "rem" (L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L rem R" where L and R are UNSIGNED vectors.
 
     -- Id: A.28
  function "rem" ( L,R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L rem R" where L and R are SIGNED vectors.
 
     -- Id: A.29
  function "rem" ( L: UNSIGNED; R: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L rem R" where L is an UNSIGNED vector and R is a 
     --         non-negative INTEGER.
     --         If NO_OF_BITS(R) > L'LENGTH, then R is truncated to L'LENGTH.
 
     -- Id: A.30
  function "rem" ( L: NATURAL; R: UNSIGNED) return UNSIGNED;
     -- Result subtype: UNSIGNED(R'LENGTH-1 downto 0)
     -- Result: Computes "L rem R" where R is an UNSIGNED vector and L is a 
     --         non-negative INTEGER.
     --         If NO_OF_BITS(L) > R'LENGTH, then L is truncated to R'LENGTH.
 
     -- Id: A.31
  function "rem" ( L: SIGNED; R: INTEGER) return SIGNED;
     -- Result subtype: SIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L rem R" where L is SIGNED vector and R is an INTEGER.
     --         If NO_OF_BITS(R) > L'LENGTH, then R is truncated to L'LENGTH.
 
     -- Id: A.32
  function "rem" ( L: INTEGER; R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(R'LENGTH-1 downto 0)
     -- Result: Computes "L rem R" where R is SIGNED vector and L is an INTEGER.
     --         If NO_OF_BITS(L) > R'LENGTH, then L is truncated to R'LENGTH.
 
  --============================================================================
  --
  --  NOTE: If second argument is zero for "mod" operator, a severity level
  --        of ERROR is issued.
 
     -- Id: A.33
  function "mod" (L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L mod R" where L and R are UNSIGNED vectors.
 
     -- Id: A.34
  function "mod" ( L,R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L mod R" where L and R are SIGNED vectors.
 
     -- Id: A.35
  function "mod" ( L: UNSIGNED; R: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L mod R" where L is an UNSIGNED vector and R 
     --         is a non-negative INTEGER.
     --         If NO_OF_BITS(R) > L'LENGTH, then R is truncated to L'LENGTH.
 
     -- Id: A.36
  function "mod" ( L: NATURAL; R: UNSIGNED) return UNSIGNED;
     -- Result subtype: UNSIGNED(R'LENGTH-1 downto 0)
     -- Result: Computes "L mod R" where R is an UNSIGNED vector and L 
     --         is a non-negative INTEGER.
     --         If NO_OF_BITS(L) > R'LENGTH, then L is truncated to R'LENGTH.
 
     -- Id: A.37
  function "mod" ( L: SIGNED; R: INTEGER) return SIGNED;
     -- Result subtype: SIGNED(L'LENGTH-1 downto 0)
     -- Result: Computes "L mod R" where L is a SIGNED vector and
     --         R is an INTEGER.
     --         If NO_OF_BITS(R) > L'LENGTH, then R is truncated to L'LENGTH.
 
     -- Id: A.38
  function "mod" ( L: INTEGER; R: SIGNED) return SIGNED;
     -- Result subtype: SIGNED(R'LENGTH-1 downto 0)
     -- Result: Computes "L mod R" where L is an INTEGER and
     --         R is a SIGNED vector.
     --         If NO_OF_BITS(L) > R'LENGTH, then L is truncated to R'LENGTH.
 
  --============================================================================
  -- Comparison Operators
  --============================================================================
 
     -- Id: C.1
  function ">"  (L,R: UNSIGNED ) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L > R" where L and R are UNSIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.2
  function ">"  ( L,R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L > R" where L and R are SIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.3
  function ">"  ( L: NATURAL; R: UNSIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L > R" where L is a non-negative INTEGER and
     --         R is an UNSIGNED vector.
 
     -- Id: C.4
  function ">"  ( L: INTEGER; R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L > R" where L is a INTEGER and
     --         R is a SIGNED vector.
 
     -- Id: C.5
  function ">"  ( L: UNSIGNED; R: NATURAL) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L > R" where L is an UNSIGNED vector and
     --         R is a non-negative INTEGER.

     -- Id: C.6
  function ">"  ( L: SIGNED; R: INTEGER) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L > R" where L is a SIGNED vector and
     --         R is a INTEGER.
 
  --============================================================================
 
     -- Id: C.7
  function "<"  (L,R: UNSIGNED ) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L < R" where L and R are UNSIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.8
  function "<"  ( L,R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L < R" where L and R are SIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.9
  function "<"  ( L: NATURAL; R: UNSIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L < R" where L is a non-negative INTEGER and
     --         R is an UNSIGNED vector.
 
     -- Id: C.10
  function "<"  ( L: INTEGER; R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L < R" where L is an INTEGER and
     --         R is a SIGNED vector.
 
     -- Id: C.11
  function "<"  ( L: UNSIGNED; R: NATURAL) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L < R" where L is an UNSIGNED vector and
     --         R is a non-negative INTEGER.
 
     -- Id: C.12
  function "<"  ( L: SIGNED; R: INTEGER) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L < R" where L is a SIGNED vector and
     --         R is an INTEGER.
 
  --============================================================================
 
     -- Id: C.13
  function "<=" (L,R: UNSIGNED ) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L <= R" where L and R are UNSIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.14
  function "<=" ( L,R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L <= R" where L and R are SIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.15
  function "<=" ( L: NATURAL; R: UNSIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L <= R" where L is a non-negative INTEGER and
     --         R is an UNSIGNED vector.
 
     -- Id: C.16
  function "<=" ( L: INTEGER; R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L <= R" where L is an INTEGER and
     --         R is a SIGNED vector.
 
     -- Id: C.17
  function "<=" ( L: UNSIGNED; R: NATURAL) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L <= R" where L is an UNSIGNED vector and
     --         R is a non-negative INTEGER.

     -- Id: C.18
  function "<=" ( L: SIGNED; R: INTEGER) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L <= R" where L is a SIGNED vector and
     --         R is an INTEGER.
 
  --============================================================================
 
     -- Id: C.19
  function ">=" (L,R: UNSIGNED ) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L >= R" where L and R are UNSIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.20
  function ">=" ( L,R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L >= R" where L and R are SIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.21
  function ">=" ( L: NATURAL; R: UNSIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L >= R" where L is a non-negative INTEGER and
     --         R is an UNSIGNED vector.
 
     -- Id: C.22
  function ">=" ( L: INTEGER; R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L >= R" where L is an INTEGER and
     --         R is a SIGNED vector.
 
     -- Id: C.23
  function ">=" ( L: UNSIGNED; R: NATURAL) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L >= R" where L is an UNSIGNED vector and
     --         R is a non-negative INTEGER.
 
     -- Id: C.24
  function ">=" ( L: SIGNED; R: INTEGER) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L >= R" where L is a SIGNED vector and
     --         R is an INTEGER.

  --============================================================================
 
     -- Id: C.25
  function "=" (L,R: UNSIGNED ) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L = R" where L and R are UNSIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.26
  function "=" ( L,R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L = R" where L and R are SIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.27
  function "=" ( L: NATURAL; R: UNSIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L = R" where L is a non-negative INTEGER and
     --         R is an UNSIGNED vector.
 
     -- Id: C.28
  function "=" ( L: INTEGER; R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L = R" where L is an INTEGER and
     --         R is a SIGNED vector.
 
     -- Id: C.29
  function "=" ( L: UNSIGNED; R: NATURAL) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L = R" where L is an UNSIGNED vector and
     --         R is a non-negative INTEGER.
 
     -- Id: C.30
  function "=" ( L: SIGNED; R: INTEGER) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L = R" where L is a SIGNED vector and
     --         R is an INTEGER.
 
  --============================================================================
 
     -- Id: C.31
  function "/=" (L,R: UNSIGNED ) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L /= R" where L and R are UNSIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.32
  function "/=" ( L,R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L /= R" where L and R are SIGNED vectors possibly
     --         of different lengths.
 
     -- Id: C.33
  function "/=" ( L: NATURAL; R: UNSIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L /= R" where L is a non-negative INTEGER and
     --         R is an UNSIGNED vector.
 
     -- Id: C.34
  function "/=" ( L: INTEGER; R: SIGNED) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L /= R" where L is an INTEGER and
     --         R is a SIGNED vector.
 
     -- Id: C.35
  function "/=" ( L: UNSIGNED; R: NATURAL) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L /= R" where L is an UNSIGNED vector and
     --         R is a non-negative INTEGER.
 
     -- Id: C.36
  function "/=" ( L: SIGNED; R: INTEGER) return BOOLEAN;
     -- Result subtype: BOOLEAN
     -- Result: Computes "L /= R" where L is a SIGNED vector and
     --         R is an INTEGER.
 
  --============================================================================
  -- Shift and Rotate Functions
  --============================================================================
 
     -- Id: S.1
  function shift_left  (  ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a shift-left on an UNSIGNED vector COUNT times.
     --         The vacated positions are filled with Bit '0'.
     -- The COUNT leftmost bits are lost.
 
     -- Id: S.2
  function shift_right (  ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a shift-right on an UNSIGNED vector COUNT times.
     --         The vacated positions are filled with Bit '0'.
     --         The COUNT rightmost bits are lost.
 
     -- Id: S.3
  function shift_left  (  ARG: SIGNED; COUNT: NATURAL) return SIGNED;
     -- Result subtype: SIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a shift-left on a SIGNED vector COUNT times.
     --         All bits of ARG, except ARG'LEFT, are shifted left COUNT times.
     --         The vacated positions are filled with Bit '0'. 
     --         The COUNT leftmost bits, except ARG'LEFT, are lost.
 
     -- Id: S.4
  function shift_right (  ARG: SIGNED; COUNT: NATURAL) return SIGNED;
     -- Result subtype: SIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a shift-right on a SIGNED vector COUNT times.
     --         The vacated positions are filled with the leftmost bit,ARG'LEFT.
     --         The COUNT rightmost bits are lost.
 
  --============================================================================
 
  --============================================================================
 
     -- Id: S.5
  function rotate_left  (  ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a rotate_left of an UNSIGNED vector COUNT times.

     -- Id: S.6
  function rotate_right (  ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a rotate_right of an UNSIGNED vector COUNT times.
 
     -- Id: S.7
  function rotate_left  (  ARG: SIGNED; COUNT: NATURAL) return SIGNED;
     -- Result subtype: SIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a logical rotate-left of a SIGNED 
     --         vector COUNT times.
 
     -- Id: S.8
  function rotate_right (  ARG: SIGNED; COUNT: NATURAL) return SIGNED;
     -- Result subtype: SIGNED (ARG'LENGTH-1 downto 0)
     -- Result: Performs a logical rotate-right of a SIGNED 
     --         vector COUNT times.
 
  --============================================================================
  --  RESIZE Functions
  --============================================================================

     -- Id: R.1
  function RESIZE ( ARG: SIGNED; NEW_SIZE: NATURAL) return SIGNED;
     -- Result subtype: SIGNED(ARG'LENGTH-1 downto 0)
     -- Result: ReSIZEs the SIGNED vector ARG to the specified SIZE. 
     --         To create a larger vector, the new [leftmost] bit positions
     --         are filled with the sign bit (ARG'LEFT). When truncating,
     --         the sign bit is retained along with the rightmost part.
 
     -- Id: R.2
  function RESIZE ( ARG: UNSIGNED; NEW_SIZE: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED(ARG'LENGTH-1 downto 0)
     -- Result: ReSIZEs the SIGNED vector ARG to the specified SIZE. 
     --         To create a larger vector, the new [leftmost] bit positions
     --         are filled with '0'. When truncating, the leftmost bits 
     --         are dropped.

 
  --============================================================================
  -- Conversion Functions
  --============================================================================
 
     -- Id: D.1
  function TO_INTEGER ( ARG: UNSIGNED) return NATURAL;
     -- Result subtype: NATURAL. Value cannot be negative since parameter is an
     --                 UNSIGNED vector.
     -- Result: Converts the UNSIGNED vector to an INTEGER.
 
     -- Id: D.2
  function TO_INTEGER ( ARG: SIGNED) return INTEGER;
     -- Result subtype: INTEGER
     -- Result: Converts a SIGNED vector to an INTEGER.
 
     -- Id: D.3
  function TO_UNSIGNED (  ARG,SIZE: NATURAL) return UNSIGNED;
     -- Result subtype: UNSIGNED (SIZE-1 downto 0)
     -- Result: Converts a non-negative INTEGER to an UNSIGNED vector with
     --         the specified SIZE.
 
     -- Id: D.4
  function TO_SIGNED ( ARG: INTEGER; SIZE: NATURAL) return SIGNED;
     -- Result subtype: SIGNED (SIZE-1 downto 0)
     -- Result: Converts an INTEGER to a SIGNED vector of the specified SIZE.

     -- Id: D.5
  function TO_UNSIGNED ( ARG: STD_LOGIC_VECTOR) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input ARG
     -- Result: Converts STD_LOGIC_VECTOR to UNSIGNED.

     -- Id: D.6
  function TO_SIGNED ( ARG: STD_LOGIC_VECTOR) return SIGNED;
     -- Result subtype: SIGNED, same range as input ARG
     -- Result: Converts STD_LOGIC_VECTOR to SIGNED.

     -- Id: D.7
  function TO_STDLOGICVECTOR ( ARG: UNSIGNED) return STD_LOGIC_VECTOR;
     -- Result subtype: STD_LOGIC_VECTOR, same range as input ARG
     -- Result: Converts UNSIGNED to STD_LOGIC_VECTOR.

     -- Id: D.8
  function TO_STDLOGICVECTOR ( ARG: SIGNED) return STD_LOGIC_VECTOR;
     -- Result subtype: STD_LOGIC_VECTOR, same range as input ARG
     -- Result: Converts SIGNED to STD_LOGIC_VECTOR.

  --============================================================================
  -- Logical Operators
  --============================================================================
 
     -- Id: L.1
  function "not" ( L: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input L
     -- Result: Termwise inversion
 
     -- Id: L.2
  function "and" ( L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input L
     -- Result: Vector AND operation
     
     -- Id: L.3
  function "or" ( L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input L
     -- Result: Vector OR operation
     
     -- Id: L.4
  function "nand" ( L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input L
     -- Result: Vector NAND operation
     
     -- Id: L.5
  function "nor" ( L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input L
     -- Result: Vector NOR operation
     
     -- Id: L.6
  function "xor" ( L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input L
     -- Result: Vector XOR operation
     
--  -----------------------------------------------------------------------
--  Note : The declaration and implementation of the "xnor" function is
--  specifically commented until at which time the VHDL language has been
--  officially adopted as containing such a function. At such a point, 
--  the following comments may be removed along with this notice without
--  further "official" ballotting of this 1076.3 package. It is
--  the intent of this effort to provide such a function once it becomes
--  available in the VHDL standard.
--  -----------------------------------------------------------------------
     -- Id: L.7
--  function "xnor" ( L,R: UNSIGNED ) return UNSIGNED;
     -- Result subtype: UNSIGNED, same range as input L
     -- Result: Vector XNOR operation
 
     -- Id: L.8
  function "not" ( L: SIGNED) return SIGNED;
     -- Result subtype: SIGNED, same range as input L
     -- Result: Termwise inversion
 
     -- Id: L.9
  function "and" ( L,R: SIGNED ) return SIGNED;
     -- Result subtype: SIGNED, same range as input L
     -- Result: Vector AND operation
     
     -- Id: L.10
  function "or" ( L,R: SIGNED ) return SIGNED;
     -- Result subtype: SIGNED, same range as input L
     -- Result: Vector OR operation
     
     -- Id: L.11
  function "nand" ( L,R: SIGNED ) return SIGNED;
     -- Result subtype: SIGNED, same range as input L
     -- Result: Vector NAND operation
     
     -- Id: L.12
  function "nor" ( L,R: SIGNED ) return SIGNED;
     -- Result subtype: SIGNED, same range as input L
     -- Result: Vector NOR operation
     
     -- Id: L.13
  function "xor" ( L,R: SIGNED ) return SIGNED;
     -- Result subtype: SIGNED, same range as input L
     -- Result: Vector XOR operation
     
--  -----------------------------------------------------------------------
--  Note : The declaration and implementation of the "xnor" function is
--  specifically commented until at which time the VHDL language has been
--  officially adopted as containing such a function. At such a point, 
--  the following comments may be removed along with this notice without
--  further "official" ballotting of this 1076.3 package. It is
--  the intent of this effort to provide such a function once it becomes
--  available in the VHDL standard.
--  -----------------------------------------------------------------------
     -- Id: L.14
--  function "xnor" ( L,R: SIGNED ) return SIGNED;
     -- Result subtype: SIGNED, same range as input L
     -- Result: Vector XNOR operation
     
  --============================================================================
  -- Match Functions
  --============================================================================
 
     -- Id: M.1
  function STD_MATCH (L, R: STD_ULOGIC) return BOOLEAN;
     -- Result: terms compared per STD_LOGIC_1164 intent
     
     -- Id: M.2
  function STD_MATCH (L, R: STD_LOGIC_VECTOR) return BOOLEAN;
     -- Result: termwise comparison per STD_LOGIC_1164 intent

  end numeric_std;
 
--=============================================================================
--=======================    Package    Body    ===============================
--=============================================================================


Package body numeric_std is


   -- null range array constants
 
constant NAU : UNSIGNED (0 downto 1) := (others => '0');
constant NAS : SIGNED (0 downto 1) := (others => '0');
 
   -- implementation controls
   
constant NO_WARNING : boolean := FALSE;  -- default to emit warnings

--=========================Local Subprograms=================================

function MAX(LEFT, RIGHT: INTEGER) return INTEGER is
begin
  if LEFT > RIGHT then return LEFT;
  else return RIGHT;
    end if;
  end;

function MIN(LEFT, RIGHT: INTEGER) return INTEGER is
begin
  if LEFT < RIGHT then return LEFT;
  else return RIGHT;
    end if;
  end;

function Signed_NUM_BITS ( ARG: INTEGER) return natural is
variable nBits: natural;
variable N: natural;
begin
  if ARG>=0 then
    N:=ARG;
  else
    N:=-(ARG+1);
    end if;
  nBits:=1;
  while N>0 loop
    nBits:=nBits+1;
    N:= N / 2;
  end loop;
  return nBits;
  end;

function UNSIGNED_NUM_BITS (ARG: natural) return natural is
variable nBits: natural;
variable N: natural;
begin
  N:=ARG;
  nBits:=1;
  while N>1 loop
    nBits:=nBits+1;
    N:= N / 2;
    end loop;
  return nBits;
  end;


------------------------------------------------------------------------

 -- this internal function computes the addition of two UNSIGNED
 -- with input CARRY
 -- * the two arguments are of the same length

function ADD_UNSIGNED ( L,R: UNSIGNED; C: STD_LOGIC ) return UNSIGNED  is
constant L_left:INTEGER:= L'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
alias XR: UNSIGNED(L_left downto 0) is R;
variable RESULT: UNSIGNED(L_left downto 0);
variable CBIT : STD_LOGIC:= C;
begin
  for i in 0 to L_left loop
    RESULT(i) := CBIT xor XL(i) xor XR(i);
    CBIT := (CBIT and XL(i)) or (CBIT and XR(i)) or (XL(i) and XR(i));
    end loop;
  return RESULT;
  end ADD_UNSIGNED;

 -- this internal function computes the addition of two SIGNED
 -- with input CARRY
 -- * the two arguments are of the same length

function ADD_SIGNED ( L,R: SIGNED; C: STD_LOGIC ) return SIGNED  is
constant L_left:INTEGER:= L'length-1;
alias XL: SIGNED(L_left downto 0) is L;
alias XR: SIGNED(L_left downto 0) is R;
variable RESULT: SIGNED(L_left downto 0);
variable CBIT: STD_LOGIC:= C;
begin
  for i in 0 to L_left loop
    RESULT(i) := CBIT xor XL(i) xor XR(i);
    CBIT := (CBIT and XL(i)) or (CBIT and XR(i)) or (XL(i) and XR(i));
    end loop;
  return RESULT;
  end ADD_SIGNED;

------------------------------------------------------------------------

    -- this internal procedure computes UNSIGNED division
    -- giving the quotient and remainder.
    procedure divMod (num, XDENOM: UNSIGNED;
                      xquot, xremain: out UNSIGNED) is
       variable TEMP: UNSIGNED(num'length-1 downto 0);
       variable quot: UNSIGNED(MAX(num'length,XDENOM'length)-1 downto 0);
       variable diff: UNSIGNED(XDENOM'length downto 0);
       alias DENOM : UNSIGNED (XDENOM'length-1 downto 0) is XDENOM;
       variable CARRY: STD_LOGIC;
       variable TOPBIT: natural;
       variable isZero: boolean;
    begin
       isZero:=TRUE;
       for j in XDENOM'range loop
          CARRY:=DENOM(j);
          if CARRY/='0' then
             isZero:=FALSE;
          end if;
       end loop;
       assert not isZero   
         report "DIV,MOD,or REM by zero"   
         severity error;
       TEMP:=num;
       quot:= (others =>'0');
       TOPBIT:=0;
       for j in DENOM'range loop
          if DENOM(j)='1' then
             TOPBIT:=j;
             exit;
          end if;
       end loop;

       CARRY:='0';
       for j in num'length-(TOPBIT+1) downto 0 loop
          -- lexical ordering works okay for this comparison, no overloaded
          -- function is needed.
          if CARRY&TEMP(TOPBIT+j downto j) >= "0"&DENOM(TOPBIT downto 0) then
             diff(TOPBIT+1 downto 0) := (CARRY&TEMP(TOPBIT+j downto j))
                                       -("0"&DENOM(TOPBIT downto 0));

             assert diff(TOPBIT+1)='0'
                   report "internal error in the division algorithm"
                   severity error;
             CARRY:=diff(TOPBIT);
             if TOPBIT+j+1<=TEMP'left then
                TEMP(TOPBIT+j+1):='0';
             end if;
             TEMP(TOPBIT+j downto j):=diff(TOPBIT downto 0);
             quot(j):='1';
          else
             assert CARRY='0'
                   report "internal error in the division algorithm"
                   severity error;
             CARRY:=TEMP(TOPBIT+j);
          end if;
       end loop;
       xquot:=quot(num'length-1 downto 0);
       xremain:=TEMP(num'length-1 downto 0);
    end divMod;

-----------------Local Subprograms - shift/rotate ops-------------------------

function XSLL(ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
constant ARG_L:INTEGER:= ARG'length-1;
alias XARG: STD_LOGIC_VECTOR(ARG_L downto 0) is ARG;
variable RESULT: STD_LOGIC_VECTOR(ARG_L downto 0) := (others=>'0');
begin
  if COUNT <= ARG_L then
    RESULT(ARG_L downto COUNT):=XARG(ARG_L-COUNT downto 0);
    end if;
  return RESULT;
end;

function XSRL(ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
constant ARG_L:INTEGER:= ARG'length-1;
alias XARG: STD_LOGIC_VECTOR(ARG_L downto 0) is ARG;
variable RESULT: STD_LOGIC_VECTOR(ARG_L downto 0) := (others=>'0');
begin
  if COUNT <= ARG_L then
    RESULT(ARG_L-COUNT downto 0):=XARG(ARG_L downto COUNT);
    end if;
  return RESULT;
end;

function XSRA(ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
constant ARG_L:INTEGER:= ARG'length-1;
alias XARG: STD_LOGIC_VECTOR(ARG_L downto 0) is ARG;
variable RESULT: STD_LOGIC_VECTOR(ARG_L downto 0);
variable XCOUNT: natural := COUNT;
begin
  if ((ARG'length <= 1) or (xCOUNT = 0)) then return ARG;
  else 
    if (XCOUNT > ARG_L) then xCOUNT:= ARG_L; end if;
    RESULT(ARG_L-XCOUNT downto 0):=XARG(ARG_L downto XCOUNT);
    RESULT(ARG_L downto (ARG_L - XCOUNT + 1)) := (others=>XARG(ARG_L));
    end if;
  return RESULT;
  end;

function XROL(ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
constant ARG_L:INTEGER:= ARG'length-1;
alias XARG: STD_LOGIC_VECTOR(ARG_L downto 0) is ARG;
variable RESULT: STD_LOGIC_VECTOR(ARG_L downto 0) := XARG;
variable COUNTM: INTEGER;
begin
  COUNTM:= COUNT mod (ARG_L + 1);
  if COUNTM /= 0 then
    RESULT(ARG_L downto COUNTM):=XARG(ARG_L-COUNTM downto 0);
    RESULT(COUNTM-1 downto 0):=XARG(ARG_L downto ARG_L-COUNTM+1);
    end if;
  return RESULT;
  end;

function XROR(ARG: STD_LOGIC_VECTOR; COUNT: NATURAL) return STD_LOGIC_VECTOR is
constant ARG_L:INTEGER:= ARG'length-1;
alias XARG: STD_LOGIC_VECTOR(ARG_L downto 0) is ARG;
variable RESULT: STD_LOGIC_VECTOR(ARG_L downto 0) := XARG;
variable COUNTM: INTEGER;
begin
  COUNTM:= COUNT mod (ARG_L + 1);
  if COUNTM /= 0 then
    RESULT(ARG_L-COUNTM downto 0):=XARG(ARG_L downto COUNTM);
    RESULT(ARG_L downto ARG_L-COUNTM+1):=XARG(COUNTM-1 downto 0);
    end if;
  return RESULT;
  end;


-----------------Local Subprograms - Relational ops--------------------------

--
-- General "=" for UNSIGNED vectors, same length
--
function UNSIGNED_equal ( L,R: UNSIGNED) return BOOLEAN is
begin
  return STD_LOGIC_VECTOR (L) = STD_LOGIC_VECTOR (R) ;
  end;

--
-- General "=" for SIGNED vectors, same length
--
function SIGNED_equal ( L,R: SIGNED) return BOOLEAN is
begin
  return STD_LOGIC_VECTOR (L) = STD_LOGIC_VECTOR (R) ;
  end;



--
-- General "<" for UNSIGNED vectors, same length
--
function UNSIGNED_LESS ( L,R: UNSIGNED) return BOOLEAN is
begin
  return STD_LOGIC_VECTOR (L) < STD_LOGIC_VECTOR (R) ;
  end UNSIGNED_LESS ;

--
-- General "<" function for SIGNED vectors, same length 
--
function SIGNED_LESS ( L,R: SIGNED) return BOOLEAN is
variable intern_l : SIGNED (0 to L'LENGTH-1);
variable intern_r : SIGNED (0 to R'LENGTH-1);
begin
  intern_l:=l;
  intern_r:=r;
  intern_l(0):=not intern_l(0);
  intern_r(0):=not intern_r(0);
  return STD_LOGIC_VECTOR (intern_L) < STD_LOGIC_VECTOR (intern_R) ;
end; 

--
-- General "<=" function for UNSIGNED vectors, same length 
--
function UNSIGNED_LESS_OR_EQUAL ( L,R: UNSIGNED) return BOOLEAN is
begin
  return STD_LOGIC_VECTOR (L) <= STD_LOGIC_VECTOR (R) ;
  end;

--
-- General "<=" function for SIGNED vectors, same length 
--
function SIGNED_LESS_OR_EQUAL ( L,R: SIGNED) return BOOLEAN is
  -- Need aliasses to assure index direction
variable intern_l : SIGNED (0 to L'LENGTH-1);
variable intern_r : SIGNED (0 to R'LENGTH-1);
begin
  intern_l:=l;
  intern_r:=r;
  intern_l(0):=not intern_l(0);
  intern_r(0):=not intern_r(0);
  return STD_LOGIC_VECTOR (intern_L) <= STD_LOGIC_VECTOR (intern_R) ;
  end;

-- function TO_01 is used to convert vectors to the
--          correct form for exported functions,
--          and to report if there is an element which
--          is not in (0,1,h,l).
--    Assume the vector is normalized and non-null.
--    The function is duplicated for SIGNED and UNSIGNED types.

function TO_01(S : SIGNED ; xmap : STD_LOGIC:= '0') return SIGNED is
variable RESULT: SIGNED(S'length-1 downto 0);
variable bad_element : boolean := FALSE;
alias xs : SIGNED(s'length-1 downto 0) is S;
begin
  for i in RESULT'range loop
    case xs(i) is
      when '0' | 'L' => RESULT(i):='0';
      when '1' | 'H' => RESULT(i):='1';
      when others => bad_element := TRUE;
      end case;
    end loop;
  if bad_element then
    assert NO_WARNING
      report "numeric_std.TO_01: Array Element not in {0,1,H,L}"
      severity warning;
    for i in RESULT'range loop
      RESULT(i) := xmap;        -- standard fixup
      end loop;
    end if;
  return RESULT;
  end TO_01;
       
function TO_01(S : UNSIGNED ; xmap : STD_LOGIC:= '0') return UNSIGNED is
variable RESULT: UNSIGNED(S'length-1 downto 0);
variable bad_element : boolean := FALSE;
alias xs : UNSIGNED(S'length-1 downto 0) is S;
begin
  for i in RESULT'range loop
    case xs(i) is
      when '0' | 'L' => RESULT(i):='0';
      when '1' | 'H' => RESULT(i):='1';
      when others => bad_element := TRUE;
      end case;
    end loop;
  if bad_element then
    assert NO_WARNING
      report "numeric_std.TO_01: Array Element not in {0,1,H,L}"
      severity warning;
    for i in RESULT'range loop
      RESULT(i) := xmap;        -- standard fixup
      end loop;
    end if;
  return RESULT;
  end TO_01;
         

--=========================Exported Functions=================================

     -- Id: A.1
function "abs" ( X : SIGNED) return SIGNED is
constant ARG_LEFT:INTEGER:= X'length-1;
alias XX : SIGNED(ARG_LEFT downto 0) is X;
variable RESULT: SIGNED (ARG_LEFT downto 0);
begin
  if X'length<1 then return NAS; end if;
  RESULT:=TO_01(xx,std_logic' ('X'));
  if (RESULT(RESULT'left)='X') then return RESULT; end if;
  if RESULT(RESULT'left) = '1' then
    RESULT:= -RESULT;
    end if;
  return RESULT;
  end; -- "abs"


     -- Id: A.2
function "-" ( ARG: SIGNED) return SIGNED is
constant ARG_LEFT:INTEGER:= ARG'length-1;
alias XARG: SIGNED(ARG_LEFT downto 0) is ARG;
variable RESULT,XARG01 : SIGNED(ARG_LEFT downto 0);
variable CBIT : STD_LOGIC:= '1';
begin
  if ARG'length<1 then return NAS; end if;
  XARG01 := TO_01(ARG,std_logic' ('X'));
  if (XARG01(XARG01'left)='X') then return XARG01; end if;
  for i in 0 to RESULT'left loop
    RESULT(i) := not(XARG01(i)) xor CBIT;
    CBIT := CBIT and not(XARG01(i));
    end loop;
  return RESULT;
  end; -- "-"


--=============================================================================


     -- Id: A.3
function "+" ( L,R: UNSIGNED ) return UNSIGNED is
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(SIZE-1 downto 0);
variable R01 : UNSIGNED(SIZE-1 downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAU; end if;
  L01 := TO_01(RESIZE(L,SIZE), 'X');
  if (L01(L01'left)='X') then return L01; end if;
  R01 := TO_01(RESIZE(R,SIZE),std_logic' ('X'));
  if (R01(R01'left)='X') then return R01; end if;
  return ADD_UNSIGNED (L01, R01, std_logic' ('0')) ;
  end;

     -- Id: A.4
function "+" ( L,R: SIGNED ) return SIGNED is
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(SIZE-1 downto 0);
variable R01 : SIGNED(SIZE-1 downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAS; end if;
  L01 := TO_01(RESIZE(L,SIZE),std_logic' ('X'));
  if (L01(L01'left)='X') then return L01; end if;
  R01 := TO_01(RESIZE(R,SIZE),std_logic' ('X'));
  if (R01(R01'left)='X') then return R01; end if;
  return ADD_SIGNED (L01, R01, std_logic' ('0')) ;
  end;

     -- Id: A.5
function "+" ( L: UNSIGNED; R: NATURAL) return UNSIGNED is
begin
  return L + TO_UNSIGNED( R , L'length);
  end;

     -- Id: A.6
function "+" ( L: NATURAL; R: UNSIGNED) return UNSIGNED is
begin
  return TO_UNSIGNED( L , R'length) + R;
  end;

     -- Id: A.7
function "+" ( L: SIGNED; R: INTEGER) return SIGNED is
begin
  return L + TO_SIGNED( R , L'length);
  end;

     -- Id: A.8
function "+" ( L: INTEGER; R: SIGNED) return SIGNED is
begin
  return TO_SIGNED( L , R'length) + R;
  end;

--=============================================================================

     -- Id: A.9
function "-" ( L,R: UNSIGNED) return UNSIGNED  is
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(SIZE-1 downto 0);
variable R01 : UNSIGNED(SIZE-1 downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAU; end if;
  L01 := TO_01(RESIZE(L,SIZE),std_logic' ('X'));
  if (L01(L01'left)='X') then return L01; end if;
  R01 := TO_01(RESIZE(R,SIZE),std_logic' ('X'));
  if (R01(R01'left)='X') then return R01; end if;
  return ADD_UNSIGNED (L01,not(R01),std_logic' ('1')); 
  end;

     -- Id: A.10
function "-" ( L,R: SIGNED) return SIGNED is
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(SIZE-1 downto 0);
variable R01 : SIGNED(SIZE-1 downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAS; end if;
  L01 := TO_01(RESIZE(L,SIZE),std_logic' ('X'));
  if (L01(L01'left)='X') then return L01; end if;
  R01 := TO_01(RESIZE(R,SIZE),std_logic' ('X'));
  if (R01(R01'left)='X') then return R01; end if;
  return ADD_SIGNED (L01,not(R01),std_logic' ('1'));
  end;



     -- Id: A.11
function "-" ( L: UNSIGNED; R: NATURAL) return UNSIGNED is
begin
  return L -  TO_UNSIGNED( R , L'length);
  end;

     -- Id: A.12
function "-" ( L: NATURAL; R: UNSIGNED) return UNSIGNED is
begin
  return TO_UNSIGNED( L , R'length) - R;
  end;

     -- Id: A.13
function "-" ( L: SIGNED; R: INTEGER) return SIGNED is
begin
  return L - TO_SIGNED( R , L'length);
  end;

     -- Id: A.14
function "-" ( L: INTEGER; R: SIGNED) return SIGNED is
begin
  return  TO_SIGNED( L , R'length) - R ;
  end;


--=============================================================================

     -- Id: A.15
function "*" ( L,R: UNSIGNED) return UNSIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : UNSIGNED(L_left downto 0) is L;
alias xxr : UNSIGNED(R_left downto 0) is R;
variable xl : UNSIGNED(L_left downto 0);
variable xr : UNSIGNED(R_left downto 0);
variable RESULT: UNSIGNED((L'length+R'length-1) downto 0) :=(others=>'0');
variable adval : UNSIGNED((L'length+R'length-1) downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAU; end if;
  xl := TO_01(xxl,std_logic' ('X'));
  xr := TO_01(xxr,std_logic' ('X'));
  if ((xl(xl'left)='X') or (xr(xr'left)='X')) then
    RESULT:= (others=>'X');
    return RESULT;
    end if;
  adval := RESIZE(xr,RESULT'length);
  for i in 0 to L_left loop
    if xl(i)='1' then RESULT:= RESULT + adval;
    end if;
    adval := shift_left(adval,1);  
    end loop;
  return RESULT;
end;

     -- Id: A.16
function "*" ( L,R: SIGNED) return SIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : SIGNED(L_left downto 0) is L;
alias xxr : SIGNED(R_left downto 0) is R;
variable xl : SIGNED(L_left downto 0);
variable xr : SIGNED(R_left downto 0);
variable RESULT: SIGNED((L'length+R'length-1) downto 0) :=(others=>'0');
variable adval : SIGNED((L'length+R'length-1) downto 0);
variable invt : STD_LOGIC:= '0';
begin
  if ((L'length<1) or (R'length<1)) then return NAS; end if;
  xl := TO_01(xxl,std_logic' ('X'));
  xr := TO_01(xxr,std_logic' ('X'));
  if ((xl(xl'left)='X') or (xr(xr'left)='X')) then
    RESULT:= (others=>'X');
    return RESULT;
    end if;
  adval := RESIZE(xr,RESULT'length);
  if xl(xl'left)='1' then
    adval := -(adval);
    invt := '1';
    end if;
  for i in 0 to L_left loop
    if (invt xor xl(i))='1' then RESULT:= RESULT + adval;
    end if;
    adval := shift_left(adval,1);  
    end loop;
  return RESULT;
  end;


     -- Id: A.17
function "*" ( L: UNSIGNED; R: NATURAL) return UNSIGNED is
begin
  return L *  TO_UNSIGNED( R , L'length);
  end;

     -- Id: A.18
function "*" ( L: NATURAL; R: UNSIGNED) return UNSIGNED is
begin
  return TO_UNSIGNED( L , R'length) * R;
  end;

     -- Id: A.19
function "*" ( L: SIGNED; R: INTEGER) return SIGNED is
begin
  return L * TO_SIGNED( R , L'length);
  end;

     -- Id: A.20
function "*" ( L: INTEGER; R: SIGNED) return SIGNED is
begin
  return  TO_SIGNED( L , R'length) * R ;
  end;

--=============================================================================

     -- Id: A.21
function "/" ( L,R: UNSIGNED) return UNSIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : UNSIGNED(L_left downto 0) is L;
alias xxr : UNSIGNED(R_left downto 0) is R;
variable xl : UNSIGNED(L_left downto 0);
variable xr : UNSIGNED(R_left downto 0);
variable fquot,fremain : UNSIGNED(L'length-1 downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAU; end if;
  xl := TO_01(xxl,std_logic' ('X'));
  xr := TO_01(xxr,std_logic' ('X'));
  if ((xl(xl'left)='X') or (xr(xr'left)='X')) then
    fquot := (others=>'X');
    return fquot;
    end if;
  divMod(xl,xr,fquot,fremain);
  return fquot;
  end;

     -- Id: A.22
function "/" ( L,R: SIGNED) return SIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : SIGNED(L_left downto 0) is L;
alias xxr : SIGNED(R_left downto 0) is R;
variable xl : SIGNED(L_left downto 0);
variable xr : SIGNED(R_left downto 0);
variable fquot,fremain : UNSIGNED(L'length-1 downto 0);
variable xnum: UNSIGNED(L'length-1 downto 0);
variable XDENOM: UNSIGNED(R'length-1 downto 0);
variable qneg: boolean := FALSE;
begin
  if ((L'length<1) or (R'length<1)) then return NAS; end if;
  xl := TO_01(xxl,std_logic' ('X'));
  xr := TO_01(xxr,std_logic' ('X'));
  if ((xl(xl'left)='X') or (xr(xr'left)='X')) then
    fquot := (others=>'X');
    return SIGNED(fquot);
    end if;
  if xl(xl'left)='1' then
    xnum:=UNSIGNED(-xl);
    qNeg:=TRUE;
  else
    xnum:=UNSIGNED(xl);
    end if;
  if xr(xr'left)='1' then
    xdenom:=UNSIGNED(-xr);
    qNeg:=not qNeg;
  else
    xdenom:=UNSIGNED(xr);
    end if;
  divMod(xnum,XDENOM,fquot,fremain);
  if qNeg then fquot:="0"-fquot;  end if;
  return SIGNED(fquot);
  end;

     -- Id: A.23
function "/" ( L : UNSIGNED; R : NATURAL) return UNSIGNED is
  constant R_Length : Natural := max(L'Length, unsigned_num_bits(R));
  variable XR,Quot : unsigned (R_Length-1 downto 0);
begin
  XR := TO_UNSIGNED(R, R_Length);
  Quot := L / XR;
  if R_Length>L'Length and Quot(0)/='X'
      and Quot(R_Length-1 downto L'Length)/=(R_Length-1 downto L'Length => '0')
  then
    ASSERT no_warning report "Numeric_std.""/"": Quotient Truncated"
          severity warning;
  end if;
  return Quot(L'Length-1 downto 0);
  end;

     -- Id: A.24
function "/" ( L : NATURAL; R : UNSIGNED) return UNSIGNED is
  constant L_Length : Natural := max(unsigned_num_bits(L), R'length);
  variable XL,Quot : UNSIGNED (L_Length-1 downto 0);
begin
  XL := TO_UNSIGNED(L,L_LENGTH);
  QUOT := XL / R;
  if L_LENGTH>R'LENGTH and Quot(0)/='X'
      and QUOT(L_LENGTH-1 downto R'Length)/=(L_LENGTH-1 downto R'Length => '0')
  then
    ASSERT no_warning report "Numeric_std.""/"": Quotient Truncated"
          severity warning;
  end if;
  return Quot(R'Length-1 downto 0);
  end;

     -- Id: A.25
function "/" ( L : SIGNED; R : INTEGER ) return SIGNED is
  constant R_Length : Natural := max(L'Length, signed_num_bits(R));
  variable XR,Quot : signed (R_Length-1 downto 0);
begin
  XR := TO_SIGNED(R, R_Length);
  Quot := L / XR;
  if R_Length>L'Length and Quot(0)/='X'
        and Quot(R_Length-1 downto L'Length)
            /= (R_Length-1 downto L'Length => Quot(L'Length-1))
  then
    ASSERT no_warning report "Numeric_std.""/"": Quotient Truncated"
          severity warning;
  end if;
  return Quot(L'Length-1 downto 0);
  end;

     -- Id: A.26
function "/" ( L : INTEGER; R : SIGNED) return SIGNED is
  constant L_Length : Natural := max(signed_num_bits(L), R'length); 
  variable XL,Quot : SIGNED (L_Length-1 downto 0);
begin
  XL := TO_SIGNED(L,L_LENGTH);
  QUOT := XL / R;
  if L_LENGTH>R'LENGTH and Quot(0)/='X'
        and QUOT(L_LENGTH-1 downto R'Length)
           /= (L_LENGTH-1 downto R'Length => Quot(R'Length-1))
  then
    ASSERT no_warning report "Numeric_std.""/"": Quotient Truncated"
          severity warning;
  end if; 
  return Quot(R'Length-1 downto 0);
  end;
--=============================================================================

     -- Id: A.27
function "rem" ( L,R: UNSIGNED) return UNSIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : UNSIGNED(L_left downto 0) is L;
alias xxr : UNSIGNED(R_left downto 0) is R;
variable xl : UNSIGNED(L_left downto 0);
variable xr : UNSIGNED(R_left downto 0);
variable fquot,fremain : UNSIGNED(l'length-1 downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAU; end if;
  xl := TO_01(xxl,std_logic' ('X'));
  xr := TO_01(xxr,std_logic' ('X'));
  if ((xl(xl'left)='X') or (xr(xr'left)='X')) then
    fremain := (others=>'X');
    return fremain;
    end if;
  divMod(xl,xr,fquot,fremain);
  return fremain;
  end;

     -- Id: A.28
function "rem" ( L,R: SIGNED) return SIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : SIGNED(L_left downto 0) is L;
alias xxr : SIGNED(R_left downto 0) is R;
variable fquot,fremain : UNSIGNED(l'length-1 downto 0);
variable xnum: UNSIGNED(l'length-1 downto 0);
variable XDENOM: UNSIGNED(r'length-1 downto 0);
variable rneg: boolean := FALSE;
begin
  if ((L'length<1) or (R'length<1)) then return NAS; end if;
  xnum := UNSIGNED(TO_01(xxl,std_logic' ('X')));
  XDENOM := UNSIGNED(TO_01(xxr,std_logic' ('X')));
  if ((xnum(xnum'left)='X') or (xdenom(xnum'left)='X')) then
    fremain := (others=>'X');
    return SIGNED(fremain);
    end if;
  if xnum(xnum'left)='1' then
     xnum:=UNSIGNED(-SIGNED(xnum));
     rNeg:=TRUE;
  else
     xNum:=UNSIGNED(xnum);
  end if;
  if XDENOM(XDENOM'left)='1' then
     XDENOM:=UNSIGNED(-SIGNED(XDENOM));
  else
     XDENOM:=UNSIGNED(XDENOM);
  end if;
  divMod(xnum,XDENOM,fquot,fremain);
  if rNeg then
     fremain:="0"-fremain;
  end if;
  return SIGNED(fremain);
  end;

     -- Id: A.29
function "rem" ( L : UNSIGNED; R : NATURAL) return UNSIGNED is
  constant R_Length : Natural := max(L'Length, unsigned_num_bits(R));
  variable XR,XRem : unsigned (R_Length-1 downto 0);
begin
  XR := TO_UNSIGNED(R, R_Length);
  XRem := L rem XR;
  if R_Length>L'Length and XRem(0)/='X'
         and XRem(R_Length-1 downto L'Length)
          /= (R_Length-1 downto L'Length => '0')
  then
    ASSERT no_warning report "Numeric_std.""rem"": Remainder Truncated"
          severity warning;
  end if;
  return XRem(L'Length-1 downto 0);
end;

     -- Id: A.30
function "rem" ( L : NATURAL; R : UNSIGNED) return UNSIGNED is
  constant L_Length : Natural := max(unsigned_num_bits(L), R'Length);
  variable XL,XRem : unsigned (L_Length-1 downto 0);
begin
  XL := TO_UNSIGNED(L, L_Length);
  XRem := XL rem R;
  if L_Length>R'Length and XRem(0)/='X'
         and XRem(L_Length-1 downto R'Length)
          /= (L_Length-1 downto R'Length => '0')
  then
    ASSERT no_warning report "Numeric_std.""rem"": Remainder Truncated"
          severity warning;
  end if;
  return XRem(R'Length-1 downto 0);
end;

     -- Id: A.31
function "rem" ( L : SIGNED; R : INTEGER ) return SIGNED is
  constant R_Length : Natural := max(L'Length, signed_num_bits(R));
  variable XR,XRem : signed (R_Length-1 downto 0);
begin
  XR := TO_SIGNED(R, R_Length);
  XRem := L rem XR;
  if R_Length>L'Length and XRem(0)/='X'
         and XRem(R_Length-1 downto L'Length)
          /= (R_Length-1 downto L'Length => XRem(L'Length-1))
  then
    ASSERT no_warning report "Numeric_std.""rem"": Remainder Truncated"
          severity warning;
  end if;
  return XRem(L'Length-1 downto 0);
end;

     -- Id: A.32
function "rem" ( L : INTEGER; R : SIGNED) return SIGNED is
  constant L_Length : Natural := max(signed_num_bits(L), R'Length);
  variable XL,XRem : signed (L_Length-1 downto 0);
begin
  XL := TO_SIGNED(L, L_Length);
  XRem := XL rem R;
  if L_Length>R'Length and XRem(0)/='X'
         and XRem(L_Length-1 downto R'Length)
          /= (L_Length-1 downto R'Length => XRem(R'Length-1))
  then
    ASSERT no_warning report "Numeric_std.""rem"": Remainder Truncated"
          severity warning;
  end if;
  return XRem(R'Length-1 downto 0);
end;

--=============================================================================

     -- Id: A.33
function "mod" ( L,R: UNSIGNED) return UNSIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : UNSIGNED(L_left downto 0) is L;
alias xxr : UNSIGNED(R_left downto 0) is R;
variable xl : UNSIGNED(L_left downto 0);
variable xr : UNSIGNED(R_left downto 0);
variable fquot,fremain : UNSIGNED(l'length-1 downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return NAU; end if;
  xl := TO_01(xxl,std_logic' ('X'));
  xr := TO_01(xxr,std_logic' ('X'));
  if ((xl(xl'left)='X') or (xr(xr'left)='X')) then
    fremain := (others=>'X');
    return fremain;
    end if;
  divMod(xl,xr,fquot,fremain);
  return fremain;
  end;

     -- Id: A.34
function "mod" ( L,R: SIGNED) return SIGNED is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias xxl : SIGNED(L_left downto 0) is L;
alias xxr : SIGNED(R_left downto 0) is R;
variable xl : SIGNED(L_left downto 0);
variable xr : SIGNED(R_left downto 0);
variable fquot,fremain : UNSIGNED(l'length-1 downto 0);
variable xnum: UNSIGNED(l'length-1 downto 0);
variable XDENOM: UNSIGNED(r'length-1 downto 0);
variable rneg: boolean := FALSE;
begin
  if ((L'length<1) or (R'length<1)) then return NAS; end if;
  xl := TO_01(xxl,std_logic' ('X'));
  xr := TO_01(xxr,std_logic' ('X'));
  if ((xl(xl'left)='X') or (xr(xr'left)='X')) then
    fremain := (others=>'X');
    return SIGNED(fremain);
    end if;
  if xl(xl'left)='1' then
     xnum:=UNSIGNED(-xl);
  else
     xNum:=UNSIGNED(xl);
  end if;
  if xr(xr'left)='1' then
     XDENOM:=UNSIGNED(-xr);
     rNeg:=TRUE;
  else
     XDENOM:=UNSIGNED(xr);
  end if;
  divMod(xnum,XDENOM,fquot,fremain);
  if rNeg and l(l'left)='1' then
     fremain:="0"-fremain;
  elsif rNeg then
     fremain:=fremain-XDENOM;
  elsif l(l'left)='1' then
     fremain:=XDENOM-fremain;
  end if;
  return SIGNED(fremain);
  end;

     -- Id: A.35
function "mod" ( L : UNSIGNED; R : NATURAL) return UNSIGNED is
  constant R_Length : Natural := max(L'Length, unsigned_num_bits(R));
  variable XR,XRem : unsigned (R_Length-1 downto 0);
begin
  XR := TO_UNSIGNED(R, R_Length);
  XRem := L mod XR;
  if R_Length>L'Length and XRem(0)/='X'
        and XRem(R_Length-1 downto L'Length)
          /= (R_Length-1 downto L'Length => '0')
  then
    ASSERT no_warning report "Numeric_std.""mod"": Modulus Truncated"
          severity warning;
  end if;
  return XRem(L'Length-1 downto 0);
end;

     -- Id: A.36
function "mod" ( L : NATURAL; R : UNSIGNED) return UNSIGNED is
  constant L_Length : Natural := max(unsigned_num_bits(L), R'Length);
  variable XL,XRem : unsigned (L_Length-1 downto 0);
begin
  XL := TO_UNSIGNED(L, L_Length);
  XRem := XL mod R;
  if L_Length>R'Length and XRem(0)/='X'
        and XRem(L_Length-1 downto R'Length)
          /= (L_Length-1 downto R'Length => '0')
  then
    ASSERT no_warning report "Numeric_std.""mod"": Modulus Truncated"
          severity warning;
  end if;
  return XRem(R'Length-1 downto 0);
end;

     -- Id: A.37
function "mod" ( L : SIGNED; R : INTEGER ) return SIGNED is
  constant R_Length : Natural := max(L'Length, signed_num_bits(R));
  variable XR,XRem : signed (R_Length-1 downto 0);
begin
  XR := TO_SIGNED(R, R_Length);
  XRem := L mod XR;
  if R_Length>L'Length and XRem(0)/='X'
        and XRem(R_Length-1 downto L'Length)
          /= (R_Length-1 downto L'Length => XRem(L'Length-1))
  then
    ASSERT no_warning report "Numeric_std.""mod"": Modulus Truncated"
          severity warning;
  end if;
  return XRem(L'Length-1 downto 0);
end;

     -- Id: A.38
function "mod" ( L : INTEGER; R : SIGNED) return SIGNED is
  constant L_Length : Natural := max(signed_num_bits(L), R'Length);
  variable XL,XRem : signed (L_Length-1 downto 0);
begin
  XL := TO_SIGNED(L, L_Length);
  XRem := XL mod R;
  if L_Length>R'Length and XRem(0)/='X'
        and XRem(L_Length-1 downto R'Length)
          /= (L_Length-1 downto R'Length => XRem(R'Length-1))
  then
    ASSERT no_warning report "Numeric_std.""mod"": Modulus Truncated"
          severity warning;
  end if;
  return XRem(R'Length-1 downto 0);
end;

--=============================================================================

     -- Id: C.1
function ">"  ( L,R: UNSIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
alias XR: UNSIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(L_left downto 0);
variable R01 : UNSIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return not UNSIGNED_LESS_OR_EQUAL (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end ">" ;

     -- Id: C.2
function ">"  ( L,R: SIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: SIGNED(L_left downto 0) is L;
alias XR: SIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(L_left downto 0);
variable R01 : SIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return not SIGNED_LESS_OR_EQUAL (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end ">" ;

     -- Id: C.3
function ">"  ( L: NATURAL; R: UNSIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: UNSIGNED(R_left downto 0) is R;
variable R01 : UNSIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if; 
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(l)>R'length then return TRUE; end if;
  return not UNSIGNED_LESS_OR_EQUAL (TO_UNSIGNED (L,R01'LENGTH), R01) ;
  end ">" ;

     -- Id: C.4
function ">"  ( L: INTEGER; R: SIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: SIGNED(R_left downto 0) is R;
variable R01 : SIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if; 
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(l)>R'length then return L>0; end if;
  return not SIGNED_LESS_OR_EQUAL (TO_SIGNED(L,R01'LENGTH), R01) ;
  end ">" ;

     -- Id: C.5
function ">"  ( L: UNSIGNED; R: NATURAL) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
variable L01 : UNSIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if; 
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(R)>L'length then return FALSE; end if;
  return not UNSIGNED_LESS_OR_EQUAL (L01, TO_UNSIGNED (R,L01'LENGTH)) ;
  end ">" ;

     -- Id: C.6
function ">"  ( L: SIGNED; R: INTEGER) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: SIGNED(L_left downto 0) is L;
variable L01 : SIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if; 
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(R)>L'length then return 0>R; end if;
  return not SIGNED_LESS_OR_EQUAL (L01, TO_SIGNED(R,L01'LENGTH)) ;
  end ">" ;

--=============================================================================

     -- Id: C.7
function "<"  ( L,R: UNSIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
alias XR: UNSIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(L_left downto 0);
variable R01 : UNSIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return UNSIGNED_LESS (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end "<" ;

     -- Id: C.8
function "<"  ( L,R: SIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: SIGNED(L_left downto 0) is L;
alias XR: SIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(L_left downto 0);
variable R01 : SIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return SIGNED_LESS (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end "<" ;

     -- Id: C.9
function "<"  ( L: NATURAL; R: UNSIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: UNSIGNED(R_left downto 0) is R;
variable R01 : UNSIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(L)>R'length then return L<0; end if;
  return UNSIGNED_LESS (TO_UNSIGNED(L,R01'LENGTH), R01) ;
  end "<" ;

     -- Id: C.10
function "<"  ( L: INTEGER; R: SIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: SIGNED(R_left downto 0) is R;
variable R01 : SIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(L)>R'length then return L<0; end if;
  return SIGNED_LESS (TO_SIGNED(L,R01'LENGTH), R01) ;
  end "<" ;

     -- Id: C.11
function "<"  ( L: UNSIGNED; R: NATURAL) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
variable L01 : UNSIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(R)>L'length then return 0<R; end if;
  return UNSIGNED_LESS (L01, TO_UNSIGNED (R,L01'LENGTH)) ;
  end "<" ;

     -- Id: C.12
function "<"  ( L: SIGNED; R: INTEGER) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: SIGNED(L_left downto 0) is L;
variable L01 : SIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(R)>L'length then return 0<R; end if;
  return SIGNED_LESS (L01, TO_SIGNED (R,L01'LENGTH)) ;
  end "<" ;

--=============================================================================

     -- Id: C.13
function "<=" ( L,R: UNSIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
alias XR: UNSIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(L_left downto 0);
variable R01 : UNSIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return UNSIGNED_LESS_OR_EQUAL (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end "<=" ;

     -- Id: C.14
function "<=" ( L,R: SIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: SIGNED(L_left downto 0) is L;
alias XR: SIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(L_left downto 0);
variable R01 : SIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return SIGNED_LESS_OR_EQUAL (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end "<=" ;

     -- Id: C.15
function "<=" ( L: NATURAL; R: UNSIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: UNSIGNED(R_left downto 0) is R;
variable R01 : UNSIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(L)>R'length then return L<0; end if;
  return UNSIGNED_LESS_OR_EQUAL (TO_UNSIGNED(L,R01'LENGTH), R01) ;
  end "<=" ;

     -- Id: C.16
function "<=" ( L: INTEGER; R: SIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: SIGNED(R_left downto 0) is R;
variable R01 : SIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(L)>R'length then return L<0; end if;
  return SIGNED_LESS_OR_EQUAL (TO_SIGNED(L,R01'LENGTH), R01) ;
  end "<=" ;

     -- Id: C.17
function "<=" ( L: UNSIGNED; R: NATURAL) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
variable L01 : UNSIGNED(L_left downto 0);
begin
  if (L_left<0) then return FALSE; end if; 
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(R)>L'length then return 0<R; end if;
  return UNSIGNED_LESS_OR_EQUAL (L01, TO_UNSIGNED(R,L01'LENGTH)) ;
  end "<=" ;

     -- Id: C.18
function "<=" ( L: SIGNED; R: INTEGER) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: SIGNED(L_left downto 0) is L;
variable L01 : SIGNED(L_left downto 0);
begin
  if (L_left<0) then return FALSE; end if; 
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(R)>L'length then return 0<R; end if;
  return SIGNED_LESS_OR_EQUAL (L01, TO_SIGNED(R,L01'LENGTH)) ;
  end "<=" ;

--=============================================================================

     -- Id: C.19
function ">=" ( L,R: UNSIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
alias XR: UNSIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(L_left downto 0);
variable R01 : UNSIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return not UNSIGNED_LESS (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end ">=" ;

     -- Id: C.20
function ">=" ( L,R: SIGNED) return BOOLEAN is 
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: SIGNED(L_left downto 0) is L;
alias XR: SIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(L_left downto 0);
variable R01 : SIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return not SIGNED_LESS (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end ">=" ;

     -- Id: C.21
function ">=" ( L: NATURAL; R: UNSIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: UNSIGNED(R_left downto 0) is R;
variable R01 : UNSIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(L)>R'length then return L>0; end if;
  return not UNSIGNED_LESS (TO_UNSIGNED(L,R01'LENGTH), R01) ;
  end ">=" ;

     -- Id: C.22
function ">=" ( L: INTEGER; R: SIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: SIGNED(R_left downto 0) is R;
variable R01 : SIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(L)>R'length then return L>0; end if;
  return not SIGNED_LESS (TO_SIGNED (L,R01'LENGTH), R01) ;
  end ">=" ;

     -- Id: C.23
function ">=" ( L: UNSIGNED; R: NATURAL) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
variable L01 : UNSIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(R)>L'length then return 0>R; end if;
  return not UNSIGNED_LESS(L01, TO_UNSIGNED(R,L01'LENGTH)) ;
  end ">=" ;

     -- Id: C.24
function ">=" ( L: SIGNED; R: INTEGER) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: SIGNED(L_left downto 0) is L;
variable L01 : SIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if Signed_NUM_BITS(R)>L'length then return 0>R; end if;
  return not SIGNED_LESS (L01, TO_SIGNED(R,L01'LENGTH)) ; 
  end ">=" ;

--=============================================================================

     -- Id: C.25
function "="  ( L,R: UNSIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
alias XR: UNSIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(L_left downto 0);
variable R01 : UNSIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return UNSIGNED_equal (RESIZE(L01,SIZE),RESIZE(R01,SIZE)) ;
  end "=" ;

     -- Id: C.26
function "="  ( L,R: SIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: SIGNED(L_left downto 0) is L;
alias XR: SIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(L_left downto 0);
variable R01 : SIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  R01 := TO_01(XR,std_logic' ('X'));
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return FALSE; end if;
  return SIGNED_equal (RESIZE(L01,SIZE), RESIZE(R01,SIZE)) ;
  end "=" ;

     -- Id: C.27
function "="  ( L: NATURAL; R: UNSIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: UNSIGNED(R_left downto 0) is R;
variable R01 : UNSIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(L)>R'Length then return FALSE; end if;
  return UNSIGNED_equal ( TO_UNSIGNED(L,R01'LENGTH), R01);
  end "=" ;

     -- Id: C.28
function "="  ( L: INTEGER; R: SIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: SIGNED(R_left downto 0) is R;
variable R01 : SIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR,std_logic' ('X'));
  if (R01(R01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(L)>R'Length then return FALSE; end if;
  return SIGNED_equal ( TO_SIGNED(L,R01'LENGTH), R01) ;
  end "=" ;

     -- Id: C.29
function "="  ( L: UNSIGNED; R: NATURAL) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
variable L01 : UNSIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(R)>L'length then return FALSE; end if;
  return UNSIGNED_equal (L01, TO_UNSIGNED (R,L01'LENGTH)) ;
  end "=" ;

     -- Id: C.30
function "="  ( L: SIGNED; R: INTEGER) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: SIGNED(L_left downto 0) is L;
variable L01 : SIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL,std_logic' ('X'));
  if (L01(L01'left)='X') then return FALSE; end if;
  if UNSIGNED_NUM_BITS(R)>L'length then return FALSE; end if;
  return SIGNED_equal (L01, TO_SIGNED (R,L01'LENGTH)) ;
  end "=" ;


--=============================================================================

     -- Id: C.31
function "/="  ( L,R: UNSIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
alias XR: UNSIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : UNSIGNED(L_left downto 0);
variable R01 : UNSIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL);
  R01 := TO_01(XR);
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return TRUE; end if;
  return not(UNSIGNED_equal (RESIZE(L01,SIZE),RESIZE(R01,SIZE))) ;
  end "/=" ;

     -- Id: C.32
function "/="  ( L,R: SIGNED) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
constant R_left:INTEGER:= R'length-1;
alias XL: SIGNED(L_left downto 0) is L;
alias XR: SIGNED(R_left downto 0) is R;
constant SIZE: NATURAL:= MAX (L'LENGTH, R'LENGTH) ;
variable L01 : SIGNED(L_left downto 0);
variable R01 : SIGNED(R_left downto 0);
begin
  if ((L'length<1) or (R'length<1)) then return FALSE; end if;
  L01 := TO_01(XL);
  R01 := TO_01(XR);
  if ((L01(L01'left)='X') or (R01(R01'left)='X')) then return TRUE; end if;
  return not(SIGNED_equal (RESIZE(L01,SIZE), RESIZE(R01,SIZE))) ;
  end "/=" ;

     -- Id: C.33
function "/="  ( L: NATURAL; R: UNSIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: UNSIGNED(R_left downto 0) is R;
variable R01 : UNSIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR);
  if (R01(R01'left)='X') then return TRUE; end if;
  if UNSIGNED_NUM_BITS(L)>R'Length then return TRUE; end if;
  return not(UNSIGNED_equal ( TO_UNSIGNED(L,R01'LENGTH), R01));
  end "/=" ;

     -- Id: C.34
function "/="  ( L: INTEGER; R: SIGNED) return BOOLEAN is
constant R_left:INTEGER:= R'length-1;
alias XR: SIGNED(R_left downto 0) is R;
variable R01 : SIGNED(R_left downto 0);
begin
  if (R'length<1) then return FALSE; end if;
  R01 := TO_01(XR);
  if (R01(R01'left)='X') then return TRUE; end if;
  if Signed_NUM_BITS(L)>R'Length then return TRUE; end if;
  return not(SIGNED_equal ( TO_SIGNED(L,R01'LENGTH), R01)) ;
  end "/=" ;

     -- Id: C.35
function "/="  ( L: UNSIGNED; R: NATURAL) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: UNSIGNED(L_left downto 0) is L;
variable L01 : UNSIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL);
  if (L01(L01'left)='X') then return TRUE; end if;
  if UNSIGNED_NUM_BITS(R)>L'Length then return TRUE; end if;
  return not(UNSIGNED_equal (L01, TO_UNSIGNED (R,L01'LENGTH))) ;
  end "/=" ;

     -- Id: C.36
function "/="  ( L: SIGNED; R: INTEGER) return BOOLEAN is
constant L_left:INTEGER:= L'length-1;
alias XL: SIGNED(L_left downto 0) is L;
variable L01 : SIGNED(L_left downto 0);
begin
  if (L'length<1) then return FALSE; end if;
  L01 := TO_01(XL);
  if (L01(L01'left)='X') then return TRUE; end if;
  if Signed_NUM_BITS(R)>L'Length then return TRUE; end if;
  return not(SIGNED_equal (L01, TO_SIGNED (R,L01'LENGTH))) ;
  end "/=" ;


--=============================================================================

     -- Id: S.1
function shift_left(ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED is
begin
  if (ARG'length<1) then return NAU; end if;
  return UNSIGNED(XSLL(STD_LOGIC_VECTOR(ARG),COUNT));
  end;

     -- Id: S.2
function shift_right(ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED is
begin
  if (ARG'length<1) then return NAU; end if;
  return UNSIGNED(XSRL(STD_LOGIC_VECTOR(ARG),COUNT));
  end;

     -- Id: S.3
function shift_left(ARG: SIGNED; COUNT: NATURAL) return SIGNED is
begin
  if (ARG'length<1) then return NAS; end if;
  return SIGNED(XSLL(STD_LOGIC_VECTOR(ARG),COUNT));
  end;

     -- Id: S.4
function shift_right(ARG: SIGNED; COUNT: NATURAL) return SIGNED is
begin
  if (ARG'length<1) then return NAS; end if;
  return SIGNED(XSRA(STD_LOGIC_VECTOR(ARG),COUNT));
  end;

--=============================================================================

     -- Id: S.5
function rotate_left(ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED is
begin
  if (ARG'length<1) then return NAU; end if;
  return UNSIGNED(XROL(STD_LOGIC_VECTOR(ARG),COUNT));
  end;

     -- Id: S.6
function rotate_right(ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED is
begin
  if (ARG'length<1) then return NAU; end if;
  return UNSIGNED(XROR(STD_LOGIC_VECTOR(ARG),COUNT));
  end;


     -- Id: S.7
function rotate_left(ARG: SIGNED; COUNT: NATURAL) return SIGNED is
begin
  if (ARG'length<1) then return NAS; end if;
  return SIGNED(XROL(STD_LOGIC_VECTOR(ARG),COUNT));
  end;

     -- Id: S.8
function rotate_right(ARG: SIGNED; COUNT: NATURAL) return SIGNED is
begin
  if (ARG'length<1) then return NAS; end if;
  return SIGNED(XROR(STD_LOGIC_VECTOR(ARG),COUNT));
  end;

--=============================================================================


     -- Id: D.1
function TO_INTEGER(ARG: UNSIGNED) return NATURAL is
constant ARG_LEFT:INTEGER:= ARG'length-1;
alias XXARG:UNSIGNED(ARG_LEFT downto 0) is ARG;
variable XARG:UNSIGNED(ARG_LEFT downto 0); 
variable RESULT: NATURAL:= 0;
variable w : INTEGER:= 1;  -- weight factor
begin
  if (ARG'length<1) then
    assert NO_WARNING
    report "numeric_std.TO_INTEGER: null arg"
    severity warning;
    return 0;
    end if;
  XARG:= TO_01(XXARG);
  if (XARG(XARG'left)='X') then
    assert NO_WARNING
    report "numeric_std.TO_INTEGER: metavalue arg set to 0"
    severity warning;
    return 0;
    end if;
  for i in XARG'reverse_range loop
    if XARG (i) = '1' then
      RESULT:= RESULT + w;
      end if;
    if (i /= XARG'left) then w := w + w;
      end if;
    end loop;
  return RESULT;
  end TO_INTEGER;

     -- Id: D.2
function TO_INTEGER(ARG: SIGNED) return INTEGER is
begin
  if ARG(ARG'left) = '0' then
    return TO_INTEGER( UNSIGNED (ARG)) ;
  else
    return (- (TO_INTEGER( UNSIGNED ( - (ARG + 1)))) -1);
    end if;
  end TO_INTEGER;

     -- Id: D.3
function TO_UNSIGNED(ARG,SIZE: NATURAL) return UNSIGNED is
  variable RESULT: UNSIGNED (SIZE-1 downto 0) ;
  variable i_val:natural := ARG;
  begin
  if (SIZE < 1) then return NAU; end if;
  for i in 0 to RESULT'left loop
    if (i_val MOD 2) = 0 then
       RESULT(i) := '0';
    else RESULT(i) := '1' ;
      end if;
    i_val := i_val/2 ;
    end loop;
  if not(i_val=0) then
    assert NO_WARNING 
    report "numeric_std.TO_UNSIGNED : vector truncated"
    severity WARNING ;
    end if;
  return RESULT ;
  end TO_UNSIGNED;

     -- Id: D.4
function TO_SIGNED(ARG: INTEGER; SIZE: NATURAL) return SIGNED is
  variable RESULT: SIGNED (SIZE-1 downto 0) ;
  variable b_val : STD_LOGIC:= '0' ;
  variable i_val : INTEGER:= ARG ;
  begin
  if (SIZE < 1) then return NAS; end if;
  if (ARG<0) then
    b_val := '1' ;
    i_val := -(ARG+1) ;
    end if ;
  for i in 0 to RESULT'left loop
    if (i_val MOD 2) = 0 then
      RESULT(i) := b_val;
    else 
      RESULT(i) := not b_val ;
      end if;
    i_val := i_val/2 ;
    end loop;
  if ((i_val/=0) or (b_val/=RESULT(RESULT'left))) then
    assert NO_WARNING 
    report "numeric_std.TO_SIGNED : vector truncated"
    severity WARNING ;
    end if;
  return RESULT;
  end TO_SIGNED;

     -- Id: D.5
function TO_UNSIGNED(ARG: STD_LOGIC_VECTOR) return UNSIGNED is
  begin
  return UNSIGNED(ARG);
  end TO_UNSIGNED;
    
     -- Id: D.6
function TO_SIGNED(ARG: STD_LOGIC_VECTOR) return SIGNED is
  begin
  return SIGNED(ARG);
  end TO_SIGNED;

     -- Id: D.7
function TO_STDLOGICVECTOR(ARG: UNSIGNED) return STD_LOGIC_VECTOR is
  begin
  return STD_LOGIC_VECTOR(ARG);
  end TO_STDLOGICVECTOR;

     -- Id: D.8
function TO_STDLOGICVECTOR(ARG: SIGNED) return STD_LOGIC_VECTOR is
  begin
  return STD_LOGIC_VECTOR(ARG);
  end TO_STDLOGICVECTOR;

--=============================================================================


     -- Id: R.1
function RESIZE (ARG: SIGNED; NEW_SIZE: NATURAL) return SIGNED is
alias invec : SIGNED (ARG'length-1 downto 0) is ARG ;
variable RESULT: SIGNED (NEW_SIZE-1 downto 0) ;
constant bound : NATURAL:= MIN(ARG'length,RESULT'length)-2 ;
begin
  if (NEW_SIZE<1) then return NAS; end if;
  RESULT:= (others=>ARG(ARG'left)) ;
  if bound >= 0 then 
    RESULT(bound downto 0) := invec(bound downto 0) ;
    end if;
  return RESULT;
  end RESIZE ;


     -- Id: R.2
function RESIZE ( ARG: UNSIGNED; NEW_SIZE: NATURAL) return UNSIGNED is
constant ARG_LEFT:INTEGER:= ARG'length-1;
alias XARG: UNSIGNED(ARG_LEFT downto 0) is ARG;
variable RESULT: UNSIGNED(NEW_SIZE-1 downto 0) := (others=>'0');
begin
  if (NEW_SIZE<1) then return NAU; end if;
  if XARG'length=0 then return RESULT;
    end if;
  if (RESULT'length < ARG'length) then
    RESULT(RESULT'left downto 0) := XARG(RESULT'left downto 0);
  else
    RESULT(RESULT'left downto XARG'left+1) := (others => '0');
    RESULT(XARG'left downto 0) := XARG;
    end if;
  return RESULT;
  end RESIZE;

       
  --============================================================================

     -- Id: L.1
function "not" ( L: UNSIGNED) return UNSIGNED is
variable RESULT: UNSIGNED (L'range);
begin
  RESULT:= UNSIGNED(not(STD_LOGIC_VECTOR(L)));
  return RESULT;
  end "not";
   
     -- Id: L.2
function "and" ( L,R: UNSIGNED ) return UNSIGNED is
variable RESULT: UNSIGNED (L'range);
begin
  RESULT:= UNSIGNED(STD_LOGIC_VECTOR(L) and STD_LOGIC_VECTOR(R));
  return RESULT;
  end "and";
     
     -- Id: L.3
function "or" ( L,R: UNSIGNED ) return UNSIGNED is
variable RESULT: UNSIGNED (L'range);
begin
  RESULT:= UNSIGNED(STD_LOGIC_VECTOR(L) or STD_LOGIC_VECTOR(R));
  return RESULT;
  end "or";
     
     -- Id: L.4
function "nand" ( L,R: UNSIGNED ) return UNSIGNED is
variable RESULT: UNSIGNED (L'range);
begin
  RESULT:= UNSIGNED(STD_LOGIC_VECTOR(L) nand STD_LOGIC_VECTOR(R));
  return RESULT;
  end "nand";
     
     -- Id: L.5
function "nor" ( L,R: UNSIGNED ) return UNSIGNED is
variable RESULT: UNSIGNED (L'range);
begin
  RESULT:= UNSIGNED(STD_LOGIC_VECTOR(L) nor STD_LOGIC_VECTOR(R));
  return RESULT;
  end "nor";
     
     -- Id: L.6
function "xor" ( L,R: UNSIGNED ) return UNSIGNED is
variable RESULT: UNSIGNED (L'range);
begin
  RESULT:= UNSIGNED(STD_LOGIC_VECTOR(L) xor STD_LOGIC_VECTOR(R));
  return RESULT;
  end "xor";
     
--  -----------------------------------------------------------------------
--  Note : The declaration and implementation of the "xnor" function is
--  specifically commented until at which time the VHDL language has been
--  officially adopted as containing such a function. At such a point, 
--  the following comments may be removed along with this notice without
--  further "official" ballotting of this 1076.3 package. It is
--  the intent of this effort to provide such a function once it becomes
--  available in the VHDL standard.
--  -----------------------------------------------------------------------
     -- Id: L.7
--function "xnor" ( L,R: UNSIGNED ) return UNSIGNED is
--variable RESULT: UNSIGNED (L'range);
--begin
--  RESULT:= UNSIGNED(STD_LOGIC_VECTOR(L) xnor STD_LOGIC_VECTOR(R));
--  return RESULT;
--  end "xnor";
     
      -- Id: L.8
function "not" ( L: SIGNED) return SIGNED is
variable RESULT: SIGNED (L'range);
begin
  RESULT:= SIGNED(not(STD_LOGIC_VECTOR(L)));
  return RESULT;
  end "not";
 
     -- Id: L.9
function "and" ( L,R: SIGNED ) return SIGNED is
variable RESULT: SIGNED (L'range);
begin
  RESULT:= SIGNED(STD_LOGIC_VECTOR(L) and STD_LOGIC_VECTOR(R));
  return RESULT;
  end "and";
     
     -- Id: L.10
function "or" ( L,R: SIGNED ) return SIGNED is
variable RESULT: SIGNED (L'range);
begin
  RESULT:= SIGNED(STD_LOGIC_VECTOR(L) or STD_LOGIC_VECTOR(R));
  return RESULT;
  end "or";
     
     -- Id: L.11
function "nand" ( L,R: SIGNED ) return SIGNED is
variable RESULT: SIGNED (L'range);
begin
  RESULT:= SIGNED(STD_LOGIC_VECTOR(L) nand STD_LOGIC_VECTOR(R));
  return RESULT;
  end "nand";
     
     -- Id: L.12
function "nor" ( L,R: SIGNED ) return SIGNED is
variable RESULT: SIGNED (L'range);
begin
  RESULT:= SIGNED(STD_LOGIC_VECTOR(L) nor STD_LOGIC_VECTOR(R));
  return RESULT;
  end "nor";
     
     -- Id: L.13
function "xor" ( L,R: SIGNED ) return SIGNED is
variable RESULT: SIGNED (L'range);
begin
  RESULT:= SIGNED(STD_LOGIC_VECTOR(L) xor STD_LOGIC_VECTOR(R));
  return RESULT;
  end "xor";
     
--  -----------------------------------------------------------------------
--  Note : The declaration and implementation of the "xnor" function is
--  specifically commented until at which time the VHDL language has been
--  officially adopted as containing such a function. At such a point, 
--  the following comments may be removed along with this notice without
--  further "official" ballotting of this 1076.3 package. It is
--  the intent of this effort to provide such a function once it becomes
--  available in the VHDL standard.
--  -----------------------------------------------------------------------
     -- Id: L.14
--function "xnor" ( L,R: SIGNED ) return SIGNED is
--variable RESULT: SIGNED (L'range);
--begin
--  RESULT:= SIGNED(STD_LOGIC_VECTOR(L) xnor STD_LOGIC_VECTOR(R));
--  return RESULT;
--  end "xnor";
     
--=============================================================================

-- support constants for STD_MATCH:

 type STDULOGIC_TABLE is array(STD_ULOGIC, STD_ULOGIC) of STD_ULOGIC;

 -- truth table for "and" function
 constant AND_TABLE : STDULOGIC_TABLE := (
 -- ----------------------------------------------------
 -- | U X 0 1 Z W L H -  | |
 -- ----------------------------------------------------
         ( 'U', 'U', '0', 'U', 'U', 'U', '0', 'U', 'U' ), -- | U |
         ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' ), -- | X |
         ( '0', '0', '0', '0', '0', '0', '0', '0', '0' ), -- | 0 |
         ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ), -- | 1 |
         ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' ), -- | Z |
         ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' ), -- | W |
         ( '0', '0', '0', '0', '0', '0', '0', '0', '0' ), -- | L |
         ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ), -- | H |
         ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' )  -- | - |
 );

 -- truth table for STD_MATCH function
 constant MATCH_TABLE : STDULOGIC_TABLE := (
 -- ----------------------------------------------------
 -- | U X 0 1 Z W L H -  | |
 -- ----------------------------------------------------
         ( 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', '1' ), -- | U |
         ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '1' ), -- | X |
         ( 'U', 'X', '1', '0', 'X', 'X', '1', '0', '1' ), -- | 0 |
         ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', '1' ), -- | 1 |
         ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '1' ), -- | Z |
         ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '1' ), -- | W |
         ( 'U', 'X', '1', '0', 'X', 'X', '1', '0', '1' ), -- | L |
         ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', '1' ), -- | H |
         ( '1', '1', '1', '1', '1', '1', '1', '1', '1' )  -- | - |
 );

     -- Id: M.1
function STD_MATCH (L, R: STD_ULOGIC) return BOOLEAN is
  variable VALUE : STD_ULOGIC;
  begin
    VALUE := MATCH_TABLE(L, R);
    return VALUE = '1';
  end STD_MATCH;

     
     -- Id: M.2
function STD_MATCH (L, R: STD_LOGIC_VECTOR) return BOOLEAN is
  alias LV: STD_LOGIC_VECTOR ( 1 to L'LENGTH ) is L;
  alias RV: STD_LOGIC_VECTOR ( 1 to R'LENGTH ) is R;
  variable VALUE: STD_ULOGIC:= '1';
  begin
    -- Check that both input vectors are the same length.
    if LV'LENGTH /= RV'LENGTH then
      assert NO_WARNING
      report "STD_MATCH input arguments are not of equal length"
      severity warning;
      return FALSE;
    else
      for i in LV'LOW to LV'HIGH loop
        VALUE := AND_TABLE(MATCH_TABLE(LV(i), RV(i)), VALUE);
        end loop;
      return VALUE = '1';
      end if;
  end STD_MATCH;



--=============================================================================
end numeric_std;




