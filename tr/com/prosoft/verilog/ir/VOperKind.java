package com.prosoft.verilog.ir;

public enum VOperKind {

	CONST,
	RANGE,
	COND,
	BINARY,
	UNARY,
	NAME,
	DOT,
	INDEX,
	SLICE,
	CONCAT,
	REPLIC,
	CAST,
	DELAY,
	CALL,
	AFTER,
	
	EDGE,
	
	NAMED_ASSIGN, // операция связывания для именованных параметров типа param_name <= param_value
	
	STATEMENT,
	CASE_ELEMENT
}
