package com.prosoft.vhdl.ir;

public class IRTypeAccess extends IRType {
	
	IRType targetType;

	public IRTypeAccess(IRPackage pack, String name, IRType targetType) {
		super(pack, name);
		this.targetType = targetType;
	}

	@Override
	public IRType dup() {
		IRTypeAccess res = new IRTypeAccess(getPackage(), getName(), targetType);
		res.setFull(getFull());
		res.setParent(getParent());
		return res;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		return false;
	}

	@Override
	public boolean isEqualTo(IRType type) {
		return false;
	}

	public IRType getTargetType() {
		return targetType;
	}

}
