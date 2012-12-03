package com.prosoft.vhdl.ir;

public class IRAll extends IROper {

	@Override
	public IROperKind getKind() {
		return IROperKind.ALL;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
	}

	public String toString() {
		return "all";
	}

	@Override
	public boolean isEqualTo(IROper op) {
		return op.getKind() == IROperKind.ALL;
	}

	@Override
	public IROper dup() {
		return new IRAll().dupChildrenAndCoordAndType(this);
	}
}
