package com.prosoft.verilog.ir;

public class VTypeModule extends VType {

	public VTypeModule(VModule module) {
		super(module.getName());
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.MODULE;
	}

	@Override
	public long getSize() {
		throw new RuntimeException();
	}

}
