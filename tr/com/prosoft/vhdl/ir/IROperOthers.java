package com.prosoft.vhdl.ir;

public class IROperOthers extends IROper {
	
	public IROperOthers(){}
	
	public IROperOthers dup() {
		return (IROperOthers) new IROperOthers().dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.OTHERS;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	public String toString() {
		return "others";
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return other.getKind() == IROperKind.OTHERS;
	}
}
