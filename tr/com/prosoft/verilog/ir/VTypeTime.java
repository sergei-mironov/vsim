package com.prosoft.verilog.ir;

public class VTypeTime extends VType {
	
	public static final VTypeTime TYPE = new VTypeTime();

	public VTypeTime() {
		super("time");
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.TIME;
	}

	@Override
	public long getSize() {
		return 64;
	}

}
