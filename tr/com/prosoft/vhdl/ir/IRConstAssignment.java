package com.prosoft.vhdl.ir;

public class IRConstAssignment extends IROper {
	
	public IRConstAssignment( IROper expr ) {
		setChild(0, expr);
	}
	
	public IRConstAssignment dup() {
		return (IRConstAssignment) new IRConstAssignment( getChild(0).dup() ).dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.CNST_ASGN;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		throw new RuntimeException();
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}

}
