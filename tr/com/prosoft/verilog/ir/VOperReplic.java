package com.prosoft.verilog.ir;

public class VOperReplic extends VOper {
	
	public VOperReplic( VOper multiplier, VOper expr ) {
		setChildAt(0, multiplier);
		setChildAt(1, expr);
	}
	
	public VOper getMultiplier() {
		return getChild(0);
	}

	public VOper getExpression() {
		return getChild(1);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.REPLIC;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		if( !env.ensureType(VTypeKind.intAndVector, getMultiplier(), true) ) {
			return null;
		}
		if( !env.ensureType(VTypeKind.vector, getExpression(), false)) {
			return null;
		}
		return new VTypeVector(VOperRange.range(VConst.getConst(getMultiplier()).getIntValue()*getExpression().getType().getSize()-1, 0), false);
	}

}
