package com.prosoft.verilog.ir;

public class VOperCall extends VOper {
	
	public VOperCall( VOper subprogram ) {
		setChildAt(0, subprogram);
	}
	
	public void addParam( VOper param ) {
		setChildAt(getChildNum(), param);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.CALL;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		throw new RuntimeException();
	}

}
