package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRWhileStatement extends IRLoopStatement {
	
	public IRWhileStatement(String label) {
		super(label);
	}

	IROper condition;

	public IROper getCondition() {
		return condition;
	}
	
	public IRWhileStatement dup() {
		IRWhileStatement res = new IRWhileStatement(label);
		res.condition = condition.dup();
		res.dupChildrenAndCoordAndType(this);
		res.body = (IRStatement) body.dup();
		return res;
	}

	public void setCondition(IROper condition) {
		this.condition = condition;
		condition.setParent(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.WHILE;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		condition.semanticCheck(err);
		super.semanticCheckInternal(err);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		condition.visit(visitor);
		super.visitStatement(visitor);
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read) {
		condition.getAccessedObjects(write, read, false);
		body.getAccessedObjects(write, read);
	}



}
