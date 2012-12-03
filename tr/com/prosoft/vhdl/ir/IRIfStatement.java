package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRIfStatement extends IRStatement {

	IROper ifTree;
	IRStatement ifStatement;
	ArrayList<IROper> elseIfTrees = new ArrayList<IROper>();
	ArrayList<IRStatement> elseIfStatements = new ArrayList<IRStatement>();
	IRStatement elseStatement;
	
	public IRIfStatement dup() {
		IRIfStatement res = new IRIfStatement();
		res.dupChildrenAndCoordAndType(this);
		res.ifTree = ifTree.dup();
		res.ifStatement = (IRStatement) ifStatement.dup();
		res.elseIfTrees = dupIROperArray(elseIfTrees);
		res.elseIfStatements = dupIRStatementArray(elseIfStatements);
		if( elseStatement != null ) res.elseStatement = (IRStatement) elseStatement.dup();
		return res;
	}
	
	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		ifTree.setType(err.parser.getBoolean());
		ifTree.semanticCheck(err);
		ifStatement.semanticCheck(err);
		for( int i = 0; i < elseIfTrees.size(); i++ ) {
			elseIfTrees.get(i).semanticCheck(err);
			elseIfStatements.get(i).semanticCheck(err);
		}
		if( elseStatement != null ) elseStatement.semanticCheck(err);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		ifTree.visit(visitor);
		ifStatement.visitStatement(visitor);
		for( int i = 0; i < elseIfTrees.size(); i++ ) {
			elseIfTrees.get(i).visit(visitor);
			elseIfStatements.get(i).visitStatement(visitor);
		}
		if( elseStatement != null ) elseStatement.visitStatement(visitor);
	}
	
	public void addElseIf( IROper cond, IRStatement statement ) {
		elseIfTrees.add(cond);
		elseIfStatements.add(statement);
		cond.setParent(this);
		statement.setParent(this);
	}
	
	public int getElseIfCount() {
		return elseIfTrees.size();
	}
	
	public IROper getElseIfTree( int index ) {
		return elseIfTrees.get(index);
	}
	
	public IRStatement getElseIfStatement( int index ) {
		return elseIfStatements.get(index);
	}
	
	public IROper getIfTree() {
		return ifTree;
	}


	public void setIfTree(IROper ifTree) {
		this.ifTree = ifTree;
		ifTree.setParent(this);
	}


	public IRStatement getIfStatement() {
		return ifStatement;
	}


	public void setIfStatement(IRStatement ifStatement) {
		this.ifStatement = ifStatement;
		ifStatement.setParent(this);
	}


	public IRStatement getElseStatement() {
		return elseStatement;
	}


	public void setElseStatement(IRStatement elseStatement) {
		this.elseStatement = elseStatement;
		elseStatement.setParent(this);
	}


	@Override
	public IROperKind getKind() {
		return IROperKind.IF;
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write, ArrayList<IROper> read) {
		ifTree.getAccessedObjects(write, read, false);
		ifStatement.getAccessedObjects(write, read);
		for( int i = 0; i < elseIfTrees.size(); i++ ) {
			elseIfTrees.get(i).getAccessedObjects(write, read, false);
			elseIfStatements.get(i).getAccessedObjects(write, read);
		}
		if( elseStatement != null ) elseStatement.getAccessedObjects(write, read);
	}

}
