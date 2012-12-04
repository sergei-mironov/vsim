package com.prosoft.vhdl.ir;

public class IRTypeRange extends IRType {

	public IRTypeRange(IRPackage pack) {
		super(pack, "range");
	}

	@Override
	public IRType dup() {
		return new IRTypeRange(pack);
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		return false;
	}

	@Override
	public boolean isEqualTo(IRType type) {
		return false;
	}

}
