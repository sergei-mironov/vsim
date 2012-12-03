package com.prosoft.vhdl.ir;

import com.prosoft.common.TextCoord;

public class IROperError extends IROper {
	
	public IROperError(TextCoord coord) {
		setBegin(coord);
	}

	@Override
	public IROper dup() {
		return this;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.ERROR;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return false;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		err.unexpected(getParentOper());
	}

	public String toString() {
		return "ERROR";
	}
}
