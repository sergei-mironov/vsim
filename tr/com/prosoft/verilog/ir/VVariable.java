package com.prosoft.verilog.ir;

public class VVariable extends VNamedElement {

	VType type;
	VOper init;

	public VVariable(String name, VType type, VOper init) {
		super(name);
		this.type = type;
	}

	@Override
	public VType getType() {
		return type;
	}

	@Override
	public VEnvironment getEnvironment() {
		throw new RuntimeException();
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.VARIABLE;
	}

	public VOper getInit() {
		return init;
	}
	
	
}
