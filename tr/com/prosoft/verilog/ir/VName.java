package com.prosoft.verilog.ir;

public class VName extends VOper implements IElementOper {
	
	String name;
	VNamedElement element;
	boolean isTop;

	public VName(String name) {
		this.name = name;
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.NAME;
	}

	@Override
	public String toString() {
		return name;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		element = env.resolve(name, true);
		if( element == null ) return null;
		return element.getType();
	}

	public String getName() {
		return name;
	}

	@Override
	public VNamedElement getElement() {
		return element;
	}

	@Override
	public boolean isTop() {
		return isTop;
	}

	@Override
	public void setIsTop(boolean isTop) {
		this.isTop = isTop;
	}

}
