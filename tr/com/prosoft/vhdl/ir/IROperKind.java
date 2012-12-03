package com.prosoft.vhdl.ir;

public enum IROperKind {
	
	ERROR,
	
	CNST_ASGN, // псевдооперация инициализации константы
	// statements
	VAR_ASGN,
	SIG_ASGN,
	IF,
	CASE,
	RETURN,
	FOR,
	WHILE,
	ETERNAL_LOOP,
	EXIT,
	STATS,
	EMPTY_STATEMENT,
	PROC_CALL,
	SELECT_ASGN,
	WAIT,
	REPORT,
	ASSERT,
	
	GEN_IF, // варианты generate
	GEN_FOR,
	
//	OBJECT, // Маркерная псевдооперация, под ней содержится спецификатор объекта (сигнала или переменной)
	
	QUALIFY,
	
	RANGE,
	
	COND,
	
	NAME, // псевдо-операция, которая содержит только имя
	
	ASSOC, // association, левая часть - подвыражение, которому присваивается правая часть
	
	CHOICES,
	
	AGGREG,
	
	INDEX,
	
	ATTRIB,
	
	ARRAY_BOUND,
	
	OTHERS,
	ALL,
	OPEN,
	NULL,
	
	COMMA,
	
	CONST,
	
	CONST_READ, // чтение константы в ран-тайм
	
	FCALL, // function call
	
	OPERATOR_SYMBOL,
	
	TYPE_CAST,
	
	AFTER,

	// logical 
	AND,
	OR,
	NAND,
	NOR,
	XOR,
	XNOR,


	// shift
	SLL,
	SRL,
	SLA,
	SRA,
	ROL,
	ROR,

	// relation
	EQ,
	NEQ,
	LO,
	LE,
	GT,
	GE,

	// adding
	ADD,
	SUB,
	CONCAT,

	// multiplying
	MUL,
	DIV,
	MOD,
	REM,
	
	POW,
	
	NEG,
	ABS,
	NOT,
	
	SGNL,
	VAR,
	ALIAS,
	
	DOT,
	FIELD,
	QUOTE,
}
