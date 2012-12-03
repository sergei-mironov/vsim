package com.prosoft.verilog.ir;

import com.prosoft.verilog.ir.VValue.VValueInteger;

public class VConst extends VOper {
	
	public static final VConst intZero = new VConst(VValue.integer(0));
	
	VValue value;

	public VConst(VValue value) {
		this.value = value;
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.CONST;
	}

	public String toString() {
		return value.toString();
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		return value.type;
	}
	
	public VValue getValue() {
		return value;
	}
	
	public long getIntValue() {
		if( !value.type.isInt() ) throw new RuntimeException(value.toString());
		return ((VValueInteger)value).value;
	}
	
	
	
	
	
	
	
	
	public static VConst getConst( VOper op ) {
		if( op instanceof VConst ) {
			return (VConst) op;
		} else {
			return null;
		}
	}
}
