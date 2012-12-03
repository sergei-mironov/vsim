-- The sven STANDARD package.
-- This design unit contains some special tokens, which are only
-- recognized by the analyzer when it is in special "bootstrap" mode.

package STANDARD is

  -- predefined enumeration types:
  type BOOLEAN is (FALSE, TRUE);

  type INTEGER is range 0 to 2147483647;
  type REAL is range 0.0 to 1.79769e+308;

  function "-" ( a, b: integer ) return integer;
  function "+" ( a, b: integer ) return integer;
  function "*" ( a, b: integer ) return integer;
  function "/" ( a, b: integer ) return integer;
  function "mod" ( a, b: integer ) return integer;
  function "rem" (anonymous, anonymous2: integer) return integer;
  function "**" ( a, b: integer ) return integer;

 function "=" (anonymous, anonymous2: real) return BOOLEAN;
 function "/=" (anonymous, anonymous2: real) return BOOLEAN;
 function "<" (anonymous, anonymous2: real) return BOOLEAN;
 function "<=" (anonymous, anonymous2: real) return BOOLEAN;
 function ">" (anonymous, anonymous2: real) return BOOLEAN;
 function ">=" (anonymous, anonymous2: real) return BOOLEAN;
 function "+" (anonymous: real) return real;
 function "-" (anonymous: real) return real;
 function "abs" (anonymous: real) return real;
 function "+" (anonymous, anonymous2: real) return real;
 function "-" (anonymous, anonymous2: real) return real;
 function "*" (anonymous, anonymous2: real) return real;
 function "/" (anonymous, anonymous2: real) return real;
 function "*" (anonymous: real; anonymous: integer)
 return real;
 function "*" (anonymous: integer; anonymous: real)
 return real;
 function "/" (anonymous: real; anonymous: integer)
 return real;

  type INTEGER is range -2147483647-1 to 2147483647;
  -- -2147483648 doesn't work, seems that it parsed as unary minus 2147483648
  type REAL is range -1.79769e+308 to 1.79769e+308;

  function "and" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "or" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "nand" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "nor" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "xor" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "xnor" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "not" (anonymous1: BOOLEAN) return BOOLEAN;
 function "=" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "/=" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "<" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function "<=" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function ">" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;
 function ">=" (anonymous1, anonymous2: BOOLEAN) return BOOLEAN;

type BIT is ('0', '1');
 --The predefined operators for this type are as follows:
 function "and" (anonymous, anonymous: BIT) return BIT;
 function "or" (anonymous, anonymous: BIT) return BIT;
 function "nand" (anonymous, anonymous: BIT) return BIT;
 function "nor" (anonymous, anonymous: BIT) return BIT;
 function "xor" (anonymous, anonymous: BIT) return BIT;
 function "xnor" (anonymous, anonymous: BIT) return BIT;
 function "not" (anonymous: BIT) return BIT;
 function "=" (anonymous, anonymous: BIT) return BOOLEAN;
 function "/=" (anonymous, anonymous: BIT) return BOOLEAN;
 function "<" (anonymous, anonymous: BIT) return BOOLEAN;
 function "<=" (anonymous, anonymous: BIT) return BOOLEAN;
 function ">" (anonymous, anonymous: BIT) return BOOLEAN;
 function ">=" (anonymous, anonymous: BIT) return BOOLEAN;

  type CHARACTER is (
	NUL,	SOH,	STX,	ETX,	EOT,	ENQ,	ACK,	BEL,
	BS,	HT,	LF,	VT,	FF,	CR,	SO,	SI,
	DLE,	DC1,	DC2,	DC3,	DC4,	NAK,	SYN,	ETB,
	CAN,	EM,	SUB,	ESC,	FSP,	GSP,	RSP,	USP,

	' ',	'!',	'"',	'#',	'$',	'%',	'&',	''',
	'(',	')',	'*',	'+',	',',	'-',	'.',	'/',
	'0',	'1',	'2',	'3',	'4',	'5',	'6',	'7',
	'8',	'9',	':',	';',	'<',	'=',	'>',	'?',

	'@',	'A',	'B',	'C',	'D',	'E',	'F',	'G',
	'H',	'I',	'J',	'K',	'L',	'M',	'N',	'O',
	'P',	'Q',	'R',	'S',	'T',	'U',	'V',	'W',
	'X',	'Y',	'Z',	'[',	'\',	']',	'^',	'_',

	'`',	'a',	'b',	'c',	'd',	'e',	'f',	'g',
	'h',	'i',	'j',	'k',	'l',	'm',	'n',	'o',
	'p',	'q',	'r',	's',	't',	'u',	'v',	'w',
	'x',	'y',	'z',	'{',	'|',	'}',	'~',	DEL,
    C128,   C129,   C130,   C131,   C132,   C133,   C134,   C135,
    C136,   C137,   C138,   C139,   C140,   C141,   C142,   C143,
    C144,   C145,   C146,   C147,   C148,   C149,   C150,   C151,
    C152,   C153,   C154,   C155,   C156,   C157,   C158,   C159
	--,
--   ' ',  '¡', '¢', '£', '¤', '¥', '¦', '§',
--   '¨',  '©', 'ª', '«', '¬', '­', '®', '¯',
--   '°',  '±', '²', '³', '´', 'µ', '¶', '·',
--   '¸', '¹', 'º',  '»', '¼', '½', '¾', '¿',  
--   'À', 'Á', 'Â',  'Ã', 'Ä', 'Å', 'Æ', 'Ç',
--   'È',  'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï',
--   'Ð',  'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö',  '×',
--   'Ø',  'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'Þ', 'ß',
--   'à',  'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç',
--   'è',  'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï',
--   'ð',  'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', '÷',
--   'ø',  'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ'
); 
     
    

  type SEVERITY_LEVEL is (NOTE, WARNING, ERROR, FAILURE);

  -- predefined numeric types:

  -- Do INTEGER first to aid implicit declarations of "**".
--  type INTEGER is range -2147483647 to 2147483647;

--  type $UNIVERSAL_INTEGER is range $- to $+;

--  type $real is range $-. to $+.;

  function "*" (LEFT: real; RIGHT: INTEGER)
	return real;

  function "*" (LEFT: INTEGER; RIGHT: REAL)
	return REAL;

  function "/" (LEFT: REAL; RIGHT: INTEGER)
	return REAL;

--  type REAL is range $-. to $+.;

  -- predefined type TIME:

  type TIME is range -1000000 to +100000000
	units
		fs;			-- femtosecond
		ps	=  1000 fs;	-- picosecond
		ns	=  1000 ps;	-- nanosecond
		us	=  1000 ns;	-- microsecond
		ms	=  1000 us;	-- millisecond
		sec	=  1000 ms;	-- second
		min	=  60 sec;	-- minute
		hr	=  60 min;	-- hour;
  end units;
  
function "=" (anonymous1, anonymous2: TIME) return BOOLEAN;
function "/=" (anonymous1, anonymous2: TIME) return BOOLEAN;
function "<" (anonymous1, anonymous2: TIME) return BOOLEAN;
function "<=" (anonymous1, anonymous2: TIME) return BOOLEAN;
function ">" (anonymous1, anonymous2: TIME) return BOOLEAN;
function ">=" (anonymous1, anonymous2: TIME) return BOOLEAN;
function "+" (anonymous1: TIME) return TIME;
function "-" (anonymous1: TIME) return TIME;
function "abs" (anonymous1: TIME) return TIME;
function "+" (anonymous1, anonymous2: TIME) return TIME;
function "-" (anonymous1, anonymous2: TIME) return TIME;
function "*" (anonymous1: TIME; anonymous2: INTEGER) return TIME;
function "*" (anonymous1: TIME; anonymous2: REAL) return TIME;
function "*" (anonymous1: INTEGER; anonymous2: TIME) return TIME;
function "*" (anonymous1: REAL; anonymous2: TIME) return TIME;
function "/" (anonymous1: TIME; anonymous2: INTEGER) return TIME;
function "/" (anonymous1: TIME; anonymous2: REAL) return TIME;
function "/" (anonymous1, anonymous2: TIME) return INTEGER;

function "**" (anonymous: real; anonymous: INTEGER)
return real;


  -- subtype used internally for checking time expressions for non-negativness:

--  subtype $NATURAL_TIME is TIME range 0 sec to TIME'HIGH;

  subtype DELAY_LENGTH is TIME range 0 fs to TIME'HIGH;

  -- function that returns the current simulation time:

  impure function NOW return TIME;

  -- predefined numeric subtypes:

  subtype NATURAL is INTEGER range 0 to INTEGER'HIGH;

  subtype POSITIVE is INTEGER range 1 to INTEGER'HIGH;

  -- predefined array types:

  type STRING is array (POSITIVE range <>) of CHARACTER;
  
  function "&" ( a, b: STRING ) return STRING;

  type BIT_VECTOR is array (NATURAL range <>) of BIT;

--type FILE_OPEN_KIND is (READ_OPEN, WRITE_OPEN, APPEND_OPEN);

  type FILE_OPEN_KIND is (READ_MODE, WRITE_MODE, APPEND_MODE);

  type FILE_OPEN_STATUS is (OPEN_OK, STATUS_ERROR, NAME_ERROR, MODE_ERROR);

  attribute FOREIGN: STRING;

  --
  -- The rest of this package is SVEN specific stuff required to make
  -- this implementation go.
  -- Note that all things are declared use leading $ characters, so we don't
  -- trample the user's name space.
  --

--  attribute $BUILTIN: BOOLEAN;

--  procedure $RTINDEX (I: NATURAL; FIRSTARG: INTEGER; PASSAP,SAVEFREGS: BOOLEAN);
--  procedure $RTSYMBOL (S: STRING; FIRSTARG: INTEGER; PASSAP,SAVEFREGS: BOOLEAN);

--  attribute $BUILTIN of all: function is TRUE;
--  attribute $BUILTIN of all: procedure is TRUE;

 function "and" (l, r: BIT_VECTOR) return BIT_VECTOR;
-- function "and" (anonymous, anonymous2: BIT_VECTOR) return BIT_VECTOR;
 function "or" (l, r: BIT_VECTOR) return BIT_VECTOR;
 function "nand" (anonymous, anonymous2: BIT_VECTOR) return BIT_VECTOR;
 function "nor" (anonymous, anonymous2: BIT_VECTOR) return BIT_VECTOR;
 function "xor" (l, r: BIT_VECTOR) return BIT_VECTOR;
 function "xnor" (anonymous, anonymous2: BIT_VECTOR) return BIT_VECTOR;
 function "not" (l: BIT_VECTOR) return BIT_VECTOR;
-- function "not" (anonymous: BIT_VECTOR) return BIT_VECTOR;


 function "sll" (ARG: BIT_VECTOR; COUNT: INTEGER)
 return BIT_VECTOR;
 function "srl" (ARG: BIT_VECTOR; COUNT: INTEGER)
 return BIT_VECTOR;
-- function "sll" (anonymous: BIT_VECTOR; anonymous2: INTEGER)
-- return BIT_VECTOR;
-- function "srl" (anonymous: BIT_VECTOR; anonymous2: INTEGER)
-- return BIT_VECTOR;
 function "sla" (anonymous: BIT_VECTOR; anonymous2: INTEGER)
 return BIT_VECTOR;
 function "sra" (anonymous: BIT_VECTOR; anonymous2: INTEGER)
 return BIT_VECTOR;
 function "rol" (ARG: BIT_VECTOR; COUNT: INTEGER)
 return BIT_VECTOR;
 function "ror" (ARG: BIT_VECTOR; COUNT: INTEGER)
 return BIT_VECTOR;
-- function "rol" (anonymous: BIT_VECTOR; anonymous2: INTEGER)
-- return BIT_VECTOR;
-- function "ror" (anonymous: BIT_VECTOR; anonymous2: INTEGER)
-- return BIT_VECTOR;
 function "=" (anonymous, anonymous2: BIT_VECTOR) return BOOLEAN;
 function "/=" (anonymous, anonymous2: BIT_VECTOR) return BOOLEAN;
 function "<" (anonymous, anonymous2: BIT_VECTOR) return BOOLEAN;
 function "<=" (anonymous, anonymous2: BIT_VECTOR) return BOOLEAN;
 function ">" (anonymous, anonymous2: BIT_VECTOR) return BOOLEAN;
 function ">=" (anonymous, anonymous2: BIT_VECTOR) return BOOLEAN;
 function "&" (anonymous: BIT_VECTOR; anonymous2: BIT_VECTOR)
 return BIT_VECTOR;
 function "&" (anonymous: BIT_VECTOR; anonymous2: BIT) return BIT_VECTOR;
 function "&" (anonymous: BIT; anonymous2: BIT_VECTOR) return BIT_VECTOR;
 function "&" (anonymous: BIT; anonymous2: BIT) return BIT_VECTOR;

end STANDARD;

PACKAGE BODY STANDARD IS
    -- logic and shift functions on bit_vector are not builtin

    FUNCTION "and"  ( l,r : BIT_VECTOR ) RETURN BIT_VECTOR IS
        ALIAS lv : BIT_VECTOR ( 1 TO l'LENGTH ) IS l;
        ALIAS rv : BIT_VECTOR ( 1 TO r'LENGTH ) IS r;
        VARIABLE result : BIT_VECTOR ( 1 TO l'LENGTH );
    BEGIN
        IF ( l'LENGTH /= r'LENGTH ) THEN
            ASSERT FALSE
--            REPORT "arguments of overloaded 'and' operator are not of the same length"
            SEVERITY FAILURE;
        ELSE
            FOR i IN result'RANGE LOOP
                result(i) := lv(i) and rv(i);
            END LOOP;
        END IF;
        RETURN result;
    END "and";

    FUNCTION "or"  ( l,r : BIT_VECTOR ) RETURN BIT_VECTOR IS
        ALIAS lv : BIT_VECTOR ( 1 TO l'LENGTH ) IS l;
        ALIAS rv : BIT_VECTOR ( 1 TO r'LENGTH ) IS r;
        VARIABLE result : BIT_VECTOR ( 1 TO l'LENGTH );
    BEGIN
        IF ( l'LENGTH /= r'LENGTH ) THEN
            ASSERT FALSE
--            REPORT "arguments of overloaded 'or' operator are not of the same length"
            SEVERITY FAILURE;
        ELSE
            FOR i IN result'RANGE LOOP
                result(i) := lv(i) or rv(i);
            END LOOP;
        END IF;
        RETURN result;
    END "or";

    FUNCTION "xor"  ( l,r : BIT_VECTOR ) RETURN BIT_VECTOR IS
        ALIAS lv : BIT_VECTOR ( 1 TO l'LENGTH ) IS l;
        ALIAS rv : BIT_VECTOR ( 1 TO r'LENGTH ) IS r;
        VARIABLE result : BIT_VECTOR ( 1 TO l'LENGTH );
    BEGIN
        IF ( l'LENGTH /= r'LENGTH ) THEN
            ASSERT FALSE
--            REPORT "arguments of overloaded 'xor' operator are not of the same length"
            SEVERITY FAILURE;
        ELSE
            FOR i IN result'RANGE LOOP
                result(i) := lv(i) xor rv(i);
            END LOOP;
        END IF;
        RETURN result;
    END "xor";

    FUNCTION "not"  ( l : BIT_VECTOR ) RETURN BIT_VECTOR IS
      -- strange, but translator raises NPE if we rename 'l' to
      -- something else
        ALIAS lv : BIT_VECTOR ( 1 TO l'LENGTH ) IS l;
        VARIABLE result : BIT_VECTOR ( 1 TO l'LENGTH ) := (OTHERS => '0');
    BEGIN
        FOR i IN result'RANGE LOOP
            result(i) := not lv(i);
        END LOOP;
        RETURN result;
    END;
  

  function XSLL (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := (others => '0');
  begin
    if COUNT <= ARG_L then
      RESULT(ARG_L downto COUNT) := XARG(ARG_L-COUNT downto 0);
    end if;
    return RESULT;
  end XSLL;

  function XSRL (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := (others => '0');
  begin
    if COUNT <= ARG_L then
      RESULT(ARG_L-COUNT downto 0) := XARG(ARG_L downto COUNT);
    end if;
    return RESULT;
  end XSRL;

  function XSRA (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0);
    variable XCOUNT: NATURAL := COUNT;
  begin
    if ((ARG'LENGTH <= 1) or (XCOUNT = 0)) then return ARG;
    else
      if (XCOUNT > ARG_L) then XCOUNT := ARG_L;
      end if;
      RESULT(ARG_L-XCOUNT downto 0) := XARG(ARG_L downto XCOUNT);
      RESULT(ARG_L downto (ARG_L - XCOUNT + 1)) := (others => XARG(ARG_L));
    end if;
    return RESULT;
  end XSRA;

  function XROL (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := XARG;
    variable COUNTM: INTEGER;
  begin
    COUNTM := COUNT mod (ARG_L + 1);
    if COUNTM /= 0 then
      RESULT(ARG_L downto COUNTM) := XARG(ARG_L-COUNTM downto 0);
      RESULT(COUNTM-1 downto 0) := XARG(ARG_L downto ARG_L-COUNTM+1);
    end if;
    return RESULT;
  end XROL;

  function XROR (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
    constant ARG_L: INTEGER := ARG'LENGTH-1;
    alias XARG: BIT_VECTOR(ARG_L downto 0) is ARG;
    variable RESULT: BIT_VECTOR(ARG_L downto 0) := XARG;
    variable COUNTM: INTEGER;
  begin
    COUNTM := COUNT mod (ARG_L + 1);
    if COUNTM /= 0 then
      RESULT(ARG_L-COUNTM downto 0) := XARG(ARG_L downto COUNTM);
      RESULT(ARG_L downto ARG_L-COUNTM+1) := XARG(COUNTM-1 downto 0);
    end if;
    return RESULT;
  end XROR;

  constant NAU: BIT_VECTOR(0 downto 1) := (others => '0');

  -- Id: S.1
  function SHIFT_LEFT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return (XSLL((ARG), COUNT));
  end SHIFT_LEFT;

  -- Id: S.2
  function SHIFT_RIGHT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return (XSRL((ARG), COUNT));
  end SHIFT_RIGHT;

  --============================================================================

  -- Id: S.5
  function ROTATE_LEFT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return (XROL((ARG), COUNT));
  end ROTATE_LEFT;

  -- Id: S.6
  function ROTATE_RIGHT (ARG: BIT_VECTOR; COUNT: NATURAL) return BIT_VECTOR is
  begin
    if (ARG'LENGTH < 1) then return NAU;
    end if;
    return (XROR((ARG), COUNT));
  end ROTATE_RIGHT;

  --============================================================================

  function "sll" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return SHIFT_LEFT(ARG, COUNT);
    else
      return SHIFT_RIGHT(ARG, -COUNT);
    end if;
  end "sll";

  function "srl" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return SHIFT_RIGHT(ARG, COUNT);
    else
      return SHIFT_LEFT(ARG, -COUNT);
    end if;
  end "srl";

  function "rol" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return ROTATE_LEFT(ARG, COUNT);
    else
      return ROTATE_RIGHT(ARG, -COUNT);
    end if;
  end "rol";

  function "ror" (ARG: BIT_VECTOR; COUNT: INTEGER) return BIT_VECTOR is
  begin
    if (COUNT >= 0) then
      return ROTATE_RIGHT(ARG, COUNT);
    else
      return ROTATE_LEFT(ARG, -COUNT);
    end if;
  end "ror";
end STANDARD;
