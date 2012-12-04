package com.prosoft.vhdl.ir;

public class IRConstRead extends IROper implements IRPrimaryReader, IObjectElement {
	
	IRConstant constant;

	public IRConstRead(IRConstant constant) {
		super();
		this.constant = constant;
		setFixedType(constant.getType());
	}
	
	public IRConstRead dup() {
		IRConstRead res = new IRConstRead(constant);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.CONST_READ;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		setFixedType( constant.type );
	}

	@Override
	public IRPrimary getPrimary() {
		return constant;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !defaultIsEqualTo(other) ) return false;
		if( constant != ((IRConstRead)other).constant ) return false;
		return true;
	}

	public IRConstant getConstant() {
		return constant;
	}

	public String toString() {
		return constant.toString();
	}
	
	boolean isPrimary = false;

	@Override
	public boolean isPrimary() {
		return isPrimary;
	}

	@Override
	public void setPrimary() {
		isPrimary = true;
	}

	@Override
	public IRObjectClass getObjectClass() {
		return IRObjectClass.CONSTANT;
	}

	@Override
	public IRNamedElement getTopmostObject() {
		return (getParent() instanceof IObjectElement) ? ((IObjectElement)getParent()).getTopmostObject() : getLocalObject();
	}

	@Override
	public IRNamedElement getLocalObject() {
		return constant;
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		return constant;
	}
	
}
