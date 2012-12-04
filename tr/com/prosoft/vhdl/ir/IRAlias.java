package com.prosoft.vhdl.ir;

public class IRAlias extends IRNamedElement {
	
	IRType type;
	IROper expression;
	
	public IRAlias(IRElement parent, String name, IRType type, IROper expression) {
		super(parent, name);
		this.type = type;
		this.expression = expression;
		expression.setParent( this );
	}

	public IRType getType() {
		return type;
	}

	public IROper getExpression() {
		return expression;
	}

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		expression.semanticCheck(err);
		if( !type.isAssignableFrom(expression.getType()) ) {
			err.incompatibleTypes(type, expression.getType(), expression);
		}
	}
}
