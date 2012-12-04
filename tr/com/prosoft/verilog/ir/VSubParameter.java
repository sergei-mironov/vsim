package com.prosoft.verilog.ir;

public class VSubParameter extends VNamedElement {
	
	Direction dir;
	VType type;
	VEnvironment env;
	VSubProgram owner;
	
	public VSubParameter(VSubProgram owner, String name, Direction dir, VType type) {
		super(name);
		this.dir = dir;
		this.type = type;
		this.owner = owner;
		this.env = new VEnvironment(owner.getEnvironment(), owner.getEnvironment().err);
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.SUB_PARAMETER;
	}

	@Override
	public VEnvironment getEnvironment() {
		return env;
	}

	@Override
	public VType getType() {
		return type;
	}

	public Direction getDir() {
		return dir;
	}

	public VSubProgram getOwner() {
		return owner;
	}

}
