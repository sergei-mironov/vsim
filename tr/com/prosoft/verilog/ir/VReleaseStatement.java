package com.prosoft.verilog.ir;

public class VReleaseStatement extends VStatement {
	
	VReleaseKind releaseKind;

	public VReleaseStatement(VOper expr, VReleaseKind releaseKind) {
		setChildAt(0, expr);
		this.releaseKind = releaseKind;
	}

	@Override
	protected void check(VEnvironment env) {
		env.ensureNetOrVarOrPort(getChild(0));
	}

	@Override
	public VStatementKind getStatementKind() {
		return VStatementKind.RELEASE;
	}

}
