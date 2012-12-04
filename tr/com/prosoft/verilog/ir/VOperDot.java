package com.prosoft.verilog.ir;

public class VOperDot extends VOper implements IElementOper {
	
	VNamedElement element;
	boolean isTop;
	
	public VOperDot(VOper child1, VOper child2) {
		super(child1, child2);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.DOT;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		if( getChild(0).inferType(env) != null ) {
			VNamedElement el = ((IElementOper)getChild(0)).getElement();
			VName name = ((VName)getChild(1));
			this.element = el.getEnvironment().resolve( name.name, true);
			if( this.element != null ) {
				return this.element.getType();
			} else {
				env.err.undefined(name.name);
			}
		}
		return null;
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
