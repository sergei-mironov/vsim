package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.sim.EnumSimValue;
import com.prosoft.vhdl.sim.SimValue;
import com.prosoft.vhdl.sim.StringValue;

public class IRBinaryOper extends IROper {
	
	IROperKind kind;
	String image;
	IRSubProgram sub;
	IRSubprogramSearchContext cnt = new IRSubprogramSearchContext();

	public IRBinaryOper(IROper op1, IROperKind kind, IROper op2, String image) {
		super(op1, op2);
		this.kind = kind;
		this.image = image;
	}
	
	public IRBinaryOper dup() {
		IRBinaryOper res = new IRBinaryOper( getChild(0).dup(), getKind(), getChild(1).dup(), image);
		res.setFull(getFull());
		res.sub = sub;
		res.setType( getType() );
		return res;
	}

	@Override
	public IROperKind getKind() {
		return kind;
	}
	
	// для случаев вроде '0'&std_logic_vector
	protected boolean processEnumLiteralAndArray(IROper op1, IROper op2, IRErrorFactory err) throws CompilerError {
		if( op1 instanceof IRConst && 
				!(op2 instanceof IRConst)  ) {
			op2.setType(getType());
			if( isDefinedType() ) {
				op2.setDefinedType(getDefinedType());
			}
			op2.semanticCheck(err);
			if( op2.getType() != null && isDefinedType() ) {
				op2.setDefinedType(getDefinedType());
			}
			SimValue v = ((IRConst)op1).getConstant();
			if( !(v instanceof StringValue || v instanceof EnumSimValue) ) return false;
//			StringValue sv = (StringValue) v;
			if( v.toString().charAt(0) != '\'' ) return false;
			if( op2.getType().isArray() ) {
				IRArrayIndex ind = IRTypeArray.getIndex(op2.getType(), err, op2);
				op1.setType( ind.getArrayType().getElementType() );
				op1.semanticCheck(err);
				processConcatenation(err);
				if( isDefinedType() ) {
					// as op1 is constant, we can fix the type
					op1.setFixedType(op1.getType());
				}
				if( op1.getFixedType() != null && op2.getFixedType() != null ) {
					setFixedType(getType());
				}
				return true;
			}
		} 
		return false;
	}
	
	protected boolean processPhysicalMulDiv(IROper op1, IROper op2, IRErrorFactory err) throws CompilerError {
		switch( getKind() ) {
		case MUL:
		{
//			if( getType() != null && !getType().isPhysical() ) return false;
//			op1.setType(getType());
			op1.semanticCheck(err);
			if( op1.getType().isPhysical() ) {
				if( getType() != null ) {
//					if( !op1.getType().isSameBase(getType()) ) return false;
				}
				op1.setType(IRTypeInteger.TYPE);
				op2.semanticCheck(err);
				if( op2.getType() == null || !op2.getType().isInt() ) {
					op2.setType(IRTypeReal.TYPE);
					op2.semanticCheck(err);
					if( op2.getType() != null && op2.getType().isReal() ) {
						setType(op1.getType());
						if( op1.getFixedType() != null && op2.getFixedType() != null ) setFixedType(getType());
						return true;
					}
				} else {
					setType(op1.getType());
					if( op1.getFixedType() != null && op2.getFixedType() != null ) setFixedType(getType());
					return true;
				}
			}
			return false;
		}
		case DIV:
		{
			if( getType() == null || getType().isInt() ) {
				// trying [Any physical type] / [The same type] = [Universal integer]
				op1.semanticCheck(err);
				op2.semanticCheck(err);
				IRType t1 = op2.getType(), t2 = op2.getType();
				if( t1 != null && t2 != null && t1.isPhysical() && t1.isSameBase(t2) ) {
					setType(IRTypeInteger.TYPE);
					if( op1.getFixedType() != null && op2.getFixedType() != null ) setFixedType(getType());
					return true;
				}
			}
			if( op1.getType() != null && op2.getType() != null && op1.getType().isPhysical() &&
					(op2.getType().isInt() || op2.getType().isReal()) ) {
				setType(op1.getType());
				return true;
			}
			if( getType() == null || getType().isPhysical() ) {
				if( getType() != null ) {
//					op1.setType(getType());
				}
				op1.semanticCheck(err);
				if( op1.getType() == null || !op1.getType().isPhysical() ) return false;
				if( getType() != null && !op1.getType().isSameBase(op1.getType()) ) return false;
				op2.setType(IRTypeInteger.TYPE);
				op2.semanticCheck(err);
				if( op2.getType() == null || !op2.getType().isInt() ) {
					op2.setType(IRTypeReal.TYPE);
					op2.semanticCheck(err);
					if( op2.getType() != null && op2.getType().isReal() ) {
						setType(op1.getType());
						if( op1.getFixedType() != null && op2.getFixedType() != null ) {
							setFixedType(getType());
						}
						return true;
					}
				} else {
					setType(op1.getType());
					if( op1.getFixedType() != null && op2.getFixedType() != null ) {
						setFixedType(getType());
					}
					return true;
				}
			}
		}
		default:
			return false;
		}
	}
	
	public boolean isStandard() {
        return sub != null ? sub.isStandard() : true;
	}
	
    // a predicate to check whether operation should be
    // placed as ordinary operator.
    public boolean isBooleanCompatible() {
		if (isStandard()) { // either missing definition (error),
			// or in STD package.
			// Operation should be AND, OR, etc.
			switch (getKind()) {
			case AND:
			case OR:
			case NAND:
			case NOR:
			case XOR:
			case XNOR:
				// logical ops require a special treatment for result type.
				break;
			default:
				// all other ops are ok with isStandard() predicate.
				return true;
			}
			IRType type = getType();
			// the type must be enum.
			if (type instanceof IRTypeEnum) {
				IRTypeEnum enTy = (IRTypeEnum) type;
				// and the enum should have exactly two elements.
				// BOOL and BIT satisfy this condition.
				return enTy.getNumValues() == 2;
			}
		}
		// Not a boolean-compatible by any means.
		return false;
	}

	public String getStdString() {
		return IROperatorSymbol.getType('\"' + getImage() + '\"', true).name();
	}

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( getBegin() != null && getBegin().getFile().endsWith("00247.vhd") && getBegin().getLine() == 212 /*&& toString().equals("v_t_phys_1+v_t_phys_1")*/ ) {
			int a = 0;
			a++;
		}
			
		if( isFixedType() ) return;
		
		IROper op1 = getChild(0);
		IROper op2 = getChild(1);
		
		if( getKind() == IROperKind.CONCAT ) {
			if( processEnumLiteralAndArray(op1, op2, err) ) return;
			if( processEnumLiteralAndArray(op2, op1, err) ) return;
		}
		
		switch(getKind()) {
		
		case CONCAT:
		{
			if( processEnumLiteralAndArray(op1, op2, err) ) return;
			if( processEnumLiteralAndArray(op2, op1, err) ) return;
			processConcatenation(err);
			if( getType() != null ) return;
			break;
		}
		
		case GE:
		case GT:
		case LE:
		case LO:
		case EQ:
		case NEQ: {
			if( getBegin().getLine() == 15 ) {
				int a = 0;
				a++;
			}
			setFixedType(err.parser.getBoolean());
			op1.semanticCheck(err);
			op2.semanticCheck(err);
			if( op1.getType() != null && op2.getType() != null ) {
				op1.exchangeTypesWith(op2);
				op1.semanticCheck(err);
				op2.semanticCheck(err);
			}
			
			if( op1.getType() == null && op2.getType() != null ) {
				op1.setType(op2.getType());
				op1.semanticCheck(err);
			} else if( op1.getType() != null && op2.getType() == null ) {
				op2.setType(op1.getType());
				op2.semanticCheck(err);
			} else if( op1.getType() == null && op2.getType() == null ) {
				err.cantInferType(this);
				return;
			}
			if( op1.getType() == null ) {
				int a = 0;
				a++;
			}
			String bt1 = op1.getType() != null ? op1.getType().getBaseTypeName() : "$type1";
			String bt2 = op1.getType() != null ? op2.getType().getBaseTypeName() : "$type2";
			if( bt1.equalsIgnoreCase("ZERO") ) {
				int a = 0;
				a++;
			}
			if( bt1.equalsIgnoreCase(bt2) || (op1.getType() != null && op1.getType().isScalar() && op2.getType() != null && op2.getType().isScalar()) ) {
				cnt.init('\"' + image + '\"', new IROper[]{op1, op2}, getType(), err, this, null, false );
				resolve(cnt);
				if( cnt.getMatched().size() > 1 ) {
					err.ambiguousBinaryOper(this, cnt.getMatched());
					return;
				} else if( cnt.getMatched().size() == 1 ) {
					sub = cnt.getMatched().get(0);
				}
				return;
			}
//			if( op1.getType().isAssignableFrom(op2.getType()) || op2.getType().isAssignableFrom(op1.getType()) && op1.getType().isScalar() && op2.getType().isScalar() ) {
//				return;
//			}
		}
		}
		
		if( getBegin() != null && getBegin().getFile().endsWith("ct00453.vhd") && getBegin().getLine() == 99 ) {
			int a = 0;
			a++;
		}
		
		if( processPhysicalMulDiv(op1, op2, err) || processPhysicalMulDiv(op2, op1, err) ) {
			return;
		}
		
//		if( getKind() == IROperKind.ADD || getKind() == IROperKind.SUB ) {
//			op1.setType(getType()); 
//			op1.semanticCheck(err);
//			op2.setType(getType()); 
//			op2.semanticCheck(err);
//			IRType t1 = op1.getType(), t2 = op2.getType();
//			if( t1 == null || t2 == null ) {
//				return;
//			}
//			if( t1.isInt() && t2.isInt() ) { setType(t1); return; }
//			if( t1.isReal() && t2.isReal() ) { setType(t1); return; }
//			if( t1.isPhysical() && t2.isPhysical() ) { setType(t1); return; }
//		}
		
//		IRSubprogramSearchContext cnt = new IRSubprogramSearchContext('\"' + image + '\"', new IROper[]{op1, op2}, getType(), err );
		int retries = 2;
		while( retries-- > 0 ) {
			cnt.init('\"' + image + '\"', new IROper[]{op1, op2}, getType(), err, this, null, false );
			if( image.equals("**") ) {
				int a = 0;
				a++;
			}
			resolve(cnt);
			if( cnt.matchedFully.size() == 1 ) break;
		}
		if( cnt.getMatched().size() > 1 ) {
			err.ambiguousBinaryOper(this, cnt.getMatched());
			resolve(cnt);
			sub = cnt.getMatched().get(0);
			setType(((IRFunction)sub).getReturnType());
			return;
		} else if( cnt.getMatched().size() == 1 ) {
			sub = cnt.getMatched().get(0);
			setType(((IRFunction)sub).getReturnType());
			op1.setType(sub.getParameters().get(0).getType());
			op1.semanticCheck(err);
			op2.setType(sub.getParameters().get(1).getType());
			op2.semanticCheck(err);
		}
		if( sub == null || !(sub instanceof IRFunction)) {
			err.pushDummyHandler();
			try {
				op1.semanticCheck(err);
				op2.semanticCheck(err);
			} finally {
				err.popDummyHandler();
			}
			if( op1.getType() != null && op2.getType() != null && op1.getType().isPhysical() && op2.getType().isPhysical() ) {
				setType(op1.getType());
				if( op1.isFixedType() && op2.isFixedType() ) {
					setFixedType(op1.getType());
				}
				if( getKind() == IROperKind.ADD || getKind() == IROperKind.SUB ) return;
			}
			err.incompatibleTypes(op1.getType(), op2.getType(), this);
			
			// FIXME delete following lines
			//op2.semanticCheck(err);
			resolve(cnt);
			
		} else {
			IRFunction func = (IRFunction) sub;
			setType(func.getReturnType());
			if( op1.isFixedType() && op2.isFixedType() ) {
				setFixedType(func.getReturnType());
			}
		}
	}
//	@Override
//	public void semanticCheck(IRErrorFactory err) throws CompilerError {
//		if( getBegin() != null && getBegin().getFile().endsWith("arith.vhd") && getBegin().getLine() == 1337 ) {
//			int a = 0;
//			a++;
//		}
//		if( getChild(0) instanceof IRSignalOper && ((IRSignalOper)getChild(0)).getSignal().getName().equalsIgnoreCase("do_mult_reg") ) {
//			int a = 0;
//			a++;
//		}
//		IROper op1 = getChild(0);
//		IROper op2 = getChild(1);
//		
//		if( getKind() == IROperKind.CONCAT ) {
//			if( processEnumLiteralAndArray(op1, op2, err) ) return;
//			if( processEnumLiteralAndArray(op2, op1, err) ) return;
//		}
//		if( getType() != null && getKind() != IROperKind.EQ && getKind() != IROperKind.NEQ ) {
//			op1.setTypeIfNull(getType());
//			op2.setTypeIfNull(getType());
////			if( op1.getType() == null ) getChild(0).setType(getType());
////			if( getChild(1).getType() == null ) getChild(1).setType(getType());
//		}
//		
//		op1.semanticCheck(err);
//		op2.semanticCheck(err);
//		if( getChild(0).getType() == null && getChild(1).getType() != null ) {
//			getChild(0).setType(getChild(1).getType());
//		} else if( getChild(0).getType() != null && getChild(1).getType() == null ) {
//			getChild(1).setType( getChild(0).getType() );
//		}
//		getChild(0).semanticCheck(err);
//		getChild(1).semanticCheck(err);
//		
//		if( kind == IROperKind.CONCAT ) {
//			processConcatenation(err);
//			return;
//		}
//		
//		IRType t1 = getChild(0).getType();
//		IRType t2 = getChild(1).getType();
//		IRSubprogramSearchContext cnt = new IRSubprogramSearchContext('\"' + image + '\"', new IROper[]{op1, op2}, getType(), err );
//		resolve(cnt);
//		if( cnt.getMatched().size() > 1 ) {
//			err.ambiguousBinaryOper(this, cnt.matched);
//			resolve(cnt);
//			sub = cnt.getMatched().get(0);
//			setType(((IRFunction)sub).getReturnType());
//			return;
//		} else if( cnt.getMatched().size() == 1 ) {
//			sub = cnt.getMatched().get(0);
//			setType(((IRFunction)sub).getReturnType());
//			op1.setType(sub.getParameters().get(0).getType());
//			op1.semanticCheck(err);
//			op2.setType(sub.getParameters().get(1).getType());
//			op2.semanticCheck(err);
//		}
////		String name = IRSubProgram.getCanonicalName(getBegin(), '\"' + image + '\"', new IRType[] {t1, t2});
////		sub = (IRSubProgram) resolve(name);//err.parser.getSubProgram( '\"' + image + '\"', new IRType[] {t1, t2} );
//		if( sub == null ) {
//			if( getKind() == IROperKind.EQ || getKind() == IROperKind.NEQ ) {
//				setType( err.parser.getBoolean() );
//				if( t1.isAssignableFrom(t2) || t2.isAssignableFrom(t1) ) {
//					return;
//				} else {
//					err.incompatibleTypes(t1, t2, this);
//					return;
//				}
////				if( t1.isInt() && t2.isInt() ) return;
////				if( t1.isReal() && t2.isReal() ) return;
////				if( t1.isEnum() && t2.isEnum() ) {
////					
////				}
//			} else if( getKind() == IROperKind.GT || getKind() == IROperKind.LO || getKind() == IROperKind.GE || getKind() == IROperKind.LE ) {
//				setType(err.parser.getBoolean());
//				if( t1.isAssignableFrom(t2) || t2.isAssignableFrom(t1) ) {
//					return;
//				}
//			} else if( getKind() == IROperKind.DIV && t1.isPhysical() && t2.isInt() ) {
//				setType(t1);
//				return;
//			}
//			
//			
//			// TODO надо сделать настоящую проверку совместимости типов
//			if( !( (t1.isInt() && t2.isInt()) || (t1.isReal() && t2.isReal() ) || (t1.isEnum() && t2.isEnum() || (t1.isArray() && t2.isArray()) )  ) ) {
//				err.incompatibleTypes(t1, t2, this);
//			}
//		}
//		if( sub != null ) {
//			setType( ((IRFunction)sub).getReturnType() );
//		} else {
//			setType( t1 );
//		}
//	}
	
	private void detectTypes( IRErrorFactory err ) throws CompilerError {
		IROper op1 = getChild(0);
		IROper op2 = getChild(1);
		
		if( isDefinedType() ) {
			if( op1.getKind() == IROperKind.CONCAT ) {
				op1.setDefinedType(getDefinedType());
			}
			if( op2.getKind() == IROperKind.CONCAT ) {
				op2.setDefinedType(getDefinedType());
			}
		}
		
		op1.setType(getType()); op1.semanticCheck(err);
		op2.setType(getType()); op2.semanticCheck(err);
		
		if( op1.getType() == null && op2.getType() != null ) {
			op1.setType(op2.getType());
			op1.semanticCheck(err);
		} else if( op2.getType() == null && op1.getType() != null ) {
			op2.setType(op1.getType());
			op2.semanticCheck(err);
		}
		
	}

	private void processConcatenation(IRErrorFactory err) throws CompilerError {
		err.pushDummyHandler();
		try {
			detectTypes(err);
		} catch( CompilerError e ) {
			err.popDummyHandler();
			throw e;
		}
		err.popDummyHandler();
		
		IROper op1 = getChild(0);
		IROper op2 = getChild(1);
		
		IRType t1 = op1.getType();
		IRType t2 = op2.getType();
		
		if( t1 == null ) {
			//err.cantInferType(op1);
			setType(null);
			return;
		}
		if( t2 == null ) {
//			err.cantInferType(op2);
			setType(null);
			return;
		}
		
		IRType el1 = null, el2 = null;
		IRArrayIndex ind1 = null, ind2 = null;
		if( t1.isArray() ) {
			if( t1 instanceof IRTypeArray ) {
				el1 = ((IRTypeArray)t1).elementType;
				ind1 = ((IRTypeArray)t1).getFirstIndex();
			} else {
				el1 = ((IRArrayIndex)t1).getArrayType().elementType;
				ind1 = ((IRArrayIndex)t1);
			}
		}
		if( t2.isArray() ) {
			if( t2 instanceof IRTypeArray ) {
				el2 = ((IRTypeArray)t2).elementType;
				ind2 = ((IRTypeArray)t2).getFirstIndex();
			} else {
				el2 = ((IRArrayIndex)t2).getArrayType().elementType;
				ind2 = ((IRArrayIndex)t2);
			}
		}
		IRTypeArray parent = null;
		if( getType() != null ) {
			parent = IRTypeArray.getArray(getType(), err, this);
		}
		String t1Name = t1.getBaseTypeName();
		String t2Name = t2.getBaseTypeName();
		if( t1Name.equalsIgnoreCase(t2Name ) && (!t1.isArray() || parent != null) &&
				(parent == null	|| parent.getElementType().getBaseTypeName().equalsIgnoreCase(t1Name) )  ) {//t1.isAssignableFrom(t2) ) {
			elementAndElement(err, op1, op2, parent != null ? parent.getElementType() : null);
		} else if( t1.isArray() && t2.isArray() && IRTypeArray.getArray(t1, err, op1).getElementType().isSameBase(IRTypeArray.getArray(t2, err, op2).getElementType()) ) {//t1Name.equalsIgnoreCase(t2Name) ) {
			arrayAndArray(err, op1, op2, t1, el1, ind1, ind2);
		} else if( t1.isArray() && t2.isAssignableFrom(el1) ) {
			arrayAndElement(err, op1, op2, t1, el1, ind1);
		} else if( t2.isArray() && t1.isAssignableFrom(el2) ) {
			arrayAndElement(err, op2, op1, t2, el2, ind2);
		} else {
//            System.err.println("Can't concat??: " + t1.toString() + " and " + t2.toString() + "(" + t1.getBaseTypeName() + " and " + t2.getBaseTypeName() + ")");
			err.incorrectConcat(op1, op2);
			return;
		}
		if( getKind() != IROperKind.CONCAT && op1.getFixedType() != null && op2.getFixedType() != null ) {
			setFixedType(getType());
		}
	}
	
	private void elementAndElement(IRErrorFactory err, IROper op1, IROper op2, IRType elType) throws CompilerError {
		if( op2.getBegin() != null && op2.getBegin().getFile().endsWith("boothmult.vhd") && op2.getBegin().getLine() > 39 ) {
			int a = 0;
			a++;
		}
		if( elType == null ) {
//			err.incorrectConcat(op1, op2);
			setType(null);
			return;
		}
		String elTypeName = elType.getBaseTypeName();
		String t1 = op1.getType().getBaseTypeName();
		String t2 = op2.getType().getBaseTypeName();
		if( (!t1.equalsIgnoreCase(elTypeName)) || (!t2.equalsIgnoreCase(elTypeName)) ) {
			err.incorrectConcat(op1, op2);
			return;
		}
		IRArrayIndex ind = getIndex(getType());
		if( ind != null && ind.getIndexType().isInt() ) {
			IRTypeArray arrayType = ind.getArrayType().dup();
			IRArrayIndex index = getIndex(arrayType);
			index.getRange().setDownTo(ind.getRange().isDownTo());
			int lowBound = IRConst.getIntFromDescreteConst(err, ((IRTypeInteger)index.getIndexType()).getRange().getRangeLow(), true);
//			int lowBound = ((IRTypeInteger)index.getIndexType()).getActualRangeLow().constant.getIntValue();
			index.getRange().setRangeLow( IRTypeInteger.createConstant(lowBound) );
			index.getRange().setRangeHigh( IRTypeInteger.createConstant(2 + lowBound - 1) ); 
			setType( arrayType );
			if( isDefinedType() && op1.getType() != null ) {
				op1.setFixedType(op1.getType());
			}
			if( isDefinedType() && op2.getType() != null ) {
				op2.setFixedType(op2.getType());
			}
			if( op1.isFixedType() && op2.isFixedType() && isDefinedType() ) {
				setFixedType(getDefinedType());
			}
		} else {
			err.incompatibleTypes(op1.getType(), op2.getType(), this);
		}
	}

	private void arrayAndArray(IRErrorFactory err, IROper a1, IROper a2, IRType arrayType, IRType elType, 
			IRArrayIndex ind1, IRArrayIndex ind2) {
		if( ind1.indexType.isInt() && ind1.indexType.isInt() ) {
//			if( ind1.isDownTo != ind2.isDownTo ) {
//				err.incorrectConcat( a1, a2 );
//				return;
//			}
			arrayType = arrayType.getOriginalType().dup();
			IRArrayIndex index = getIndex(arrayType);
			if( ind1.isDefined() && ind2.isDefined() ) {
				int size1 = ind1.getRangeHighAsInt(err) - ind1.getRangeLowAsInt(err) + 1;
				int size2 = ind2.getRangeHighAsInt(err) - ind2.getRangeLowAsInt(err) + 1;
				index.getRange().setDownTo(ind1.getRange().isDownTo());
				int lowBound = IRConst.getIntFromDescreteConst(err, ((IRTypeInteger)index.getIndexType()).getRange().getRangeLow(), true);
//				int lowBound = ((IRTypeInteger)index.getIndexType()).getActualRangeLow().constant.getIntValue();
				index.getRange().setRangeLow( IRTypeInteger.createConstant(lowBound) );
				index.getRange().setRangeHigh( IRTypeInteger.createConstant(size1 + size2 + lowBound - 1) );
			} else {
				index.getRange().setRangeHigh(null);
				index.getRange().setRangeLow(null);
			}
			setType( arrayType );
		} else {
			throw new RuntimeException();
		}
	}

	private void arrayAndElement( IRErrorFactory err, IROper array, IROper elememt, IRType arrayType, 
			IRType elType, IRArrayIndex ind ) {
		if( ind.getIndexType().isInt() ) {
			if( ind.getRange().getRangeHigh() != null && ind.getRange().getRangeHigh().isConst() && ind.getRange().getRangeHigh() != null && ind.getRange().getRangeLow().isConst() ) {
				int size = ind.getRangeHighAsInt(err) - ind.getRangeLowAsInt(err) + 1;
				arrayType = arrayType.dup();
				IRArrayIndex index = getIndex(arrayType);
				index.getRange().setDownTo(ind.getRange().isDownTo());
				int lowBound = IRConst.getIntFromDescreteConst(err, ((IRTypeInteger)index.getIndexType()).getRange().getRangeLow(), true);
//				int lowBound = ((IRTypeInteger)index.getIndexType()).getActualRangeLow().constant.getIntValue();
				index.getRange().setRangeLow( IRTypeInteger.createConstant(lowBound) );
				index.getRange().setRangeHigh( IRTypeInteger.createConstant(size + lowBound - 1 + 1) ); // + 1 для нового элемента
				setType( arrayType );
				if( isDefinedType() && array.getType() != null ) {
					array.setFixedType(array.getType());
				}
				if( isDefinedType() && elememt.getType() != null ) {
					elememt.setFixedType(elememt.getType());
				}
				if( array.isFixedType() && elememt.isFixedType() ) {
					setFixedType( getType() );
				}
			} else {
				// мы не можем определить диапазон - оставляем неопределенный
				arrayType = arrayType.dup();
				IRArrayIndex index = getIndex(arrayType);
				index.getRange().setRangeHigh(null);
				index.getRange().setRangeLow(null);
				setType( arrayType );
			}
		} else {
			throw new RuntimeException();
		}
	}
	
	private IRArrayIndex getIndex( IRType type ) {
		if( type instanceof IRTypeArray ) {
			return ((IRTypeArray)type).getFirstIndex();
		} else if( type instanceof IRArrayIndex ){
			return (IRArrayIndex) type;
		} else {
			return null;
		}
	}

	public String getImage() {
        switch ( getKind() )
        {
        case AND: return "and";
        case OR: return "or";
        case NAND: return "nand";
        case NOR: return "nor";
        case XOR: return "xor";
        case XNOR: return "xnor";
        case SLL: return "sll";
        case SRL: return "srl";
        case SLA: return "sla";
        case SRA: return "sra";
        case ROL: return "rol";
        case ROR: return "ror";

        default:
            return image;
        }
	}

	public IRSubProgram getSub() {
		return sub;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	@Override
	public boolean isEqualTo(IROper op) {
		if( op.getKind() != kind ) return false;
		if( !op.getChild(0).isEqualTo(getChild(0)) ) return false;
		if( !op.getChild(1).isEqualTo(getChild(1)) ) return false;
		return true;
	}

	public String toString() {
		return getChild(0) + image + getChild(1);
	}
}
