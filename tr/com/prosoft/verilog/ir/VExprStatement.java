package com.prosoft.verilog.ir;

public class VExprStatement extends VStatement {
	
	public VExprStatement( VOper expr ) {
		setChildAt(0, expr);
	}
	
	public VOper getExpression() {
		return getChild(0);
	}

	@Override
	protected void check(VEnvironment env) {
		getExpression().inferType(env);
	}

	@Override
	public VStatementKind getStatementKind() {
		return VStatementKind.EXPR;
	}

}
