package com.prosoft.verilog.ir;

public abstract class VType extends VNamedElement {
	
	static VTypeType type = new VTypeType();
	VType baseType;

	public VType(String name) {
		super(name);
	}

	@Override
	public VType getType() {
		return type;
	}

	@Override
	public VEnvironment getEnvironment() {
		throw new RuntimeException();
	}

	public abstract VTypeKind getKind();
	public abstract long getSize();

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.TYPE;
	}

	public boolean isArray() { return getKind() == VTypeKind.ARRAY; }
	public boolean isVector() { return getKind() == VTypeKind.VECTOR; }
	public boolean isInt() { return getKind() == VTypeKind.INT; }
	public boolean isReal() { return getKind() == VTypeKind.REAL; }

	public boolean isScalar() {
		return getKind() == VTypeKind.INT || getKind() == VTypeKind.REAL || 
			getKind() == VTypeKind.TIME || getKind() == VTypeKind.REALTIME;
	}

	public boolean isType() { return getKind() == VTypeKind.TYPE_TYPE; }

	public VType getSubtypedFrom() {
		return baseType;
	}
	
	public VType getBaseType() {
		VType t = this;
		while( t.getSubtypedFrom() != null ) {
			t = t.getSubtypedFrom();
		}
		return t;
	}

	public String getBaseTypeName() {
		return getBaseType().getName();
	}

	public String getFullName() {
		// TODO Auto-generated method stub
		return getName();
	}
	
	public boolean isUnconstrainedVector() {
		if( this instanceof VTypeVector && ((VTypeVector)this).getRange() == null ) return true;
		return false;
	}
}
