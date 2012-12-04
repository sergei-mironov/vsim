package com.prosoft.vhdl.ir;

import com.prosoft.common.ICoordinatedElement;

public class IRParameter extends IRNamedElement {
	
	IRType type;
	IRObjectClass objectClass;
	IRDirection direction;
	IROper defaultValue;

	public IRParameter(IRSubProgram parent, String name, IRType type, IRObjectClass objectClass,
                       IRDirection direction, IROper defaultValue, ICoordinatedElement elt) {
		super(parent, name);
		this.type = type;
		this.objectClass = objectClass;
		this.direction = direction;
		this.defaultValue = defaultValue;
        setFull(elt.getFull());
        if( type == null ) {
        	throw new RuntimeException(name);
        }
	}

	public IRType getType() {
		return type;
	}

	public IRObjectClass getObjectClass() {
		return objectClass;
	}

	public IRDirection getDirection() {
		return direction;
	}

	public IROper getDefaultValue() {
		return defaultValue;
	}
	
	public void semanticCheck(IRErrorFactory err) {
		boolean isFunc = ((IRSubProgram)getParent()).isFunction();
		if( isFunc ) {
			if( direction != IRDirection.INPUT ) {
				err.onlyInParamsInFunction(this);
			}
			err.ensureObjectClass(this, objectClass, IRObjectClass.sig_const_file);
		}
	}

	public String toString() {
		if( direction == null || direction == IRDirection.NONE ) {
			return getName() + " : " + type;
		} else {
			return direction + " " + getName() + " : " + type;
		}
	}
}
