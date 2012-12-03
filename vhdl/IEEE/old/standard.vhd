-- The sven STANDARD package.
-- This design unit contains some special tokens, which are only
-- recognized by the analyzer when it is in special "bootstrap" mode.

package STANDARD is

  -- predefined enumeration types:

  type BOOLEAN is (FALSE, TRUE);
  
  function "-" ( a, b: integer ) return integer;
  function "+" ( a, b: integer ) return integer;
  function "*" ( a, b: integer ) return integer;
  function "/" ( a, b: integer ) return integer;
  function "mod" ( a, b: integer ) return integer;
  function "**" ( a, b: integer ) return integer;

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
-- The predefined operators for this type are as follows:
-- function "and" (anonymous, anonymous: BIT) return BIT;
-- function "or" (anonymous, anonymous: BIT) return BIT;
-- function "nand" (anonymous, anonymous: BIT) return BIT;
-- function "nor" (anonymous, anonymous: BIT) return BIT;
-- function "xor" (anonymous, anonymous: BIT) return BIT;
-- function "xnor" (anonymous, anonymous: BIT) return BIT;
-- function "not" (anonymous: BIT) return BIT;
-- function "=" (anonymous, anonymous: BIT) return BOOLEAN;
-- function "/=" (anonymous, anonymous: BIT) return BOOLEAN;
-- function "<" (anonymous, anonymous: BIT) return BOOLEAN;
-- function "<=" (anonymous, anonymous: BIT) return BOOLEAN;
-- function ">" (anonymous, anonymous: BIT) return BOOLEAN;
-- function ">=" (anonymous, anonymous: BIT) return BOOLEAN;

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

--  type $UNIVERSAL_REAL is range $-. to $+.;

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

  -- subtype used internally for checking time expressions for non-negativness:

--  subtype $NATURAL_TIME is TIME range 0 sec to TIME'HIGH;

--  subtype DELAY_LENGTH is TIME range 0 fs to TIME'HIGH;

  -- function that returns the current simulation time:

--  impure function NOW return TIME;

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

end STANDARD;
