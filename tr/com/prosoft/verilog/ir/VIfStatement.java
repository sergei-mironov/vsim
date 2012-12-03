package com.prosoft.verilog.ir;

public class VIfStatement extends VStatement {
	
	// child 0 - expression
	// child 1 - if statements
	// child 2 - else statements
	
	public VIfStatement( VOper expr, VStatement ifTree, VStatement elseTree ) {
		setChildAt(0, expr);
		setChildAt(1, ifTree);
		setChildAt(2, elseTree);
	}

	@Override
	protected void check(VEnvironment env) {
		env.ensureType(VTypeKind.scalar, getChild(0), false);
		((VStatement)getChild(1)).check(env);
		((VStatement)getChild(2)).check(env);
	}

	@Override
	public VStatementKind getStatementKind() {
		return VStatementKind.IF;
	}

	public VOper getExpression() {
		return getChild(0);
	}
	
	public VStatement getIfTree() {
		return (VStatement) getChild(1);
	}
	
	public VStatement getElseTree() {
		return (VStatement) getChild(2);
	}
}
