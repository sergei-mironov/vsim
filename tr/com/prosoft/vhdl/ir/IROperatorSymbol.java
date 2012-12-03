package com.prosoft.vhdl.ir;

public class IROperatorSymbol extends IROper {
	
	String image;
	
	public IROperatorSymbol( String image ) {
		this.image = image;
	}
	
	public IROperatorSymbol dup() {
		return (IROperatorSymbol) new IROperatorSymbol(image).dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.OPERATOR_SYMBOL;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		// TODO Auto-generated method stub
		
	}

	public String getImage() {
		return image;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !(other instanceof IROperatorSymbol) ) return false;
		return image.equalsIgnoreCase( ((IROperatorSymbol)other).image );
	}
	
//	logical_operator ::= and | or | nand | nor | xor | xnor
//	relational_operator ::= = | /= | < | <= | > | >=
//	shift_operator ::= sll | srl | sla | sra | rol | ror
//	adding_operator ::= + | – | &
//	sign ::= + | –
//	multiplying_operator ::= * | / | mod | rem
//	miscellaneous_operator ::= ** | abs | not

	public enum Type {
		AND, OR, NAND, NOR, XOR, XNOR,
		EQ, NE, LT, LE, GT, GE,
		SLL, SRL, SLA, SRA, ROL, ROR,
		ADD, SUB, CONCAT,
		PLUS, MINUS,
		MUL, DIV, MOD, REM,
		POW, ABS, NOT
	}
	
	public static String[] Images = {
			"and", "or", "nand", "nor", "xor", "xnor",
			"=", "/=", "<", "<=", ">", ">=",
			"sll", "srl", "sla", "sra", "rol", "ror",
			"+", "–", "&",
			"+", "–",
			"*", "/", "mod", "rem",
			"**", "abs", "not"
	};
	
	public static Type getType( String image, boolean isBinary ) {
		image = image.substring( 1, image.length()-1 ).toLowerCase();
		if( image.length() == 1 ) {
			if( image.charAt(0) == '+' ) 
				return isBinary ? Type.ADD : Type.PLUS;
			else if( image.charAt(0) == '-' )
				return isBinary ? Type.SUB : Type.MINUS;
		}
		for( int i = Type.AND.ordinal(); i <= Type.NOT.ordinal(); i++ ) {
			if( image.equals(Images[i]) ) return Type.values()[i];
		}
		return null;
	}
}
