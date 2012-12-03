package com.prosoft.vhdl.ir;

import java.util.ArrayList;

public class IRCondition extends IROper {

	ArrayList<IROper> waves = new ArrayList<IROper>();
	ArrayList<IROper> conds = new ArrayList<IROper>();
	
	public void add( IROper wave, IROper cond ) {
		waves.add(wave);
		conds.add(cond);
		if( wave != null ) wave.setParent(this);
		if( cond != null ) cond.setParent(this);
	}
	
	public IRCondition dup() {
		IRCondition res = (IRCondition) new IRCondition().dupChildrenAndCoordAndType(this);
		res.waves = dupIROperArray(waves);
		res.conds = dupIROperArray(conds);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.COND;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		IRType t = null;
		for( int i = 0; i < waves.size(); i++ ) {
			IROper wave = waves.get(i);
			if( wave != null ) {
				if( getType() != null && wave.getType() == null ) {
					wave.setType(getType());
				}
				wave.semanticCheck(err);
				IRType wt = wave.getType().getOriginalType();
				if( wt != null ) {
					if( t != null ) {
						if( t.getBaseTypeName().equalsIgnoreCase(wt.getBaseTypeName()) || (wt.isDescrete() && t.isDescrete() ) ) {//t.isAssignableFrom(wt) ) {
							
						} else if( wt.isAssignableFrom(t) ) {
							t = wt;
						} else {
							err.incompatibleTypes(t, wt, this);
						}
					} else {
						t = wt;
					}
				}
			}
		}
		if( t != null ) {
			setType(t);
		}
		IRTypeEnum bool = err.parser.getBoolean();
		for( int i = 0; i < conds.size(); i++ ) {
			IROper cond = conds.get(i);
			if( cond != null ) {
				if( cond.getType() == null ) {
					cond.setType(bool);
				}
				cond.semanticCheck(err);
				if( !cond.getType().isBoolean() ) {
					err.booleanExpected(cond);
				}
			}
		}
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public boolean isEqualTo(IROper op) {
		return defaultIsEqualTo(op);
	}
}
