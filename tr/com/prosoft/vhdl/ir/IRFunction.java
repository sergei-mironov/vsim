package com.prosoft.vhdl.ir;

public class IRFunction extends IRSubProgram implements IRReadableNameGenerator, IUniqueNamedElement {
	
	IRType returnType;

	public IRFunction(IRSubProgramHolder parent, String name) {
		super(parent, name);
	}

	public IRType getReturnType() {
		return returnType;
	}

	public void setReturnType(IRType returnType) {
		this.returnType = returnType;
	}

	@Override
	public boolean isFunction() {
		return true;
	}

	@Override
	public String getReadableName() {
		if( getName().startsWith("\"") ) {
			// это оператор
			boolean isBinary;
			if( getParameters().size() == 1 ) {
				isBinary = false;
			} else if( getParameters().size() == 2 ) {
				isBinary = true;
			} else {
				throw new RuntimeException();
			}
			String args = isBinary ? getParameters().get(0).getType().getName() + "_and_" + getParameters().get(1).getType().getName()
					: getParameters().get(0).getType().toString();
			return IROperatorSymbol.getType(getName(), isBinary) + "_" + args;
		}
		return getName();
	}

	public String toString() {
		StringBuffer res = new StringBuffer(getName() + "( ");
		for( int i = 0; i < parameters.size(); i++ ) {
			res.append( parameters.get(i).getType().getName() );
			if( i + 1 < parameters.size() ) res.append(", ");
		}
		res.append(" )");
		return res.toString();
	}
}
