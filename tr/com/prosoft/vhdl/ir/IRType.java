package com.prosoft.vhdl.ir;

public abstract class IRType extends IRNamedElement {

	IRPackage pack;
	IRType subtypedFrom;
	String resolutionFunctionName;
    public boolean constrainedSubtype;
//     public RuntimeException subtypeStack;
//     public RuntimeException dupStack;
    public RuntimeException ctorStack;

	public IRType(IRPackage pack, String name) {
		super(pack, name);
		this.pack = pack;
        this.constrainedSubtype = false;
//        try {throw new RuntimeException();} catch (RuntimeException e) {ctorStack = e;}
//		if( pack == null ) {
//			if( !(this instanceof IRTypeInteger) && !(this instanceof IRTypeReal) && !(this instanceof IRTypeType) && 
//					!(this instanceof IRTypeRange) )
//				System.err.println("No package for type " + name);
//		}
	}

	// возвращает оригинальный тип для подтипов
	public IRType getOriginalType() {
		if( subtypedFrom != null ) {
			return subtypedFrom.getOriginalType();
		} else {
			return this;
		}
	}

    public IRType getSubtypedFrom() { return subtypedFrom; }
    public void setSubtypedFrom(IRType t) { subtypedFrom = t; }
	
	public boolean isInt() { return false; }
	public boolean isReal() { return false; }
	public boolean isEnum() { return false; }
	public boolean isPhysical() { return false; }
	
	public boolean isDescrete() { return isInt() || isEnum(); }

	public boolean isScalar() {	return isInt() || isEnum() || isReal() || isPhysical(); }
	public boolean isString() { return "STD.STANDARD.STRING".equalsIgnoreCase(getFullName()); }
	
	public boolean isRecord() {
		return false;
	}
	
	public boolean isArray() { return false; }
	
	public boolean isStdLogic() { return false; }
	public boolean isType() { return false; }
	
	public abstract IRType dup();
	public abstract boolean isAssignableFrom( IRType type );

    protected void subDup(IRType res)
    {
		//res.subtypedFrom = this;
        res.subtypedFrom = subtypedFrom;
        res.constrainedSubtype = constrainedSubtype;
        res.resolutionFunctionName = resolutionFunctionName;
		res.setFull(getFull());
		res.setParent(getParent());
//         try {throw new RuntimeException();} catch (RuntimeException e) {dupStack = e;}
    }

    public IRType subtypeThunk()
    {
//         try {throw new RuntimeException();} catch (RuntimeException e) {subtypeStack = e;}
        IRType res = dup();
        res.setName(null);
        res.subtypedFrom = this;
        res.constrainedSubtype = false;
        res.resolutionFunctionName = null;
        return res;
    }
	
	public String getBaseTypeName()
    {
        return subtypedFrom != null
            ? subtypedFrom.getBaseTypeName()
            : getFullName();
    }
	
	public boolean isBoolean() {
		return getBaseTypeName().equalsIgnoreCase("std.standard.boolean");
        //		return getName().equalsIgnoreCase("boolean");
	}
	
//	public abstract boolean isEqualTo(IRType type);
	public String toString() {
		return getName();
	}

	public abstract boolean isEqualTo(IRType type);

	public String getResolutionFunctionName() {
		return resolutionFunctionName;
	}

	public void setResolutionFunctionName(String resolutionFunctionName) {
		this.resolutionFunctionName = resolutionFunctionName;
	}
	
	public IRFunction getResolutionFunction(IRErrorFactory err) {
//		if( pack == null ) throw new RuntimeException();
		if( resolutionFunctionName == null ) {
			err.resolutionFunctionUndefined(this);
			return null;
		}
		IRNamedElement res = resolve(resolutionFunctionName);//pack.body.localResolve(resolutionFunctionName);
		if( res == null ) {
			err.undefinedNoThrow(getBegin(), resolutionFunctionName);
			return null;
		}
		if( res instanceof IRFunction ) {
			return (IRFunction) res;
		} else {
			err.functionNameExpected(this, resolutionFunctionName);
			return null;
		}
	}

	public IRPackage getPackage() {
		return pack;
	}

    public void dumpStacks()
    {
//         if ( ctorStack != null )
//         {
//             System.err.println("ctorStack:");
//             ctorStack.printStackTrace();
//         }
//         if ( dupStack != null )
//         {
//             System.err.println("dupStack:");
//             dupStack.printStackTrace();
//         }
//         if ( subtypeStack != null )
//         {
//             System.err.println("subtypeStack:");
//             subtypeStack.printStackTrace();
//         }
    }
	
	public String getFullName() {
        IRElement cur = getParent();
        if( cur == null ) {
            if( this instanceof IRTypeInteger ) return getBaseTypeName();
            if( this instanceof IRTypeReal ) return getBaseTypeName();
            if( this instanceof IRArrayIndex ) return ((IRArrayIndex)this).arrayType.getBaseTypeName();
        	if( this instanceof IRTypeFile ) return "file";
        	if( this instanceof IRTypeAny ) return "$type_any";
            dumpStacks();
            String errPrefix = getBegin() == null
                ? ""
                : "\n" + getBegin().toString() + ": ";
            throw new RuntimeException(errPrefix +
                                       getName() + " " + getClass().getCanonicalName());
        }
        else
        {
            return super.getFullName();
        }
	}

	public boolean isSameBase(IRType type) {
		String t1 = getBaseTypeName();
		String t2 = type.getBaseTypeName();
		return t1.equalsIgnoreCase(t2);
	}

}
