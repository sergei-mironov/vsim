package com.prosoft.vhdl.ir;

public class IRVarOper extends IROper implements IRPrimaryReader, IObjectElement {
	
	IRVariable variable;

	public IRVarOper(IRVariable variable) {
		super();
		this.variable = variable;
	}
	
	public IRVarOper dup() {
		return (IRVarOper) new IRVarOper(variable).dupChildrenAndCoordAndType(this);
	}

	public IRVariable getVariable() {
		return variable;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.VAR;
	}

	public String toString() {
		return variable.getName();
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		setFixedType( variable.type );
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public IRPrimary getPrimary() {
		return variable;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !(other instanceof IRVarOper) ) return false;
		return variable == ((IRVarOper)other).getVariable();
	}

	@Override
	public IROper getChild(int index) {
		throw new RuntimeException();
	}

	@Override
	public void setChild(int childIndex, IROper child) {
		throw new RuntimeException();
	}

	@Override
	public IRObjectClass getObjectClass() {
		return IRObjectClass.VARIABLE;
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
	public IRNamedElement getTopmostObject() {
		return (getParent() instanceof IObjectElement) ? ((IObjectElement)getParent()).getTopmostObject() : getLocalObject();
	}

	@Override
	public IRNamedElement getLocalObject() {
		return variable;
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		return variable;
	}
	
}
