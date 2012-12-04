package com.prosoft.vhdl.ir;

public class IROpen extends IROper {
	
	public IROpen() {}

	@Override
	public IROperKind getKind() {
		return IROperKind.OPEN;
	}
	
	public IROpen dup() {
		return (IROpen) new IROpen().dupChildrenAndCoordAndType(this);
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
	}

}
