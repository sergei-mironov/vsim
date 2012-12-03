package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRStatements extends IRStatement {
	
	ArrayList<IRStatement> statements = new ArrayList<IRStatement>();
	
	public IRStatements() {}
	
	public IRStatements dup() {
		IRStatements res = new IRStatements();
		res.statements = dupIRStatementArray(statements);
		return res;
	}
	
	public void add( IRStatement stat ) {
		statements.add(stat);
		stat.setParent(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.STATS;
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		for( int i = 0; i < statements.size(); i++ ) {
			statements.get(i).visitStatement(visitor);
		}
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		for( int i = 0; i < statements.size(); i++ ) {
			statements.get(i).semanticCheck(err);
		}
	}

	public IRStatement getStatement(int index) {
		return statements.get(index);
	}
	
	public int getNumStatements() {
		return statements.size();
	}
	
	public void clear() {
		while( statements.size() > 0 )
			statements.remove(0);
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read) {
		for( int i = 0; i < statements.size(); i++ ) {
			statements.get(i).getAccessedObjects(write, read);
		}
	}
}
