package com.prosoft.verilog.ir;

public class VOperUnary extends VOper {
	
	VUnaryKind kind;
	
	public VOperUnary(VUnaryKind kind, VOper child) {
		super(child);
		this.kind = kind;
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.UNARY;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		env.ensureType(VTypeKind.scalar, getChild(0), false);
		switch(kind) {
		case MINUS:
		case PLUS:
		case BNOT:
			return getChild(0).getType();
		case RED_AND:
		case RED_NAND:
		case RED_NOR:
		case RED_OR:
		case RED_XNOR:
		case RED_XOR:
		case LNOT:
			return VTypeVector.singleBit;
		default:
			throw new RuntimeException(kind.getImage());
		}
	}

	public VUnaryKind getUnaryKind() {
		return kind;
	}
}
