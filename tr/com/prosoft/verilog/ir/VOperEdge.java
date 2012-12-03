package com.prosoft.verilog.ir;

public class VOperEdge extends VOper {
	
	boolean isNegative;
	
	public VOperEdge(VOper expr, boolean isNegative) {
		setChildAt(0, expr);
		this.isNegative = isNegative;
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.EDGE;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		env.ensureNet(getChild(0));
		return getChild(0).getType();
	}

	public boolean isNegative() {
		return isNegative;
	}

}
