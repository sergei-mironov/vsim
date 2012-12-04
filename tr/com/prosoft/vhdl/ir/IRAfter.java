package com.prosoft.vhdl.ir;

public class IRAfter extends IROper {
	
	public IRAfter( IROper value, IROper time ) {
		setChild(0, value);
		setChild(1, time);
		setBegin(value.getBegin());
		setEnd(time.getEnd());
	}
	
	@Override
	public IROper dup() {
		IRAfter res = new IRAfter(getValue().dup(), getTime().dup());
		res.dupChildrenAndCoordAndType(this);
		return res;
	}
	
	public IROper getValue() {
		return getChild(0);
	}
	
	public IROper getTime() {
		return getChild(1);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.AFTER;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		getTime().setType(err.parser.getTimeType());
		getTime().semanticCheck(err);
		getValue().setTypeIfNull(getType());
		getValue().semanticCheck(err);
		setType(getValue().getType());
	}

}
