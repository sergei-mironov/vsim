package com.prosoft.verilog.ir;

public enum VUnaryKind {

	LNOT,
	BNOT,
	PLUS,
	MINUS,
//	! Logical negation
//	~ Bit-wise negation
	
//	& Reduction and
	RED_AND,
//	~& Reduction nand
	RED_NAND,
//	| Reduction or
	RED_OR,
//	~| Reduction nor
	RED_NOR,
//	^ Reduction xor
	RED_XOR,
//	~^ or ^~ Reduction xnor
	RED_XNOR;
	
	public String getImage() {
		switch(this) {
		case LNOT: return "!";
		case BNOT: return "~";
		case PLUS: return "+";
		case MINUS: return "-";
		case RED_OR: return "redor";
		case RED_NOR: return "rednor";
		case RED_XOR: return "redxor";
		case RED_AND: return "redand";
		case RED_XNOR: return "redxnor";
		default: throw new RuntimeException(this.toString());
		}
	}
}
