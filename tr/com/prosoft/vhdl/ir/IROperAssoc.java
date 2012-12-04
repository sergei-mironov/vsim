package com.prosoft.vhdl.ir;

public class IROperAssoc extends IROper {

	public IROperAssoc( IROper target, IROper expr ) {
		setChild(0, target);
		setChild(1, expr);
	}
	
	public IROperAssoc dup() {
		return (IROperAssoc) new IROperAssoc( getChild(0).dup(), getChild(1).dup() ).dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.ASSOC;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		// первый child - IRChoices
		getChild(0).semanticCheck(err);
		getChild(1).semanticCheck(err);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}
	
	public String toString() {
		return /*"ASSOC( " + */getChild(0) + " => " + getChild(1)/* + " );"*/;
	}

	@Override
	public boolean isEqualTo(IROper op) {
		if( op instanceof IROperAssoc ) {
			if( !op.getChild(0).isEqualTo(getChild(0)) ) return false;
			if( !op.getChild(1).isEqualTo(getChild(1)) ) return false;
			return true;
		}
		return false;
	}
}
