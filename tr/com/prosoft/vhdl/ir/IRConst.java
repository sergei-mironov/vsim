package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.sim.ArrayValue;
import com.prosoft.vhdl.sim.IntValue;
import com.prosoft.vhdl.sim.RealValue;
import com.prosoft.vhdl.sim.RecordValue;
import com.prosoft.vhdl.sim.SimValue;
import com.prosoft.vhdl.sim.StringValue;

public class IRConst extends IROper {
	
	SimValue constant;
	SimValue resolvedConstant;
//	IRType type;

	public IRConst(IRType type, SimValue constant) {
		super();
		this.setType(type);
		this.constant = constant;
	}

	public IRConst(SimValue constant) {
		super();
		setType( constant.getType() );
		this.constant = constant;
	}
	
	public IRConst dup() {
		IRConst res = new IRConst(getType(), constant);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	public SimValue getConstant() {
		if( resolvedConstant != null ) return resolvedConstant;
		return constant;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.CONST;
	}
	
//	public IRType getType() {
//		return type;
//	}
	
	@Override
	public boolean isConst() {
		return true;
	}
	
	private static IREnumValue getBooleanValue( IROper op, IRErrorFactory err ) {
		IRConst cnst = getConstantValue(op, err);
		if( cnst == null ) return null;
		if( !cnst.getType().isEnum() ) return null;
		if( !cnst.getType().getName().equalsIgnoreCase("BOOLEAN") ) return null;
		return cnst.getConstant().getEnumValue();
	}
	
	public static boolean isBooleanTrue( IROper op, IRErrorFactory err ) {
		IREnumValue v = getBooleanValue(op, err);
		if( v == null ) {
			if( err != null ) {
				err.booleanExpected(op);
			}
			v = getBooleanValue(op, err);
			return false;
		}
		return v.getValue() == 1;
	}

	public static int getIntFromDescreteConst( IRErrorFactory err, IROper source, boolean generateError ) {
		IROper op = getConstantValue(source, err, true);
		if( op == null ) op = source;
		if( !(op instanceof IRConst) ) {
			if( generateError ) err.discreteConstantExpected(op);
			IROper tmp = getConstantValue(source, err, true);
			return 1;
		}
		IRConst cnst = (IRConst) op;
		if( op.getType().isInt() ) {
			return cnst.getConstant().getIntValue();
		} else if( op.getType().isEnum() ) {
			return cnst.getConstant().getEnumValue().getValue();
		} else {
			if( generateError ) err.discreteConstantExpected(op);
			return 1;
		}
	}

	protected static ArrayValue createStringConst( IRErrorFactory err, String str, IRTypeEnum elType, IRArrayIndex index, IROper op ) throws CompilerError {
		str = str.substring(1, str.length()-1);
		if( str.indexOf("ARGUMENT DETECTED") >= 0 || str.indexOf("argument detected") >= 0 ) {
			int a = 0;
			a++;
		}
		SimValue[] arr = new SimValue[str.length()];
		for( int i = 0; i < str.length(); i++ ) {
			IREnumValue en = elType.getValue("\'" + str.charAt(i) + "\'");
			if( en == null ) {
				int a = 0;
				a++;
			}
			if( !elType.isAssignableFrom(en.getRangeType()) ) {
				err.incompatibleTypes(elType, en.getRangeType(), op);
			}
			/*arr[arr.length-i-1]*/arr[i] = en.getSimValue().getConstant();
		}
//		IRTypeArray arType = new IRTypeArray("_array_of_" + elType.getName(), elType);
		index = index.dup();
		if( index.getIndexType().isInt() ) {
			IROper lowOp = ((IRTypeInteger)index.getIndexType()).getRange().getRangeLow();
			if( lowOp instanceof IRConst ) {
				int low = ((IRConst)lowOp).getConstant().getIntValue();
				index.getRange().setRangeLow( IRTypeInteger.createConstant(low) );
				index.getRange().setRangeHigh( IRTypeInteger.createConstant(str.length()+low-1) );
			} else {
				err.constantExpressionRequired(lowOp);
			}
		} else if( index.getIndexType().isEnum() ) {
			IRTypeEnum typeEnum = (IRTypeEnum) index.getIndexType();
			IREnumValue low = typeEnum.getValue(0);
			IREnumValue high = typeEnum.getValue(str.length()-1);
			index.getRange().setRangeHigh(high.getSimValue());
			index.getRange().setRangeLow(low.getSimValue());
		} else {
			// TODO --
			throw new RuntimeException("TODO");
		}
		return new ArrayValue(index, arr, elType);
	}
	
	protected static String convertBitString( IRErrorFactory err, String str, IROper relatedOper ) {
		str = str.toLowerCase();
		int radix;
		int elLen;
		switch( str.charAt(0) ) {
		case 'b':
			radix = 2; elLen = 1; break;
		case 'o':
			radix = 8; elLen = 3; break;
		case 'x':
			radix = 16; elLen = 4; break;
		default:
			err.invalidBitString( str, relatedOper );
			return "";
		}
		
		StringBuffer buf = new StringBuffer(str);
		int ind;
		while( (ind = buf.lastIndexOf("_") ) >= 0 ) {
			buf.delete( ind, ind+1 );
		}
		
		str = str.substring( 2, str.length() - 1 );
		
		String res = "\"";
		for( int i = 0; i < str.length(); i++ ) {
			char c = str.charAt(i);
			int v;
			if( c >= '0' && c <= '9' ) {
				v = c - '0';
			} else if( c >= 'a' && c <= 'f' ) {
				v = c - 'a' + 10;
			} else {
				err.invalidBitString( str, relatedOper );
				return "";
			}
			if( v >= radix ) {
				err.invalidBitString( str, relatedOper );
				return "";
			}
			String cur = Integer.toBinaryString(v);
			while( cur.length() < elLen ) {
				cur = '0' + cur;
			}
			res += cur;
		}
		
		return res + "\"";
	}
	
	public static IRConst getConstantValue( IROper oper, IRErrorFactory err ) {
		return getConstantValue( oper, err, false );
	}
	
	public static IRConst getConstantValue( IROper oper, IRErrorFactory err, boolean isDeclaration ) {
		if( oper instanceof IRConst ) return (IRConst) oper;
		if( oper instanceof IRConstRead ) {
			IRConstRead op = (IRConstRead) oper;
			return getConstantValue(op.constant.value, err, isDeclaration);
		}
		// initial value of variable CANNOT be interpreted as it's constant value
//		if( oper instanceof IRVarOper && isDeclaration ) {
//			IRVarOper op = (IRVarOper) oper;
//			if( op.variable.init instanceof IRConst ) {
//				return (IRConst) op.variable.init;
//			} else
//				return null;
//		}
		if( oper instanceof IRBinaryOper ) {
			IRConst l = getConstantValue(oper.getChild(0), err, isDeclaration);
			IRConst r = getConstantValue(oper.getChild(1), err, isDeclaration);
			if( l == null || r == null ) return null;
			if( l.getType().isInt() && r.getType().isInt() ) {
				int lv = l.getConstant().getIntValue();
				int rv = r.getConstant().getIntValue();
				int res = 0xCC;
				boolean isBoolean = false;
				switch( oper.getKind() ) {
				case ADD:
					res = lv + rv; break;
				case SUB:
					res = lv - rv; break;
				case MUL:
					res = lv * rv; break;
				case DIV:
					res = lv / rv; break;
				case MOD:
					res = lv / rv; break;
				case REM:
					res = lv % rv; break;
				case EQ:
					res = lv == rv ?1:0; isBoolean = true; break;
				case NEQ:
					res = lv != rv ?1:0; isBoolean = true; break;
				case GT:
					res = lv > rv ?1:0; isBoolean = true; break;
				case LO:
					res = lv < rv ?1:0; isBoolean = true; break;
				case GE:
					res = lv >= rv ?1:0; isBoolean = true; break;
				case LE:
					res = lv <= rv ?1:0; isBoolean = true; break;
				case POW:
					res = (int) Math.pow(lv, rv); break;
				default:
					throw new RuntimeException(oper.getKind().toString());
				}
				if( isBoolean ) {
					IRTypeEnum type = err.parser.getBoolean();
					IREnumValue en = type.getValue(res);
					IRConst cnst = en.getSimValue();
					return cnst;
				} else {
					IRTypeInteger type = new IRTypeInteger(l.getType().pack, "integer");
					IntValue v = new IntValue(type, res);
					IRConst cnst = new IRConst(v);
					type.getRange().setRangeHigh( cnst );
					type.getRange().setRangeLow( cnst );
					return new IRConst(l.getType(), v );
				}
			} else if( l.getType().isBoolean() && r.getType().isBoolean() ) {
				boolean lv = l.getBooleanValue(), rv = r.getBooleanValue(), res;
				int lvi = l.getBooleanValue() ? 1 : 0; int rvi = r.getBooleanValue() ? 1 : 0;
				switch( oper.getKind() ) {
				case AND: res = lv & rv; break;
				case OR: res = lv | rv; break;
				case XOR: res = lv ^ rv; break;
				case XNOR: res = !(lv ^ rv); break;
				case EQ: res = lv == rv; break;
				case NEQ: res = lv != rv; break;
				case NAND: res = !(lv & rv); break;
				case NOR: res = !(lv | rv); break;
				case LO: res = lvi < rvi; break;
				case LE: res = lvi <= rvi; break;
				case GT: res = lvi > rvi; break;
				case GE: res = lvi < rvi; break;
				case CONCAT: {
					SimValue[] vals = new SimValue[]{err.parser.getBooleanConst(lv).constant, err.parser.getBooleanConst(rv).constant};
					return new IRConst(new ArrayValue(oper.getType(), vals, IRTypeArray.getArray(oper.getType(), err, oper).getElementType() ));
				}
				default: throw new RuntimeException(oper.toString());
				}
				return err.parser.getBooleanConst(res);
			} else if( oper.getKind() == IROperKind.EQ || oper.getKind() == IROperKind.NEQ ) {
				if( l.getType().isAssignableFrom(r.getType()) || r.getType().isAssignableFrom(l.getType()) ) {
					boolean isEq = l.isEqualTo(r);
					if( oper.getKind() == IROperKind.NEQ ) isEq = !isEq;
					return err.parser.getBooleanConst(isEq);
				}
			} else if( l.getType().isString() && r.getType().isString() ) {
				switch( oper.getKind() ) {
				case CONCAT:
					ArrayValue lv = (ArrayValue) l.getConstant(), rv = (ArrayValue) r.getConstant();
					int size = lv.getNumComponents() + rv.getNumComponents();
					SimValue[] res = new SimValue[size];
					for( int i = 0; i < lv.getNumComponents(); i++ ) {
						res[i] = lv.getComponent(i);
					}
					for( int i = 0; i < rv.getNumComponents(); i++ ) {
						res[i+lv.getNumComponents()] = rv.getComponent(i);
					}
					IRTypeArray str = err.parser.getStringType();
					IRArrayIndex ind = new IRArrayIndex(str.getPackage(), "ind", 
							IRTypeInteger.createConstant(0), err.parser.getBooleanConst(false), IRTypeInteger.createConstant(size-1), 
							IRTypeInteger.TYPE );
					return new IRConst(new ArrayValue(ind, res, IRTypeArray.getArray(l.getType(), err, oper.getChild(0)) ));
				}
			}
		}
		if( oper instanceof IRUnaryOper ) {
			int a = 0;
			IRConst att = getConstantValue(oper.getChild(0), err, isDeclaration);
			if( att == null ) return null;
			if( att.getType().isInt() ) {
				int v = att.getConstant().getIntValue();
				int res;
				switch( oper.getKind() ) {
				case NEG:
					res = -v; break;
				case ABS:
					res = Math.abs(v); break;
				case NOT:
				default:
					throw new RuntimeException();
				}
				IRTypeInteger type = new IRTypeInteger(att.getType().pack, "integer");
				IntValue vres = new IntValue(type, res);
				IRConst cnst = new IRConst(vres);
				type.getRange().setRangeHigh(cnst);
				type.getRange().setRangeLow(cnst);
				return new IRConst(type, vres);
			} else if( att.getType().isReal() ) { 
				double v = att.getConstant().getDoubleValue();
				double res;
				switch( oper.getKind() ) {
				case NEG:
					res = -v; break;
				case ABS:
					res = Math.abs(v); break;
				default:
					throw new RuntimeException();
				}
				IRTypeReal type = new IRTypeReal(att.getType().pack, "real");
				RealValue vres = new RealValue(type, res);
				IRConst cnst = new IRConst(vres);
				type.getRange().setRangeHigh(cnst);
				type.getRange().setRangeLow(cnst);
				return new IRConst(type, vres);
			} else if( att.getType().isBoolean() ) {
				boolean v = att.getConstant().getBoolean();
				switch( oper.getKind() ) {
				case NOT:
					v = !v; break;
					
				default:
					throw new RuntimeException(oper.getKind().name());
				}
				return err.parser.getBooleanConst(v);
			}
		}
		if( oper instanceof IRAttrib ) {
			IRAttrib attrib = (IRAttrib) oper;
			if( attrib.getValue() instanceof IRConst )
				return (IRConst) attrib.getValue();
			else
				return null;
		}
		if( oper instanceof IRAggreg ) {
			IRAggreg agg = (IRAggreg) oper;
			// это просто выражение в скобках?
			if( agg.getChildNum() == 1 && !(agg.getChild(0) instanceof IROperAssoc) ) {
				return getConstantValue(agg.getChild(0), err, isDeclaration);
			} else if( agg.getType().isArray() ) {
				SimValue[] vals = new SimValue[agg.getNumMembers()];
				for( int i = 0; i < agg.getNumMembers(); i++ ) {
					IRConst c = getConstantValue(agg.getMemberValue(i), err);
					vals[i] = c.getConstant();
				}
				ArrayValue v = new ArrayValue(agg.getType(), vals, IRTypeArray.getArray(agg.getType(), err, agg).getElementType() );
				return new IRConst(v);
				//throw new RuntimeException();
			} else if( agg.getType().isRecord() ) {
				SimValue[] vals = new SimValue[agg.getNumMembers()];
				for( int i = 0; i < agg.getNumMembers(); i++ ) {
					IRConst c = getConstantValue(agg.getMemberValue(i), err);
					vals[i] = c.getConstant();
				}
				RecordValue v = new RecordValue(vals, (IRTypeRecord)agg.getType());
				return new IRConst(v);
			} else {
				agg.reportError();
			}
		}
//		if( oper instanceof IRAggreg ) {
//			if( oper.getType().isArray() ) {
//				IROper[] ops = ((IRAggreg)oper).members.toArray( new IROper[((IRAggreg)oper).members.size()]);
//				SimValue[] vals = new SimValue[ops.length];
//				for( int i = 0; i < ops.length; i++ ) {
//					vals[i] = getConstantValue(ops[i], err, isDeclaration).getConstant();
//					if( vals[i] == null ) throw new RuntimeException();
//				}
//				IRType elType;
//				if( oper.getType() instanceof IRTypeArray ) {
//					elType = ((IRTypeArray)oper.getType()).getElementType();
//				} else {
//					elType = ((IRArrayIndex)oper.getType()).getArrayType().getElementType();
//				}
//				SimValue v = new ArrayValue(oper.getType(), vals, elType);
//				return new IRConst( v.getType(), v );
//			}
//		}
		return null;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( constant != null && constant.toString().equalsIgnoreCase("\"0\"") ) {
			int a = 0;
			a++;
		}
		if( constant instanceof StringValue ) {
			StringValue str = (StringValue) constant;
			String processed = str.getValue().toLowerCase();
			char c = processed.charAt(0);
			if( c == 'b' || c == 'o' || c == 'x' ) {
				processed = convertBitString(err, processed, this);
			} else {
				processed = str.getValue();
			}
			if( processed.startsWith("\"") ) {
				IRArrayIndex ind;
				IRTypeEnum elType;
				if( getType() instanceof IRTypeArray ) {
					IRTypeArray arr = ((IRTypeArray)getType());
					if( arr == null ) return;
					ind = arr.getFirstIndex();
					elType = (IRTypeEnum) arr.getElementType();
				} else {
					if( getType() != null && !(getType() instanceof IRArrayIndex) ) {
						err.arrayExpected(this);
						setType(null);
						return;
					}
					ind = (IRArrayIndex) getType();
					if( ind == null ) return;
					elType = (IRTypeEnum) ind.getArrayType().getElementType();
				}
				resolvedConstant = createStringConst(err, processed, elType, ind, this);
			} else {
				if( str.getValue().length() == 3 && str.getValue().charAt(0) == '\'' && str.getValue().charAt(2) == '\'' ) {
					// это литерал типа '1'
					if( getType() != null ) {
						if( getType().isArray() && getParentOper() != null && getParentOper().getKind() == IROperKind.CONCAT ) {
							IRTypeArray arr = IRTypeArray.getArray(getType(), err, this);
							if( !(arr.getElementType() instanceof IRTypeEnum) ) {
								err.cantInferType(this);
								return;
							}
						} else if( !(getType() instanceof IRTypeEnum) ) {
							setType(null);//err.cantInferType(this);
							return;
						}
					} else {
						// TODO Check if enum names is ambiguos
						IRNamedElement el = resolve(str.getValue());
						if( el == null ) {
							err.undefined(getBegin(), str.getValue());
						} else {
							if( el instanceof IREnumValue ) {
								resolvedConstant = ((IREnumValue)el).simValue.constant;
							} else {
								reportError();
							}
						}
					}
				}
				if( getType() instanceof IRTypeEnum ) {
					IRTypeEnum en = (IRTypeEnum) getType();
					if( en == null ) return;
					IREnumValue v = en.getValue(str.getValue());
					if( v == null ) {
						err.undefined(getBegin(), str.getValue());
					} else {
						resolvedConstant = v.getSimValue().getConstant();
					}
				} else {
					// эта константа должна стать частью массива в выражении типа '0'&array или '0'&'1'
					if( getParentOper() != null && getParentOper().getKind() == IROperKind.CONCAT 
							&& getType() != null && getType().isArray() ) {
						IRTypeArray arr = IRTypeArray.getArray(getType(), err, this);
						IRTypeEnum en = (IRTypeEnum) arr.getElementType();
						IREnumValue v = en.getValue(str.getValue());
						if( v == null ) {
							err.undefined(getBegin(), str.getValue());
						} else {
							resolvedConstant = v.getSimValue().getConstant();
						}
					}
				}
			}
		}
		if( resolvedConstant != null && resolvedConstant.getType() != null ) {
			setType( resolvedConstant.getType() );
		} else if( constant.getType() != null ) {
			setType( constant.getType() );
		} else {
			setType(null);
		}
		if( isDefinedType() ) {
			setFixedType(getType());
		}		
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}
	
	public String toString() {
		return constant.toString();
	}

	@Override
	public boolean isEqualTo(IROper op) {
		if( !(op instanceof IRConst) ) return false;
		return constant.isEqualTo(((IRConst)op).getConstant());
	}
	
}
