package com.prosoft.verilog.ir;

public class VPort extends VNamedElement {
	
	VType type;
	VModule module;
	Direction dir;

	public VPort(VModule module, String name, VType type, Direction dir) {
		super(name);
		this.module = module;
		this.type = type;
	}

	@Override
	public VEnvironment getEnvironment() {
		return module.getEnvironment();
	}

	@Override
	public VType getType() {
		return type;
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.PORT;
	}

}
