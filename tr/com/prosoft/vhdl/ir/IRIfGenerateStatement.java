package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRIfGenerateStatement extends IRGenerateStatement {
	
	IROper condition;

	public IRIfGenerateStatement(IROper condition) {
		super();
		this.condition = condition;
		condition.setParent(this);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		super.visitStatement(visitor);
		condition.visit(visitor);
	}
	
	@Override
	public IROper dup() {
		IRIfGenerateStatement res = new IRIfGenerateStatement(condition.dup());
		res.dupChildrenAndCoordAndType(this);
		res.label = label;
		res.processed.statements = dupIRStatementArray(processed.statements);
		res.statements.statements = dupIRStatementArray(statements.statements);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.GEN_IF;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		condition.setParent(this);
		condition.semanticCheck(err);
		super.semanticCheckInternal(err);
	}
	
	@Override
	public void generate(IRErrorFactory err) {
		if( getBegin().getFile().endsWith("sleepctrl.vhd") ) {
			int a = 0;
			a++;
		}
		processed.clear();
		processedConcurent.clear();
		processedComponents.clear();
		if( IRConst.isBooleanTrue(condition, err) ) {
			for( int i = 0; i < statements.getNumStatements(); i++ ) {
				processed.add(statements.getStatement(i));
			}
			processedConcurent.add(concurent);
			for( int i = 0; i < components.size(); i++ ) {
				processedComponents.add(components.get(i));
			}
		}
	}
	

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read) {
		condition.getAccessedObjects(write, read, false);
		this.processed.getAccessedObjects(write, read);
	}

	public IROper getCondition() {
		return condition;
	}

	
}
