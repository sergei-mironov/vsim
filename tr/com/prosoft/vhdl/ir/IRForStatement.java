package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRForStatement extends IRLoopStatement implements ILocalResolver {
	
	IRLoopVariable loopVariable;
	
	public IRForStatement( String label ) {
		super(label);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		super.visitStatement(visitor);
		loopVariable.visit(visitor);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.FOR;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		super.semanticCheckInternal(err);
		loopVariable.semanticCheck(err);
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return loopVariable.getName().equalsIgnoreCase(name) ? loopVariable : null;
	}

	public IRLoopVariable getLoopVariable() {
		return loopVariable;
	}

	public void setLoopVariable(IRLoopVariable loopVariable) {
		this.loopVariable = loopVariable;
		loopVariable.setParent(this);
	}

	@Override
	public IROper dup() {
		IRForStatement res = new IRForStatement(label);
		res.loopVariable = (IRLoopVariable) loopVariable.dup();
		res.body = (IRStatement) body.dup();
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read) {
		body.getAccessedObjects(write, read);
	}

	public String getLabel() {
		return label;
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return el == loopVariable;
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
	}

}
