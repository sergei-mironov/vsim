package com.prosoft.verilog.ir;

public class VOperCast extends VOper {
	
	VType typeToCastTo;
	
	public VOperCast(VType typeToCastTo, VOper expression) {
		super(expression);
		this.typeToCastTo = typeToCastTo;
		setType(typeToCastTo);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.CAST;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		if( env.ensureType(VTypeKind.scalar, getChild(0), false) ) {
		}
		return typeToCastTo;
	}

	public static VOper cast(VEnvironment env, VType t1, VOper child) {
		if( child.getType().getKind().isIntOrVector() && t1.getKind().isIntOrVector() ) {
			long chSize = child.getType().getSize();
			long tSize = t1.getSize();
			if( chSize < tSize ) {
				child = new VOperCast(t1, child);
				child.inferType(env);
				return child;
			} if( chSize == tSize ) {
				return child;
			} else if( (t1.getKind().isIntOrVector() && child.getType().getKind() == VTypeKind.INT) ) {
				return new VOperCast(t1, child);
			} else {
				env.err.sizeIsBigger( t1, child );
				return null;
			}
		} else {
			throw new RuntimeException();
		}
	}

}
