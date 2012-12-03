package com.prosoft.vhdl.ir;

public class IRTypeCast extends IROper {
	
	IRType typeToCastTo;
	
	public IRTypeCast(IRType type, IROper expr) {
		setType(type.subtypeThunk());//setFixedType(type.subtypeThunk());
		typeToCastTo = getType();
//		setType( type );
//		typeToCastTo = type.subtypeThunk(); // type.dup();
		
        // Делается именно subtypeThunk, т.к. в semanticCheck
        // происходит модификация, и получается тип с именем исходного типа,
        // но с измененным содержимым.
        // Кстати, еще большой вопрос, нужно ли модифицировать этот тип,
        // м.б. в qualify_type стоит указывать тип как есть, а не уточненный по аргументу?
        // пока убрал constrainedSubtype = true, чтобы ограничения диапазонов не выводились
        // все равно не везде они работают.
		setChild(0, expr);
	}
	
	protected IRTypeCast() {}
	
	public IRTypeCast dup() {
		return (IRTypeCast) new IRTypeCast().dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.TYPE_CAST;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !getType().isEqualTo(other.getType()) ) return false;
		return defaultIsEqualTo(other);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( getFixedType() != null ) return;
		IROper op = getChild(0);
		op.semanticCheck(err);
		if( op.getType() == null ) {
//			err.incorrectTypeCast(this);
			return;
		}
		if( op.getType().isArray() ) {
			if( !getTypeToCastTo().isArray() ) {
				err.incorrectTypeCast(this); return;
			}
			if( op.getType() instanceof IRTypeArray && getTypeToCastTo() instanceof IRTypeArray ) {
				IRTypeArray chType = (IRTypeArray) op.getType();
				IRTypeArray myType = (IRTypeArray) getTypeToCastTo();
				// myType = myType.subtypeThunk();// myType.dup();
				myType = myType.dup();
				setType(myType);
				if( !chType.getElementType().getBaseTypeName().equalsIgnoreCase
                    (myType.getElementType().getBaseTypeName()) ) {
					err.incorrectTypeCast(this); return;
				}
				IRArrayIndex[] inds = myType.getIndexes();
				IRArrayIndex[] chInds = chType.getIndexes();
				if( inds.length != chInds.length ) {
					err.incorrectTypeCast(this); return;
				}
				for( int i = 0; i < inds.length; i++ ) {
					inds[i].getRange().assignFrom(chInds[i].getRange());
//					inds[i].getRange().setRangeLow(chInds[i].getRange().getRangeLow());
//					inds[i].getRange().setRangeHigh(chInds[i].getRange().getRangeHigh());
//					inds[i].getRange().setDownTo(chInds[i].getRange().isDownTo());
				}
//                 getType().constrainedSubtype = true;
			} else {
				IRArrayIndex ind = IRTypeArray.getIndex(getTypeToCastTo(), err, op);
				IRArrayIndex chInd = IRTypeArray.getIndex(op.getType(), err, op);
				if( !ind.getArrayType().getElementType().getBaseTypeName().equalsIgnoreCase
                    (chInd.getArrayType().getElementType().getBaseTypeName()) ) {
					err.incorrectTypeCast(this); return;
				}
				ind.getRange().setRangeLow(chInd.getRange().getRangeLow());
				ind.getRange().setRangeHigh(chInd.getRange().getRangeHigh());
				ind.getRange().setDownTo(chInd.getRange().isDownTo());
//                 getTypeToCastTo().constrainedSubtype = true;
			}
		} else if( op.getType().isInt() || op.getType().isReal() || op.getType().isPhysical() ) {
			// TODO implement checkings
		} else if( op.getType().isEnum() ) {
			if( !getTypeToCastTo().isEnum() || !getTypeToCastTo().getBaseTypeName().equalsIgnoreCase(op.getType().getBaseTypeName()) ) { 
				err.incorrectTypeCast(this);
				return;
			}
		} else {
			err.incorrectTypeCast(this);
			return;
		}
		setFixedType(getTypeToCastTo());
	}

	public String toString() {
		return getType() + "(" + getChild(0) + ")";
	}

	public IRType getTypeToCastTo() {
		return typeToCastTo;
	}

	
}
