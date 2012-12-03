package com.prosoft.verilog.ir;

public class VReturnStatement extends VStatement {
	
	@Override
	protected void check(VEnvironment env) {
		throw new RuntimeException();
	}

	@Override
	public VStatementKind getStatementKind() {
		return VStatementKind.RETURN;
	}

	public VOper getResult() {
		return getChild(0);
	}

}
