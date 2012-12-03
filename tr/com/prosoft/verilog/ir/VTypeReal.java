package com.prosoft.verilog.ir;

public class VTypeReal extends VType {
	
	public static final VTypeReal TYPE = new VTypeReal();

	public VTypeReal() {
		super("real");
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.REAL;
	}

	@Override
	public long getSize() {
		return 64;
	}

}
