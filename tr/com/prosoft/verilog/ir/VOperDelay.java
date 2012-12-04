package com.prosoft.verilog.ir;

public class VOperDelay extends VOper {
	
	public VOperDelay( VOper arg ) {
		setChildAt(0, arg);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.DELAY;
	}
	
	public VOper getArg() {
		return getChild(0);
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		return getArg().getType();
	}

}
