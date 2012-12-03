package com.prosoft.vhdl.ir;

public class IRTypeAny extends IRType {
	
	public static IRTypeAny TYPE;

	public IRTypeAny(IRPackage std) {
		super(std, "$any");
	}

	@Override
	public IRType dup() {
		return this;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		return true;
	}

	@Override
	public boolean isEqualTo(IRType type) {
		return true;
	}

}
