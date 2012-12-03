package com.prosoft.vhdl.ir;

public class IRName extends IROper implements IObjectElement {
	
	String name;
	IRNamedElement localObject;
	boolean isPrimary;
	
	public IRName(String name) {
		super();
		this.name = name;
	}
	
	public IRName dup() {
		return (IRName) new IRName(name).dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.NAME;
	}

	public String toString() {
		return name;
	}

	@Override
    public void semanticCheck(IRErrorFactory err) throws CompilerError {
		localObject = resolve(name);
		if( localObject == null ) {
	        err.undefined(getBegin(),"name",name);
	        //System.err.println("error at " + name + " at " + getBegin());
	        throw new CompilerError();
		}
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	public String getName() {
		return name;
	}

	@Override
	public boolean isEqualTo(IROper op) {
		if( op instanceof IRName ) {
			return ((IRName)op).getName().equalsIgnoreCase(name);
		}
		return false;
	}

	@Override
	public IRNamedElement getLocalObject() {
		return localObject;
	}

	@Override
	public IRObjectClass getObjectClass() {
		reportError();
		return null;
	}

	@Override
	public IRNamedElement getTopmostObject() {
		if( isPrimary ) return localObject;
		return ((IObjectElement)getChild(0)).getTopmostObject();
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		if( localObject == null ) reportError();
		if( localObject instanceof IRSignal || localObject instanceof IRVariable || localObject instanceof IRConstant ) return localObject;
		return ((IObjectElement)getChild(0)).getTopmostValueableObject();
	}

	@Override
	public boolean isPrimary() {
		return isPrimary;
	}

	@Override
	public void setPrimary() {
		isPrimary = true;
	}
	
}
