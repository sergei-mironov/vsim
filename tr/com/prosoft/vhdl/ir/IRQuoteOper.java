package com.prosoft.vhdl.ir;

public class IRQuoteOper extends IROper {
	
	public IRQuoteOper( IROper op1, IROper op2 ) {
		super(op1, op2);
	}
	
	protected IRQuoteOper() {}
	
	public IRQuoteOper dup() {
		return (IRQuoteOper) new IRQuoteOper().dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.QUOTE;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}

}
