package com.prosoft.vhdl.ir;

public class IRVariable extends IRUniqueNamedElement implements IRPrimary {
	
	IRType type;
	IROper init;
	boolean shared;
	IRDirection direction;
	boolean isParameter;

	public IRVariable(IRVarHolder parent, String name, IRType type, IRDirection direction, IROper init, boolean shared) {
		super((IRElement) parent, name);
		this.type = type;
		this.direction = direction;
		this.init = init;
		if( init != null ) {
			init.setParent(this);
		}
		this.shared = shared;
	}

	public String toString() {
		if( direction != null && direction != IRDirection.NONE ) {
			return getName() + " " + direction + " " + type + (shared ? "shared" : ""); 
		} else {
			return getName() + " " + type + (shared ? "shared" : ""); 
		}
	}

	public IRType getType() {
		return type;
	}

	public IROper getInit() {
		if( getName().equalsIgnoreCase("vzk") ) {
			int a = 0;
			a++;
		}
		return init;
	}

	public boolean isShared() {
		return shared;
	}

	public IRDirection getDirection() {
		return direction;
	}

	public boolean isParameter() {
		return isParameter;
	}

	public void setParameter(boolean isParameter) {
		this.isParameter = isParameter;
	}

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( init != null ) {
			if( init.getType() == null ) {
				init.setType(type);
			}
			try {
				init.semanticCheck(err);
			} catch(CompilerError e){};
		}
	}

	public void setInit(IROper init) {
		this.init = init;
	}
	
}
