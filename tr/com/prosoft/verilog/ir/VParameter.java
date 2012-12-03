package com.prosoft.verilog.ir;

public class VParameter extends VNamedElement {

	VOper expression;
	VEnvironment env;
	VType type;
	
//	public VParameter(VEnvironment env, String name, VOper expression) {
//		super(name);
//		this.expression = expression;
//		this.env = env;
//		env.put(this);
//	}
	
	public VParameter(VEnvironment env, String name, VType type, VOper expression) {
		super(name);
		this.expression = expression;
		this.type = type;
		this.env = env;
		env.put(this);
	}
	

	@Override
	public VEnvironment getEnvironment() {
		return env;
	}

	@Override
	public VType getType() {
		if( type != null && type.isUnconstrainedVector() ) {
			VType exprType = expression.inferType(env);
			if( exprType.isVector() ) {
				type = exprType;
			}
		}
		if( type == null ) type = expression.inferType(env);
		if( type == null ) throw new RuntimeException();
		return type;
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.PARAMETER;
	}

	public VOper getExpression() {
		return expression;
	}

}
