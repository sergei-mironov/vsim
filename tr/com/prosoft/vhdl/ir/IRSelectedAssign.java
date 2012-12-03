package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRSelectedAssign extends IRStatement {
	
	IROper expression;
	IROper target;
	
	public IRSelectedAssign(IROper expression, IROper target) {
		this.expression = expression;
		this.target = target;
		expression.setParent(this);
		target.setParent(this);
	}
	
	ArrayList<IROper> waves = new ArrayList<IROper>();
	ArrayList<IROper> choices = new ArrayList<IROper>();
	
	public void add( IROper wave, IROper choice ) {
		waves.add(wave);
		choices.add(choice);
		wave.setParent(this);
		choice.setParent(this);
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		expression.getAccessedObjects(write, read, false);
		target.getAccessedObjects(write, read, true);
		for( int i = 0; i < waves.size(); i++ ) {
			waves.get(i).getAccessedObjects(write, read, false);
			choices.get(i).getAccessedObjects(write, read, false);
		}
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		expression.visit(visitor);
		target.visit(visitor);
		for( int i = 0; i < waves.size(); i++ ) {
			waves.get(i).visit(visitor);
			choices.get(i).visit(visitor);
		}
	}

	@Override
	public IROper dup() {
		IRSelectedAssign res = new IRSelectedAssign(expression.dup(), target.dup());
		res.dupChildrenAndCoordAndType(this);
		for( int i = 0; i < waves.size(); i++ ) {
			res.waves.add( waves.get(i).dup() );
			res.choices.add( choices.get(i).dup() );
		}
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.SELECT_ASGN;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		expression.semanticCheck(err);
		target.semanticCheck(err);
		IRType type = target.getType();
		for( int i = 0; i < waves.size(); i++ ) {
			IROper wave = waves.get(i);
			if( wave.getType() == null ) {
				wave.setType(type);
			}
			wave.semanticCheck(err);
			if( !type.isAssignableFrom(wave.getType()) ) {
				err.incompatibleTypes(type, wave.getType(), wave);
			}
		}
		type = expression.getType();
		for( int i = 0; i < choices.size(); i++ ) {
			IROper ch = choices.get(i);
			if( ch.getType() == null ) {
				ch.setType(type);
			}
			ch.semanticCheck(err);
		}
	}

	public IRProcess generateProcess(IRElement owner, IRErrorFactory err) {
		IRProcess res = new IRProcess(null, owner);
		res.setFull(getFull());
		IRCaseStatement stat = new IRCaseStatement();
        stat.setFull(getFull());
		stat.setExpression(expression);
		
		for( int i = 0; i < waves.size(); i++ ) {
			IROper wave = waves.get(i), choice = choices.get(i);
			IRSignalAssignment asgn = new IRSignalAssignment(target, wave);
            asgn.setFull(wave.getFull());
			stat.addCase(choice, asgn);
		}
		
		res.statements.add(stat);
		
		ArrayList<IROper> write = new ArrayList<IROper>();
		ArrayList<IROper> read = new ArrayList<IROper>();
		res.statements.getAccessedObjects(write, read);
		
		for( int i = 0; i < read.size(); i++ ) {
			IROper op = read.get(i);
			if( op instanceof IObjectElement ) {
				if( ((IObjectElement)op).getObjectClass() == IRObjectClass.SIGNAL )
					res.addToSensivityList(read.get(i));
			}
		}
		
		try {
			res.semanticCheck(err);
		} catch (CompilerError e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		
		return res;
	}

}
