package com.prosoft.verilog.ir;

public enum VBinaryKind {

//	{} {{}} Concatenation, replication
//	CONCAT, REPLIC,
//	+ - * / ** Arithmetic
	ADD,
	SUB,
	MUL,
	DIV,
	POW,
	
//	% Modulus
	MOD,
//	> >= < <= Relational
	GT, GE, LT, LE,
//	! Logical negation
//	&& Logical and
	LAND,
//	|| Logical or
	LOR,
//	== Logical equality
	EQ,
//	!= Logical inequality
	NE,
//	=== Case equality
	CEQ,
//	!== Case inequality
	CNE,
//	~ Bit-wise negation
//	& Bit-wise and
	BAND,
//	| Bit-wise inclusive or
	BOR,
//	^ Bit-wise exclusive or
	BXOR,
//	^~ or ~^ Bit-wise equivalence
	BEQ,
//	<< Logical left shift
	LSL,
//	>> Logical right shift
	LSR,
//	<<< Arithmetic left shift
	ASL,
//	>>> Arithmetic right shift
	ASR,
//	? : Conditional
//	or Event or
	EVENT_OR;
	
	public String getImage() {
		switch(this) {
		case ADD: return "+";
		case SUB: return "-";
		case EQ: return "==";
		case NE: return "/=";
		
		case LAND: return "and";
		case LOR: return "or";
		
		case BAND: return "band";
		case BOR: return "bor";
		case BXOR: return "bxor";
		
		case GT: return ">";
		case LT: return "<";
		case GE: return ">=";
		case LE: return "<=";
		case CEQ: return "==";
		case CNE: return "!=";
		
		case ASL: return "<<<";
		case ASR: return ">>>";
		
		default: throw new RuntimeException(this.toString());
		}
	}
	
//	+ - ! ~ (unary) Highest precedence
//	**
//	* / %
//	+ - (binary)
//	<< >> <<< >>>
//	< <= > >=
//	== != === !==
//	& ~&
//	^ ^~ ~^
//	| ~|
//	&&
//	||
//	?: (conditional operator) Lowest precedence	
}
