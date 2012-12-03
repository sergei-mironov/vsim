package com.prosoft.verilog.ir;

public class VNet extends VNamedElement {
	
	VType type;
	NetType netType;
	VectorScalarity scalarity;
	DriveStrength drive0, drive1;
	ChargeStrength charge;
	VOper init;
	
	public VNet(String name, VType type, NetType netType,
			VectorScalarity scalarity, DriveStrength drive0,
			DriveStrength drive1, ChargeStrength charge, VOper init) {
		super(name);
		this.type = type;
		this.netType = netType;
		this.scalarity = scalarity;
		this.drive0 = drive0;
		this.drive1 = drive1;
		this.charge = charge;
		this.init = init;
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
		return VNamedElementKind.NET;
	}

	public VOper getInit() {
		return init;
	}
	

}
