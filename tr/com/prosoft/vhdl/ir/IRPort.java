package com.prosoft.vhdl.ir;

public class IRPort extends IRSignal {

	IRDirection direction;
	
	public IRPort(IRElement parent, String name, IRType type, IRDirection direction, IROper init) {
		super(parent, name, type, IRSignalKind.NONE, init);
		this.direction = direction;
	}

	public IRType getType() {
		return type;
	}

	public IRDirection getDirection() {
		return direction;
	}
	
	
}
