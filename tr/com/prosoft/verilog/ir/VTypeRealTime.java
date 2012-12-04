package com.prosoft.verilog.ir;

public class VTypeRealTime extends VType {
	
	public static final VTypeRealTime TYPE = new VTypeRealTime();

	public VTypeRealTime() {
		super("realtime");
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.REALTIME;
	}

	@Override
	public long getSize() {
		return 64;
	}
}
