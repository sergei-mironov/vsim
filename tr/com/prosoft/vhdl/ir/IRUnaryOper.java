package com.prosoft.vhdl.ir;

public class IRUnaryOper extends IROper {
	
	IROperKind kind;
	IRSubProgram sub;
	
	IRSubprogramSearchContext cnt = new IRSubprogramSearchContext();

	public IRUnaryOper(IROperKind kind, IROper op) {
		super(op);
		this.kind = kind;
	}
	
	protected IRUnaryOper() {}
	
	public IRUnaryOper dup() {
		IRUnaryOper res = (IRUnaryOper) new IRUnaryOper().dupChildrenAndCoordAndType(this);
		res.kind = kind;
		return res;
	}

	@Override
	public IROperKind getKind() {
		return kind;
	}

    public String getImage()
    {
        switch ( getKind() )
        {
            case NOT:
                return "not";
            case ABS:
                return "abs";
            case NEG:
                return "-";
            default:
                return getKind().toString();
        }
    }

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
        IROper op1 = getChild(0);
        op1.setType(getType()); op1.semanticCheck(err);//op1.setTypeIfNullAndSemanticCheck(getType(), err);
		setType( op1.getType() );
		
		if( getBegin() != null && getBegin().getFile().indexOf("boothmult.vhd") >= 0 && getBegin().getLine() > 38 ) {
			int a = 0;
			a++;
		}

//		IRSubprogramSearchContext cnt = new
//            IRSubprogramSearchContext('\"' + getImage() + '\"',
//                                      new IROper[]{op1}, getType(), err );
		cnt.init('\"' + getImage() + '\"',
                                  new IROper[]{op1}, getType(), err, this, null, false );
		resolve(cnt);
		if( cnt.getMatched().size() > 1 ) {
			err.ambiguousUnaryOper(this, cnt.getMatched());
			resolve(cnt);
			sub = cnt.getMatched().get(0);
			setType(((IRFunction)sub).getReturnType());
            // ?????
			return;
		} else if( cnt.getMatched().size() == 1 ) {
			sub = cnt.getMatched().get(0);
			setType(((IRFunction)sub).getReturnType());
			op1.setType(sub.getParameters().get(0).getType());
			op1.semanticCheck(err);
		} else {
			if( !op1.getType().isScalar() )
				err.noSubprogram(getImage(), new IROper[]{op1}, this);
		}
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	public String toString() {
		return kind + "(" + getChild(0) + ")";
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}
    public IRSubProgram getSub() {
		return sub;
	}
	public boolean isStandard() {
        return sub != null ? sub.isStandard() : true;
	}
}
