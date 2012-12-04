package com.prosoft.verilog.ir;

public class VTypeSubProgram extends VType {
	
	VSubProgram sub;

	public VTypeSubProgram(VSubProgram sub) {
		super(sub.name);
		this.sub = sub;
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.SUBPROGRAM;
	}

	@Override
	public long getSize() {
		throw new RuntimeException();
	}

}
