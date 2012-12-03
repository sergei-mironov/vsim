package com.prosoft.vhdl.ir;

public class IRDotOper extends IROper implements IObjectElement {
	
	IRNamedElement localObject;
	
	public IRDotOper( IROper op1, IROper op2) {
		super(op1, op2);
        setBegin(op1.getBegin());
        setEnd(op2.getEnd());
	}
	
	protected IRDotOper() {}
	
	public IRDotOper dup() {
		return (IRDotOper) new IRDotOper().dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.DOT;
	}

	public String toString() {
		return getChild(0) + "." + getChild(1);
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		getChild(0).semanticCheck(err);
		IROper left = getChild(0);
		IROper right = getChild(1);
		if( right instanceof IRFieldOper ) {
			IRFieldOper fo = (IRFieldOper) right;
			setType(fo.getField().getType());
			localObject = fo.getField();
			if( getChild(0).getFixedType() != null ) {
				setFixedType(getType());
			}
			return;
		}
		if( left.getType() != null && left.getType().isRecord() && right instanceof IRName ) {
			String fieldName = ((IRName)right).name;
			IRRecordField field = ((IRTypeRecord)left.getType()).getField(fieldName);
			if( field == null ) {
				err.cantGetField(right, left);
			} else {
				setType( field.type );
			}
			IRFieldOper res = new IRFieldOper(field);
			res.setFull(right.getFull());
			if( res.getBegin() == null ) {
				throw new RuntimeException();
			}
			setChild(1, res);
			localObject = field;
		} else if( ((IObjectElement)left).getLocalObject() != null ) {
			IRNamedElement el = ((IObjectElement)left).getLocalObject();
			if( el instanceof ILocalResolver ) {
				localObject = ((ILocalResolver)el).localResolve( ((IRName)right).getName() );
				if( localObject == null ) {
					err.undefined(right.getBegin(), right.toString());
				}
				if( localObject instanceof IRType ) {
					setType((IRType) localObject);
				}
			} else {
				err.unexpected(this);
			}
		} else if( right instanceof IRAll ) {
			err.allDoesntAllowedHere(this);
			setType(left.getType());
		} else {
			err.notRecord(left);
//			throw new CompilerError("Unknown: " + this);
		}
		if( getChild(0).getFixedType() != null ) {
			setFixedType(getType());
		}
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}
	
	boolean isPrimary = false;

	@Override
	public boolean isPrimary() {
		return isPrimary;
	}

	@Override
	public void setPrimary() {
		isPrimary = true;
	}

	@Override
	public IRObjectClass getObjectClass() {
		return ((IObjectElement)getChild(0)).getObjectClass();
	}

	@Override
	public IRNamedElement getTopmostObject() {
		if( isPrimary ) return localObject;
		return ((IObjectElement)getChild(0)).getTopmostObject();
	}

	@Override
	public IRNamedElement getLocalObject() {
		return localObject;
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		if( localObject == null ) reportError();
		if( localObject instanceof IRSignal || localObject instanceof IRVariable || localObject instanceof IRConstant ) return localObject;
		return ((IObjectElement)getChild(0)).getTopmostValueableObject();
	}
}
