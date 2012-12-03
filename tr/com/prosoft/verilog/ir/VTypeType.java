package com.prosoft.verilog.ir;

public class VTypeType extends VType {

	public VTypeType() {
		super("type_type");
	}

	@Override
	public VType getType() {
		return this;
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.TYPE_TYPE;
	}

	@Override
	public long getSize() {
		throw new RuntimeException();
	}

}
