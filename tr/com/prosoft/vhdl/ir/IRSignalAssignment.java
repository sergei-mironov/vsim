package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRSignalAssignment extends IRStatement {

//	IROper signal;
//	IROper waveform;
	
	public IRSignalAssignment(IROper signal, IROper waveform) {
		super();
//		this.signal = signal;
//		this.waveform = waveform;
		setChild(0, signal);
		setChild(1, waveform);
        setBegin(signal.getBegin());
        setEnd(waveform.getEnd());
	}
	
	protected IRSignalAssignment() {}
	
	public IRSignalAssignment dup() {
		return (IRSignalAssignment) new IRSignalAssignment().dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.SIG_ASGN;
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
//		visit(visitor);
		getChild(0).visit(visitor);
		getChild(1).visit(visitor);
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		// TODO Нормальную проверку типов
		getChild(0).semanticCheck(err);
		IRType t1 = getChild(0).getType();
		setType( t1 );
		if( getChild(1).getType() == null ) getChild(1).setType(t1);
		getChild(1).semanticCheck(err);
		IRType t2 = getChild(1).getType();
		if( getChild(0).getType() == null && t2 != null ) {
			getChild(0).setType(t2);
			getChild(0).semanticCheck(err);
			t1 = getChild(0).getType();
		}
		if( t1 == null ) {
			err.cantInferType(getChild(0));
			getChild(0).semanticCheck(err);
		} else if( t2 == null ) {
			err.cantInferType(getChild(1));
		} else if( !(t1.isAssignableFrom( t2 ) || (t1.isDescrete() && t2.isDescrete()) ) ) {
			err.incompatibleTypes( t1, t2, getChild(1) );
		}
		/*
		ArrayList<IROper> written = new ArrayList<IROper>();
		ArrayList<IROper> read = new ArrayList<IROper>();
		getChild(0).getAccessedObjects(written, read, true);
		SignalChecker ch = new SignalChecker(err);
		for( IROper op : written ) {
			op.visit(ch);
		}
		*/
		getChild(0).checkWrite(IRObjectClass.SIGNAL, err);
	}
	
	protected IRSignalAssignment asgn( IROper target, IROper expr, IRErrorFactory err, IRElement parent ) {
		IRSignalAssignment sig = new IRSignalAssignment(target, expr);
		sig.setParent(parent);
		try {
			sig.semanticCheck(err);
		} catch (CompilerError e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sig;
	}
	
	public IRProcess generateProcess( IRArchitecture arch, IRErrorFactory err ) {
		IRProcess res = new IRProcess(null, arch);
        res.setFull(getFull());
		IROper target = getChild(0);
		IROper expr = getChild(1);
		if( expr instanceof IRCondition ) {
			IRCondition cond = (IRCondition) expr;
			IRStatement stat;
			if( cond.conds.get(0) != null ) {
				IRIfStatement ifstat = new IRIfStatement();
                ifstat.setFull(getFull());
				ifstat.setParent(res);
				stat = ifstat;
				ifstat.setIfTree(cond.conds.get(0));
				if( cond.waves.get(0) != null )ifstat.setIfStatement( asgn(target, cond.waves.get(0), err, stat) );
				int i;
				for( i = 1; i < cond.conds.size(); i++ ) {
					if( cond.conds.get(i) != null ) {
						ifstat.addElseIf( cond.conds.get(i), asgn(target, cond.waves.get(i), err, stat) );
					} else {
						if( i != cond.conds.size() - 1 ) { throw new RuntimeException(); }
                        else
                            ifstat.setElseStatement( asgn(target, cond.waves.get(i), err, stat) );
                    }
				}
				/*if( cond.waves.size() == i + 1 && cond.waves.get(i) != null ) {
					ifstat.setElseStatement( asgn(target, cond.waves.get(i), err, stat) );
				}*/
			} else if( cond.waves.size() == 1 ) {
				stat = asgn(target, cond.waves.get(0), err, res);
			} else {
				throw new RuntimeException();
			}
			res.statements.add(stat);
		} else {
			IRSignalAssignment gen = asgn(target, expr, err, res);
			res.statements.add(gen);
		}
		
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

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}
	
	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read) {
		getChild(0).getAccessedObjects(write, read, true);
		getChild(1).getAccessedObjects(write, read, false);
	}
}
