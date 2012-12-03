package com.prosoft.vhdl.ir;

public class IRFieldOper extends IROper {
	
	IRRecordField field;

	public IRFieldOper(IRRecordField field) {
		this.field = field;
		setType( field.type );
	}

	@Override
	public IROper dup() {
		IRFieldOper res = new IRFieldOper(field);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.FIELD;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !defaultIsEqualTo(other) ) return false;
		IRFieldOper op = (IRFieldOper) other;
		return field == op.field;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
	}

	public IRRecordField getField() {
		return field;
	}

	public String toString() {
		return field.getName();
	}
}
