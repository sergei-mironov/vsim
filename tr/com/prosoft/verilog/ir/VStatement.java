package com.prosoft.verilog.ir;

public abstract class VStatement extends VOper {
	
	VDelayOrEventControl control;

	@Override
	public VOperKind getKind() {
		return VOperKind.STATEMENT;
	}

	@Override
	final protected VType inferTypeInternal(VEnvironment env) {
		throw new RuntimeException();
	}

	protected abstract void check(VEnvironment env);
	public abstract VStatementKind getStatementKind();

	public VDelayOrEventControl getControl() {
		return control;
	}

	public void setControl(VDelayOrEventControl control) {
		this.control = control;
	}
	
}
