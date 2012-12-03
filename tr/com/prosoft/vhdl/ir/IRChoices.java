package com.prosoft.vhdl.ir;

public class IRChoices extends IROper {

	public IRChoices( IROper[] choices ) {
		for( int i = 0; i < choices.length; i++ ) {
			setChild(i, choices[i]);
		}
	}
	
	protected IRChoices() {}
	
	public IRChoices dup() {
		return (IRChoices) new IRChoices().dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.CHOICES;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		for( int i = 0; i < getChildNum(); i++ ) {
			IROper ch = getChild(i);
			if( ch instanceof IRName ) {
				IRName name = (IRName) ch;
				IROper res = IROper.create( resolve(name.getName()) );
				setChild(i, res);
			} else {
				if( ch.getType() == null ) {
					ch.setType(getType());
				}
				ch.semanticCheck(err);
			}
		}
	}
	
	public void semanticCheckAssoc(IRErrorFactory err, IROper expr) throws CompilerError {
//		IRType parType = getParent().type;
//		IRAggreg aggreg = (IRAggreg) getParent().getParent();
//		if( parType.isArray() ) {
//			IRType elType = ((IRTypeArray)parType).getElementType();
//			if( elType.)
//			int index = 0;
//			for( int i = 0; i < getChildNum(); i++ ) {
//				getChild(i).semanticCheck(err);
//				IROper op = getChild(i);
//				if( op instanceof IROperOthers ) {
//					if( i + 1 != getChildNum() ) {
//						err.othersShouldBeLast();
//					}
//					for( int mi = 0; mi < aggreg.getNumMembers(); mi++ ) {
//						if( aggreg.getMember(mi) == null ) {
//							aggreg.setMember(mi, expr);
//						}
//					}
//				}
//			}
//		}
	}
	
	public boolean isJustOthers() {
		return getChildNum() == 1 && getChild(0) instanceof IROperOthers;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}
	
	public String toString() {
		StringBuffer res = new StringBuffer();
		for( int i = 0; i < getChildNum(); i++ ) {
			res.append(getChild(i).toString());
			if( i + 1 < getChildNum() ) res.append(", ");
		}
		return res.toString();
	}

	@Override
	public boolean isEqualTo(IROper op) {
		return defaultIsEqualTo(op);
	}
}
