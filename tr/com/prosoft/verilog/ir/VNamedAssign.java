package com.prosoft.verilog.ir;

public class VNamedAssign extends VOper {
	
	public VNamedAssign(VName child1, VOper child2) {
		super(child1, child2);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.NAMED_ASSIGN;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		throw new RuntimeException();
	}

}
