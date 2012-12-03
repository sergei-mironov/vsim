package com.prosoft.vhdl.ir;

public class IROperAlias extends IROper implements IObjectElement {
	
	IRAlias alias;

	public IROperAlias(IRAlias alias) {
		this.alias = alias;
	}

	public IRAlias getAlias() {
		return alias;
	}

	@Override
	public IROper dup() {
		IROperAlias res = new IROperAlias(alias);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.ALIAS;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !(other instanceof IROperAlias) ) return false;
		return ((IROperAlias)other).alias == alias;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		alias.semanticCheck(err);
		setType(alias.getType());
	}

	public String toString() {
		return alias.getName();
	}

	@Override
	public IRNamedElement getTopmostObject() {
		if( alias.getExpression() instanceof IObjectElement ) {
			return ((IObjectElement)alias.getExpression()).getTopmostObject();
		}
		return null;
	}

	@Override
	public IRObjectClass getObjectClass() {
		if( alias.getExpression() instanceof IObjectElement ) {
			return ((IObjectElement)alias.getExpression()).getObjectClass();
		}
		return null;
	}

	@Override
	public boolean isPrimary() {
		if( alias.getExpression() instanceof IObjectElement ) {
			return ((IObjectElement)alias.getExpression()).isPrimary();
		}
		reportError();
		return false;
	}

	@Override
	public void setPrimary() {
	}

	@Override
	public IRNamedElement getLocalObject() {
		if( alias.getExpression() instanceof IObjectElement ) {
			return ((IObjectElement)alias.getExpression()).getLocalObject();
		}
		return null;
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		if( alias.getExpression() instanceof IObjectElement ) {
			return ((IObjectElement)alias.getExpression()).getTopmostValueableObject();
		}
		return null;
	}
}
