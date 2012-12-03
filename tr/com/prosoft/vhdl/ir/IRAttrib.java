package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.IRArrBound.Bound;
import com.prosoft.vhdl.sim.EnumSimValue;
import com.prosoft.vhdl.sim.IntValue;
import com.prosoft.vhdl.sim.RangeValue;
import com.prosoft.vhdl.sim.SimValue;
import com.prosoft.vhdl.sim.TypeValue;


public class IRAttrib extends IROper implements IObjectElement {
	
	String attributeName;
	IROper value; // может быть чем угодно, например типом
	IRAttribType attribType = IRAttribType.UNDEFINED;
	IRAttribCode code;
	
	public IRAttrib( IROper prefix, String attributeName, ArrayList<IROper> args ) {
		setChild(0, prefix);
		this.attributeName = attributeName;
		for( int i = 0; i < args.size(); i++ ) {
			setChild(i+1, args.get(i));
		}
	}

	@Override
	public IROper dup() {
		IRAttrib res = new IRAttrib(getChild(0).dup(), attributeName, getArgs());
		res.dupChildrenAndCoordAndType(this);
		res.setFull(getFull());
		res.value = value;
		res.attribType = attribType;
		res.setType( getType() );
		return res;
	}
	
	public ArrayList<IROper> getArgs() {
		// первый child - объект, аттрибут которого вычисляется
		ArrayList<IROper> res = new ArrayList<IROper>();
		for( int i = 1; i < getChildNum(); i++ ) {
			res.add(getChild(i));
		}
		return res;
	}
	
	@Override
	public IROperKind getKind() {
		return IROperKind.ATTRIB;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}
	
	protected static IROper getIsDownTo( IRangedElement el ) {
		if( el.getRange().getRangeOf() != null ) {
			IRType type = el.getRange().getRangeOf().getType();
			if( type == null ) return null;
			if( type instanceof IRangedElement ) {
				return getIsDownTo( (IRangedElement) type );
			}
			return null;
		} else {
			return el.getRange().isDownTo();
		}
	}
	
	protected static IROper getRangeLow( IRangedElement el ) {
		if( el.getRange().getRangeOf() != null ) {
			IRType type = el.getRange().getRangeOf().getType();
			if( type == null ) return null;
			if( type instanceof IRangedElement ) {
				return getRangeLow( (IRangedElement) type );
			}
			return null;
		} else {
			return el.getRange().getRangeLow();
		}
	}
	
	protected static IROper getRangeHigh( IRangedElement el ) {
		if( el.getRange().getRangeOf() != null ) {
			IRType type = el.getRange().getRangeOf().getType();
			if( type == null ) return null;
			if( type instanceof IRangedElement ) {
				return getRangeHigh( (IRangedElement) type );
			}
			return null;
		} else {
			return el.getRange().getRangeHigh();
		}
	}
	
	protected void setLeft( IRangedElement el ) {
		IROper v;
//		while( el.getRange().isRangeOf() ) {
//			IROper op = el.getRange().getRangeOf();
//			IObjectElement obj = ((IObjectElement)op);
//			IRNamedElement named = obj.getLocalObject();
//			IRType type = named.getType();
//			if( type.isArray() ) {
//				type = IRTypeArray.getIndex(type, null, op);
//			}
//			el = (IRangedElement) type;
//		}
		if( el instanceof IRActualRanged ) {
			IRActualRanged act = (IRActualRanged) el;
			v = getIsDownTo(el) == null || !getIsDownTo(el).getBooleanValue() ? act.getActualRangeLow() : act.getActualRangeHigh();
		} else {
			v = getIsDownTo(el) == null || !getIsDownTo(el).getBooleanValue() ? getRangeLow(el) : getRangeHigh(el);
		}
		value = v;//new IRConst( v.getType(), v );
		if( v != null ) {
			setType( value.getType() );
		}
	}

	protected void setRight( IRangedElement el ) {
		IROper v;
		if( el instanceof IRActualRanged ) {
			IRActualRanged act = (IRActualRanged) el;
			v = getIsDownTo(el) == null || !getIsDownTo(el).getBooleanValue() ? act.getActualRangeHigh() : act.getActualRangeLow();
		} else {
			v = getIsDownTo(el) == null || !getIsDownTo(el).getBooleanValue() ? getRangeHigh(el) : getRangeLow(el);
		}
		value = v;//new IRConst( v.getType(), v );
		if( v != null ) {
			setType( value.getType() );
		}
	}
	
	protected void ensureNotSubprogram(IRErrorFactory err) {
		IRElement parent = getNonOperParent();
		if( parent instanceof IRSubProgram ) {
			err.cantAccessAttribFromSubprogram(this);
		}
	}
	
	protected int getAttributeParamInt( int paramIndex, IRErrorFactory err ) {
    	int index = 1;
    	if( getChildNum() > paramIndex ) {
    		IRConst cnst = IRConst.getConstantValue(getChild(paramIndex), err);
    		if( cnst == null ) {
    			err.constantExpressionRequired(getChild(paramIndex));
    		}
    		if( cnst.getType().isInt() ) {
    			index = cnst.getConstant().getIntValue();
    		} else {
    			err.integerExpected(cnst);
    		}
    	}
    	return index;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( attributeName.equalsIgnoreCase("at_boolean_1") ) {
			int a = 0;
			a++;
		}
		IROper prefix = getChild(0);
		prefix.semanticCheck(err);
		if( prefix.getType() == null ) {
			setType(null);
			return;
		}
		if( getBegin() != null && getBegin().getFile().endsWith("ct00380.vhd") && getBegin().getLine() == 41 ) {
			int a = 0;
			a++;
		}
		if( attributeName.equalsIgnoreCase("BASE") ) {
			if( getParent() instanceof IRAttrib ) {
				if( !prefix.getType().isType() ) {
					err.typeExpected(prefix);
					return;
				}
				IRType type = ((TypeValue)((IRConst)prefix).getConstant()).getValue();
				IRType base = type.getSubtypedFrom();
				if( base == null ) {
					base = type;
				}
				code = IRAttribCode.TYPE;
				value = new IRConst(new TypeValue(base));
				setFixedType(value.getType());
			} else {
				reportError("'BASE attribute allowed only as the prefix of the name of another attribute");
			}
			
		} else if( attributeName.equalsIgnoreCase("LEFT") ) {
	    	if( getBegin() != null && getBegin().getFile().endsWith("ct00141.vhd") && getBegin().getLine() == 199 ) {
	    		int a = 0;
	    		a++;
	    	}
			if( prefix.getType().isType() ) {
				code = IRAttribCode.TYPE;
				IRConst prefValue = IRConst.getConstantValue(prefix, err);
				if( prefValue == null ) {
					err.constantExpressionRequired(prefix);
				}
				if( prefValue instanceof IRangedElement ) {
					IRangedElement el = (IRangedElement) prefValue;
					setLeft(el);
					return;
				} else if( prefValue.getConstant() instanceof TypeValue ) {
					TypeValue tv = (TypeValue) prefValue.getConstant();
					if( tv.getValue() instanceof IRangedElement ) {
						setLeft((IRangedElement) tv.getValue());
						return;
					}
					int index = getAttributeParamInt(1, err) - 1;
					if( index < 0 || index >= IRTypeArray.getArray(tv.getValue(), err, prefValue).indexes.size() + 1 ) {
						err.indexOutOfRange(getChild(1));
						index = 0;
					}
					IRArrayIndex ind = IRTypeArray.getIndex(tv.getValue(), index, err, prefValue);
					if( ind != null ) {
						setLeft( ind );
						return;
					} else {
						err.undefinedAttribute(prefix, attributeName);
					}
				} else {
					err.undefinedAttribute(prefix, attributeName);
				}
			} else if( prefix.getType().isArray() /*|| prefix.getType().isInt() || prefix.getType().isReal()*/ ) {
				code = IRAttribCode.ARRAY;
		    	int index = getAttributeParamInt(1, err) - 1;
		    	if( index < 0 || index >= ((IRTypeArray)prefix.getType()).indexes.size() ) {
		    		err.indexOutOfRange(getChild(1));
		    		index = 1;
		    	}
				IRArrayIndex ai = ((IRTypeArray)prefix.getType()).indexes.get(index);
				setType( ai.getIndexType() );
				if( ai.isConst() ) {
					value = ai.getRange().isDownTo().getBooleanValue() ? ai.getRange().getRangeHigh() : ai.getRange().getRangeLow();
				}
				if( value == null ) {
					value = new IRArrBound( prefix, Bound.LEFT );//ai.isDownTo() );
				}
				return;
			}
		} else if( attributeName.equalsIgnoreCase("RIGHT") ) {
			if( prefix.getType().isType() ) {
				code = IRAttribCode.TYPE;
				IRConst prefValue = IRConst.getConstantValue(prefix, err);
				if( prefValue == null ) {
					err.constantExpressionRequired(prefix);
				}
				if( prefValue instanceof IRangedElement ) {
					IRangedElement el = (IRangedElement) prefValue;
					setRight(el);
					return;
				} else if( prefValue.getConstant() instanceof TypeValue ) {
					TypeValue tv = (TypeValue) prefValue.getConstant();
					if( tv.getValue() instanceof IRangedElement ) {
						setRight((IRangedElement) tv.getValue());
						return;
					}
					int index = getAttributeParamInt(1, err) - 1;
					if( index < 0 || index >= IRTypeArray.getArray(tv.getValue(), err, prefValue).indexes.size() ) {
						err.indexOutOfRange(getChild(1));
						index = 1;
					}
					IRArrayIndex ind = IRTypeArray.getIndex(tv.getValue(), index, err, prefValue);
					if( ind != null ) {
						setRight( ind );
						return;
					} else {
						err.undefinedAttribute(prefix, attributeName);
					}
				} else {
					err.undefinedAttribute(prefix, attributeName);
				}
			} else if( prefix.getType().isArray() /*|| prefix.getType().isInt() || prefix.getType().isReal()*/ ) {
				code = IRAttribCode.ARRAY;
		    	int index = getAttributeParamInt(1, err) - 1;
		    	if( index < 0 || index >= ((IRTypeArray)prefix.getType()).indexes.size() ) {
		    		err.indexOutOfRange(getChild(1));
		    		index = 1;
		    	}
				IRArrayIndex ai = ((IRTypeArray)prefix.getType()).indexes.get(index);
				setType( ai.indexType );
				if( ai.isConst() ) {
					value = ai.getRange().isDownTo().getBooleanValue() ? ai.getRange().getRangeLow() : ai.getRange().getRangeHigh();
				}
				if( value == null ) {
					value = new IRArrBound(prefix, Bound.RIGHT );//!ai.isDownTo());
				}
				return;
			}
		} else if( attributeName.equalsIgnoreCase("HIGH") ) {
			if( prefix.getType().isType() ) {
				code = IRAttribCode.TYPE;
				IRConst prefValue = IRConst.getConstantValue(prefix, err);
				if( prefValue == null ) {
					err.constantExpressionRequired(prefix);
				}
				IRType t = ((TypeValue)prefValue.getConstant()).getValue();
				if( t instanceof IRActualRanged ) {
					IRActualRanged el = (IRActualRanged) t;
					value = el.getActualRangeHigh().dup();
					value.setType(t);
					setType( value.getType() );
					return;
				} else if( t instanceof IRangedElement ) {
					IRangedElement el = (IRangedElement) t;
					value = el.getRange().getRangeHigh().dup();//new IRConst( el.getRangeHigh().getType(), el.getRangeHigh() );
					value.setType(t);
					setType( value.getType() );
					return;
				} else if( prefValue.getType().isType() ) {
					TypeValue tv = (TypeValue) prefValue.getConstant();
					if( tv.getValue() instanceof IRangedElement ) {
						value = ((IRangedElement) tv.getValue()).getRange().getRangeHigh().dup();
						value.setType(t);
						setType(value.getType());
						return;
					}
					IRArrayIndex ind = IRTypeArray.getIndex(tv.getValue(), err, prefValue);
					if( ind != null ) {
						value = ind.getRange().getRangeHigh().dup();
//						value.setType(t);
						setType(value.getType());
						return;
					} else {
						err.undefinedAttribute(prefix, attributeName);
					}
				} else {
					err.undefinedAttribute(prefix, attributeName);
				}
			} else if( prefix.getType().isArray() /*|| prefix.getType().isInt() || prefix.getType().isReal()*/ ) {
				code = IRAttribCode.ARRAY;
				IRTypeArray arr = IRTypeArray.getArray(prefix.getType(), err, prefix);
				if( arr.indexes.size() != 1 ) throw new RuntimeException();
				IRArrayIndex ai = arr.indexes.get(0);
				value = ai.getRange().getRangeHigh();//new IRConst( el.getRangeHigh().getType(), el.getRangeHigh() );
				if( value == null ) {
					value = new IRArrBound(prefix, Bound.HIGH);
				}
				setType( ai.indexType );
				return;
			} else {
				err.typeOrArrayExpected(prefix);
				return;
			}
		} else if( attributeName.equalsIgnoreCase("LOW") ) {
			if( prefix.getType().isType() ) {
				code = IRAttribCode.TYPE;
				IRConst prefValue = IRConst.getConstantValue(prefix, err);
				if( prefValue == null ) {
					err.constantExpressionRequired(prefix);
				}
				IRType t = ((TypeValue)prefValue.getConstant()).getValue();
				if( t instanceof IRActualRanged ) {
					IRActualRanged el = (IRActualRanged) t;
					value = el.getActualRangeLow().dup();
					value.setType(t);
					setType( value.getType() );
					return;
				} else if( t instanceof IRangedElement ) {
					IRangedElement el = (IRangedElement) t;
					value = el.getRange().getRangeLow().dup();//new IRConst( el.getRangeHigh().getType(), el.getRangeLow() );
					value.setType(t);
					setType( value.getType() );
					return;
				} else if( prefValue.getType().isType() ) {
					TypeValue tv = (TypeValue) prefValue.getConstant();
					if( tv.getValue() instanceof IRangedElement ) {
						value = ((IRangedElement) tv.getValue()).getRange().getRangeLow().dup();
						value.setType(t);
						setType(value.getType());
						return;
					}
					IRArrayIndex ind = IRTypeArray.getIndex(tv.getValue(), err, prefValue);
					if( ind != null ) {
						value = ind.getRange().getRangeLow().dup();
//						value.setType(t);
						setType(value.getType());
						return;
					} else {
						err.undefinedAttribute(prefix, attributeName);
					}
				} else {
					err.undefinedAttribute(prefix, attributeName);
				}
			} else if( prefix.getType().isArray() /*|| prefix.getType().isInt() || prefix.getType().isReal()*/ ) {
				code = IRAttribCode.ARRAY;
				IRTypeArray arr = IRTypeArray.getArray(prefix.getType(), err, prefix);
				if( arr.indexes.size() != 1 ) throw new RuntimeException();
				IRArrayIndex ai = arr.indexes.get(0);
				value = ai.getRange().getRangeLow();//new IRConst( el.getRangeLow().getType(), el.getRangeLow() );
				if( value == null ) {
					value = new IRArrBound(prefix, Bound.LOW);
				}
				setType( ai.indexType );
				return;
			} else {
				err.typeOrArrayExpected(prefix);
				return;
			}
		} else if( attributeName.equalsIgnoreCase("RANGE") ) {
			if( prefix.getType().isArray() || prefix.getType().isType() ) {
				code = IRAttribCode.ARRAY;
				IRTypeArray arr;
				if( prefix.getType().isArray() ) {
					arr = IRTypeArray.getArray(prefix.getType(), err, prefix);
					value = new IROperRange(prefix, arr.getFirstIndex().indexType, false);
					value.semanticCheck(err);
					setType(arr.getFirstIndex().indexType);
					return;
				} else {
					IRConst prefValue = IRConst.getConstantValue(prefix, err);
					TypeValue tv = (TypeValue) prefValue.getConstant();
					arr = IRTypeArray.getArray(tv.getValue(), err, prefix);
				}
//				IRPrimaryReader pr = (IRPrimaryReader) prefix;
				IRangedElement el = arr.indexes.get(0);
				if( el.getRange().getRangeHigh() == null || el.getRange().getRangeLow() == null ) {
					value = new IRConst( new RangeValue( 
							new IRArrBound(prefix, Bound.LOW),  
							new IRArrBound(prefix, Bound.IS_DOWN_TO),  
							new IRArrBound(prefix, Bound.HIGH) ) );
					setType( value.getType() );
				} else {
					value = new IRConst( new RangeValue(el.getRange().getRangeLow(), el.getRange().isDownTo(), el.getRange().getRangeHigh()) );
//					value = new IRConst(r.getType(), r);
					setType( value.getType() );
				}
				return;
			}
		} else if( attributeName.equalsIgnoreCase("REVERSE_RANGE") ) {
			if( prefix.getType().isArray() ) {
				code = IRAttribCode.ARRAY;
				IRTypeArray arr = IRTypeArray.getArray(prefix.getType(), err, prefix);
//				IRPrimaryReader pr = (IRPrimaryReader) prefix;
				IRangedElement el = arr.indexes.get(0);
				if( el.getRange().getRangeHigh() == null || el.getRange().getRangeLow() == null ) {
					value = new IRConst( new RangeValue(
							new IRArrBound(prefix, Bound.HIGH), 
							new IRArrBound(prefix, Bound.IS_DOWN_TO), 
							new IRArrBound(prefix, Bound.LOW) ) );
					setType( value.getType() );
				} else {
					IROper isDownTo;
					if( el.getRange().isDownTo().isConst() ) {
						isDownTo = err.parser.getBooleanConst( !el.getRange().isDownTo().getBooleanValue() );
					} else {
						isDownTo = new IRUnaryOper(IROperKind.NOT, el.getRange().isDownTo());
					}
					value = new IRConst( new RangeValue(el.getRange().getRangeHigh(), isDownTo, el.getRange().getRangeLow()) );
//					value = new IRConst(r.getType(), r);
					this.setType( value.getType() );
				}
				return;
//			if( prefix.getType().isArray() ) {
//				IRTypeArray arr = (IRTypeArray) prefix.getType();
//				IRangedElement el = arr.indexes.get(0);
//				RangeValue r = new RangeValue(el.getRangeHigh(), !el.isDownTo(), el.getRangeLow());
//				value = new IRConst(r.getType(), r);
//				this.type = value.type;
//				return;
			}
		} else if( attributeName.equalsIgnoreCase("LENGTH") ) {
			if( prefix.getType().isArray() ) {
				code = IRAttribCode.ARRAY;
				IRTypeArray arr = IRTypeArray.getArray(prefix.getType(), err, prefix);
				IRArrayIndex el = arr.indexes.get(0);
				if( el.isConst() ) {
					this.value = IRTypeInteger.createConstant(el.getRangeHighAsInt(err) - el.getRangeLowAsInt(err) + 1);
					this.setType( value.getType() );
					return;
				} else {
					// TODO пока ничего
					this.setType( IRTypeInteger.TYPE );
					return;
				}
			} else if( prefix.getType().isType() && ((TypeValue)((IRConst)prefix).getConstant()).getValue().isArray() ) {
				code = IRAttribCode.TYPE_ARRAY;
				IRTypeArray arr = (IRTypeArray) ((TypeValue)((IRConst)prefix).getConstant()).getValue();
				IRArrayIndex el = arr.indexes.get(0);
				if( el.isConst() ) {
					this.value = IRTypeInteger.createConstant(el.getRangeHighAsInt(err) - el.getRangeLowAsInt(err) + 1);
					this.setType( value.getType() );
					return;
				} else {
					// TODO пока ничего
					this.setType( IRTypeInteger.TYPE );
					return;
				}
			} else {
				throw new RuntimeException(prefix.getType().toString() + " at " + prefix.getBegin());
			}
		} else if( attributeName.equalsIgnoreCase("EVENT") ) {
			attribType = IRAttribType.SIM;
			code = IRAttribCode.SIGNAL;
			setFixedType( err.parser.getBoolean() );
		} else if( attributeName.equalsIgnoreCase("LAST_VALUE") ) {
			attribType = IRAttribType.SIM;
			code = IRAttribCode.SIGNAL;
			setType( prefix.getType() );
		} else if( attributeName.equalsIgnoreCase("LAST_EVENT") || attributeName.equalsIgnoreCase("LAST_ACTIVE") ) {
			attribType = IRAttribType.SIM;
			code = IRAttribCode.SIGNAL;
			setFixedType(err.parser.getTimeType());
			
		} else if( attributeName.equalsIgnoreCase("TRANSACTION") ) {
			attribType = IRAttribType.SIM;
			code = IRAttribCode.SIGNAL;
			if( getChild(0).getKind() != IROperKind.SGNL ) {
				err.signalExpected(getChild(0));
				return;
			}
			setFixedType(err.parser.getBit());
			
		} else if( attributeName.equalsIgnoreCase("DELAYED") ) {
			attribType = IRAttribType.SIM;
			code = IRAttribCode.SIGNAL;
			if( getChild(0).getKind() != IROperKind.SGNL ) {
				err.signalExpected(getChild(0));
				return;
			}
			IRSignalOper so = (IRSignalOper) getChild(0);
			IRTypePhysical time_t = err.parser.getTimeType();
			if( getChildNum() == 2 ) {
				IROper time = getChild(1);
				time.setType(time_t);
				time.semanticCheck(err);
				if( !time_t.isAssignableFrom(time.getType()) ) {
					err.timeExpected(time);
				}
			} else {
				setChild(1, new IRConst( IRTypePhysical.createConstant(time_t, IRTypeInteger.createConstant(0), time_t.units, err) ) );
			}
			setType(so.getType());
			
			ensureNotSubprogram(err);
			
		} else if( attributeName.equalsIgnoreCase("STABLE") || attributeName.equalsIgnoreCase("QUIET") || attributeName.equalsIgnoreCase("ACTIVE") ) {
			attribType = IRAttribType.SIM;
			code = IRAttribCode.SIGNAL;
			boolean isSignal = false;
			if( getChild(0) instanceof IObjectElement ) {
				if( ((IObjectElement)getChild(0)).getObjectClass() == IRObjectClass.SIGNAL ) {
					isSignal = true;
				}
			} else if( getChild(0).getKind() == IROperKind.SGNL ) {
				isSignal = true;
			} else if( (getChild(0) instanceof IRAttrib && ((IRAttrib)getChild(0)).attributeName.equalsIgnoreCase("DELAYED")) ) {
				isSignal = true;
			}
			if( !isSignal ) {
//			if( getChild(0).getKind() != IROperKind.SGNL && !(getChild(0) instanceof IRAttrib && ((IRAttrib)getChild(0)).attributeName.equalsIgnoreCase("DELAYED")) ) {
				err.signalExpected(getChild(0));
				return;
			}
			IRTypePhysical time_t = err.parser.getTimeType();
			if( getChildNum() == 2 ) {
				IROper time = getChild(1);
				time.setType(time_t);
				time.semanticCheck(err);
				if( !time_t.isAssignableFrom(time.getType()) ) {
					err.timeExpected(time);
				}
			} else {
				setChild(1, new IRConst( IRTypePhysical.createConstant(time_t, IRTypeInteger.createConstant(0), time_t.units, err) ) );
			}
			setFixedType(err.parser.getBoolean());
			
			ensureNotSubprogram(err);
			
		} else if( attributeName.equalsIgnoreCase("ASCENDING") ) {
			if( prefix.getType().isArray() ) {
				code = IRAttribCode.ARRAY;
				IRArrayIndex ind = IRTypeArray.getIndex(prefix.getType(), err, this);
				value = err.parser.getBooleanConst(!ind.getRange().isDownTo().getBooleanValue());
			} else if( prefix.getType().isType() ) {
				code = IRAttribCode.TYPE;
				IRConst cnst = (IRConst) prefix;
				IRangedElement el = (IRangedElement) ((TypeValue)cnst.getConstant()).getValue();
				value = err.parser.getBooleanConst(!el.getRange().isDownTo().getBooleanValue());
			} else {
				throw new RuntimeException();
			}
		} else if( attributeName.equalsIgnoreCase("POS") ) {
			if( prefix.getType().isType() ) {
				code  = IRAttribCode.TYPE;
				IROper param = getArgs().get(0);
				IRConst cnst = IRConst.getConstantValue(prefix, err);
				IRType type = ((TypeValue)cnst.getConstant()).getValue();
				if( param.getType() == null ) {
					param.setType(type);
				}
				param.semanticCheck(err);
				if( !type.isAssignableFrom(param.getType()) ) {
					err.incompatibleTypes(type, param.getType(), param);
				}
				setType(IRTypeInteger.TYPE);
			} else {
				err.typeExpected(prefix);
			}
		} else if( attributeName.equalsIgnoreCase("VAL") ) {
			if( prefix.getType().isType() ) {
				code = IRAttribCode.TYPE;
				IROper param = getArgs().get(0); 
				IRConst cnst = IRConst.getConstantValue(prefix, err);
				IRType type = ((TypeValue)cnst.getConstant()).getValue();
				param.semanticCheck(err);
				if( !param.getType().isInt() ) {
					err.integerExpected(prefix);
				}
				setType(type);
				if( type.isEnum() ) {
					IRTypeEnum en = (IRTypeEnum) type;
					IRConst index = IRConst.getConstantValue(param, err);
					if( index != null ) {
						int indexValue = index.getConstant().getIntOrEnumIndex();
						if( indexValue > en.getNumValues() - 1 ) {
							indexValue = en.getNumValues() - 1;
						} else if( indexValue < 0 ) {
							indexValue = 0;
						}
						value = en.getValue(indexValue).getSimValue();
					}
				}
			} else {
				err.typeExpected(prefix);
			}
		} else if( attributeName.equalsIgnoreCase("IMAGE") ) {
			if( prefix.getType().isType() ) {
				code = IRAttribCode.TYPE;
				IROper param = getArgs().get(0); 
				IRConst cnst = (IRConst) prefix;
				IRType type = ((TypeValue)cnst.getConstant()).getValue();
				param.setType(type);
				param.semanticCheck(err);
				if( param.getType() == null ) {
					err.cantInferType(param);
				} else if( !type.isAssignableFrom(param.getType()) ) {
					err.incompatibleTypes(type, param.getType(), this);
				}
				setType(err.parser.getStringType());
			} else {
				err.typeExpected(prefix);
			}
		} else if( attributeName.equalsIgnoreCase("SUCC") || attributeName.equalsIgnoreCase("PRED") ) {
			code = IRAttribCode.TYPE;
			IROper expr = getArgs().get(0);
			expr.semanticCheck(err);
			if( expr.getType() == null ) {
				err.cantInferType(expr);
				return;
			}
			if( !(expr.getType().isDescrete() || expr.getType().isPhysical()) ) {
				err.discreteOrPhysicalExpected(expr);
				return;
			}
			if( !prefix.getType().isType() ) {
				err.discreteOrPhysicalExpected(prefix);
				return;
			}
			IRConst cnst = (IRConst) prefix;
			IRType type = ((TypeValue)cnst.getConstant()).getValue();
			if( !type.isSameBase(expr.getType()) ) {
				err.incompatibleTypes(type, expr.getType(), this);
			}
			setType(type.getOriginalType());
		} else {
			reportError("Undefined attribute: " + attributeName);
		}
	}

	public String getAttributeName() {
		return attributeName;
	}

	public IROper getValue() {
		return value;
	}
	
	public IRAttribCode getCode() {
		return code;
	}

	public String toString() {
		return getChild(0) + "'" + attributeName; 
	}

	@Override
	public boolean isEqualTo(IROper op) {
		// TODO добавить проверку параметров аттрибутов, когда те будут добавлены
		if( !defaultIsEqualTo(op) ) return false;
		if( !attributeName.equalsIgnoreCase( ((IRAttrib)op).attributeName ) ) return false;
		return true;
	}
	
	IObjectElement getPrefixObjectElement() {
		IROper prefix = getChild(0);
		if( prefix instanceof IObjectElement ) return (IObjectElement) prefix;
		return null;
	}

	@Override
	public void setPrimary() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean isPrimary() {
		IObjectElement pr = getPrefixObjectElement();
		if( pr != null ) return pr.isPrimary();
		return false;
	}

	@Override
	public IRObjectClass getObjectClass() {
		if( code == IRAttribCode.SIGNAL ) return IRObjectClass.SIGNAL;
		return IRObjectClass.NONE;
	}

	@Override
	public IRNamedElement getTopmostObject() {
		IObjectElement pr = getPrefixObjectElement();
		if( pr != null ) return pr.getTopmostObject();
		return null;
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		IObjectElement pr = getPrefixObjectElement();
		if( pr != null ) return pr.getTopmostValueableObject();
		return null;
	}

	@Override
	public IRNamedElement getLocalObject() {
		IObjectElement pr = getPrefixObjectElement();
		if( pr != null ) return pr.getLocalObject();
		return null;
	}

}
