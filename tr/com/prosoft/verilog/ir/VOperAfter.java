package com.prosoft.verilog.ir;

public class VOperAfter extends VOper {
	
	VDelayOrEventControl delay;
	
	public VOperAfter( VDelayOrEventControl delay, VOper value ) {
		this.delay = delay;
		setChildAt(0, value);
	}
	
	public VDelayOrEventControl getDelay() {
		return delay;
	}
	
	public VOper getValue() {
		return getChild(0);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.AFTER;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		getDelay().inferType(env);
		return getValue().inferType(env);
	}

}
