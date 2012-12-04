package com.prosoft.vhdl.ir;

public class IRSignal extends IRFullNamedElement implements IRPrimary {
	
	IRType type;
	IRSignalKind kind;
	IROper init;
	
	IRSignal[] children;
	
	boolean isParameter;

	public IRSignal(IRElement parent, String name, IRType type, IRSignalKind kind, IROper init) {
		super(parent, name);
		if( parent == null ) {
			int a = 0;
			a++;
		}
		if( name != null && name.equalsIgnoreCase("sboolean1") ) {
			int a = 0;
			a++;
		}
		this.type = type;
		this.kind = kind;
		this.init = init;
		if( init != null ) {
			init.setParent(this);
		}
//		generateChilden();
	}

	public IRType getType() {
		return type;
	}

	public IRSignalKind getKind() {
		return kind;
	}

	public IROper getInit() {
		return init;
	}

	public IRSignal[] getChildren() {
		return children;
	}


//	protected void generateChilden() {
//		if( type.isRecord() ) {
//			IRTypeRecord rec = (IRTypeRecord) type;
//			children = new IRSignal[rec.fields.size()];
//			for( int i = 0; i < rec.fields.size(); i++ ) {
//				IRRecordField f = rec.fields.get(i);
//				children[i] = new IRSignal(f.getName(), f.getType(), kind, null);
//				children[i].parent = this;
//			}
//		} else if( type.isArray() ) {
//			IRTypeArray arr = (IRTypeArray) type;
//			int size = arr.rangeHigh.getIntValue()-arr.rangeLow.getIntValue() + 1;
//			children = new IRSignal[size];
//			for( int i = 0; i < size; i++ ) {
//				children[i] = new IRSignal(Integer.toString(i + arr.rangeLow.getIntValue()), arr.getElementType(), kind, null );
//				children[i].parent = this;
//			}
//		} else {
//			children = new IRSignal[0];
//		}
//	}
//	
	
	
	public String toString() {
		return "Signal " + getName() + " : " + type.getName(); 
	}

	public boolean isParameter() {
		return isParameter;
	}

	public void setParameter(boolean isParameter) {
		this.isParameter = isParameter;
	}

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( init != null ) {
			if( init.getType() == null ) {
				init.setType( type );
			}
			init.semanticCheck(err);
		}
	}
}
