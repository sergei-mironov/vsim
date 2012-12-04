package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRCaseStatement extends IRStatement {
	
	IROper expression;
	
	ArrayList<IROper> choices = new ArrayList<IROper>();
	ArrayList<IRStatement> statements = new ArrayList<IRStatement>();
	
	public IRCaseStatement() {}
	
	public IRCaseStatement dup() {
		IRCaseStatement res = new IRCaseStatement();
		res.setFull(getFull());
		res.expression = expression.dup();
		res.choices = new ArrayList<IROper>(choices.size());
		for( int i = 0; i < choices.size(); i++ ) {
			res.choices.set(i, choices.get(i).dup());
		}
		res.statements = new ArrayList<IRStatement>(statements.size());
		for( int i = 0; i < statements.size(); i++ ) {
			res.statements.set(i, (IRStatement) statements.get(i).dup());
		}
		return res;
	}
	
	public void addCase( IROper choices, IRStatement stats ) {
		this.choices.add(choices);
		statements.add(stats);
		choices.setParent(this);
		stats.setParent(this);
	}

	public IROper getExpression() {
		return expression;
	}

	public void setExpression(IROper expression) {
		this.expression = expression;
		expression.setParent(this);
	}
	
	public IROper getChoice(int index) {
		return choices.get(index);
	}
	
	public IRStatement getStatement(int index) {
		return statements.get(index);
	}
	
	public int getNumCases() {
		return choices.size();
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.CASE;
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		expression.visit(visitor);
		for( int i = 0; i < statements.size(); i++ ) {
			statements.get(i).visitStatement(visitor);
		}
		for( int i = 0; i < choices.size(); i++ ) {
			choices.get(i).visit(visitor);
		}
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		expression.semanticCheck(err);
		for( int i = 0; i < statements.size(); i++ ) {
			statements.get(i).semanticCheck(err);
		}
		for( int i = 0; i < choices.size(); i++ ) {
			IROper ch = choices.get(i);
			if( ch.getType() == null ) {
				ch.setType(expression.getType());
			}
			ch.semanticCheck(err);
		}
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		expression.getAccessedObjects(write, read, false);
		for( int i = 0; i < statements.size(); i++ ) {
			statements.get(i).getAccessedObjects(write, read);
		}
		for( int i = 0; i < choices.size(); i++ ) {
			choices.get(i).getAccessedObjects(write, read, false);
		}
	}

}
