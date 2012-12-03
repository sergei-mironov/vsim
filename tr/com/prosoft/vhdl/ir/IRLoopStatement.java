package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public abstract class IRLoopStatement extends IRStatement {

	IRStatement body;
	String label;
	
	public IRLoopStatement(String label) {
		this.label = label;
	}

	public String getLabel() {
		return label;
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		body.visitStatement(visitor);
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		body.semanticCheck(err);
	}

	public IRStatement getBody() {
		return body;
	}

	public void setBody(IRStatement body) {
		this.body = body;
		body.setParent(this);
	}
	
}
