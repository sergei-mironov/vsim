package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRConstant extends IRUniqueNamedElement implements IRPrimary {
	
	IRType type;
	IROper value;
	boolean isParameter;
	
	public IRConstant(IRElement parent, String name, IRType type, IROper value) {
		super(parent, name);
		this.type = type;
		this.value = value;
		if( value != null )
			value.setParent(this);
	}

	public IRType getType() {
		return type;
	}

	public IROper getValue() {
		return value;
	}
	
	public void setValue( IROper value ) {
		this.value = value;
	}

	public boolean isParameter() {
		return isParameter;
	}

	public void setParameter(boolean isParameter) {
		this.isParameter = isParameter;
	}

	public String toString() {
		return getName();
	}

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( value != null) {
			if( value.getType() == null ) {
				value.setType(type);
			}
			value.semanticCheck(err);
		}
	}
	
	public void visit( IROperVisitor visitor ) {
		if( value != null )
			value.visit(visitor);
	}

	public void setInit(IROper init) {
		this.value = init;
	}
}
