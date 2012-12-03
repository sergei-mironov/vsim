package com.prosoft.vhdl.ir;

public class IROperNull extends IROper {

	@Override
	public IROper dup() {
		IROperNull res = new IROperNull();
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.NULL;
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

	public String toString() {
		return "NULL";
	}
}
