package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.Vector;

import com.prosoft.vhdl.sim.SimValue;

public class IRAggreg extends IROper {
	
	// сюда в качестве детей могут входит либо IROperAssoc, тогда здесь будут именованые таргеты 
	// либо просто IROper, тогда таргеты определяются порядком перечисления
	
	public IRAggreg( ArrayList<IROper> elements ) {
		for( int i = 0; i < elements.size(); i++ ) {
			setChild(i, elements.get(i));
		}
	}
	
	protected IRAggreg(Vector<IROper> members, Vector<IROper> indexes, int membersSize/*, IROper othersInit*/) {
		super();
		if( members != null ) {
			this.memberValues = new Vector<IROper>(members.size());
			this.memberIndexes = new Vector<IROper>(members.size());
			for( int i = 0; i < members.size(); i++ ) {
				this.memberValues.set(i, members.elementAt(i).dup());
				this.memberIndexes.set(i, indexes.elementAt(i).dup());
			}
		}
		this.membersSize = membersSize;
//		this.othersInit = othersInit.dup();
	}

	public IRAggreg dup() {
		IRAggreg res = new IRAggreg(IROper.dupIROperVector(memberValues), IROper.dupIROperVector(memberIndexes), membersSize/*, othersInit*/);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	
	Vector<IROper> memberValues;
	Vector<IROper> memberIndexes;
	int membersSize = -1;
//	IROper othersInit;

	@Override
	public IROperKind getKind() {
		return IROperKind.AGGREG;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}
	
	protected void ensureSize( int minSize ) {
		memberValues.setSize( Math.max( memberValues.size(), minSize) );
		memberIndexes.setSize( Math.max( memberIndexes.size(), minSize) );
	}
	
	protected IRArrayIndex getArrayIndex() {
		IRArrayIndex arrayIndex;
		if( getType() instanceof IRTypeArray ) {
			arrayIndex = ((IRTypeArray)getType()).indexes.get(0);
		} else {
			arrayIndex = (IRArrayIndex) getType();
			// берем следующий индекс
//			arrayIndex = arrayIndex.arrayType.indexes.get(arrayIndex.indexInArray+1);
		}
		return arrayIndex;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( getBegin() != null && getBegin().getFile().endsWith("ct00637.vhd") && getBegin().getLine() == 112 ) {
			int a = 0;
			a++;
		}
		if( getChildNum() == 1 && !(getChild(0) instanceof IROperAssoc) ) {
			// это просто выражение в скобках, а не агрегат
			if( getChild(0).getFixedType() != null ) {
				setFixedType(getChild(0).getFixedType());
				return;
			}
			getChild(0).setType( getType() );
			getChild(0).semanticCheck(err);
			if( getType() != null ) {
//				String t1 = getType().getBaseTypeName();
//				String t2 = getChild(0).getType().getBaseTypeName();
//				if( !t1.equalsIgnoreCase(t2) ) {
//					err.incompatibleTypes(getType(), getChild(0).getType(), this);
//				}
			}
			setType( getChild(0).getType() );
		} else {
			memberIndexes = new Vector<IROper>();
			memberValues = new Vector<IROper>();
			if( getType() == null ) {
				detectAutoArray(err);
			}
			if( getType() == null ) {
//				setType( getParentsType() );
				return;
			}
//			if( getType() == null ) {
//				err.cantInferType(this);
//				return;
//			}
			if( getType().isArray() ) {
				IRArrayIndex index = getArrayIndex();
				if( index.getIndexType().isInt() ) {
//					members = new Vector<IROper>(); //new IROper[index.rangeHigh.getIntValue() - index.rangeLow.getIntValue() + 1];
//					if( index.getRangeHigh().isConst() && index.getRangeLow().isConst() ) {
//						membersSize = index.getRangeHighAsInt(err) - index.getRangeLowAsInt(err) + 1;
//					}
				} else if( index.getIndexType().isEnum() ) {
//					members = new Vector<IROper>(); //new IROper[((IRTypeEnum)index.getIndexType()).values.get(((IRTypeEnum)index.getIndexType()).values.size()-1).value+1];
//					if( index.getRangeHigh().isConst() && index.getRangeLow().isConst() ) {
//						membersSize = index.getRangeHighAsInt(err) - index.getRangeLowAsInt(err) + 1;
//					}
				} else {
					throw new RuntimeException();
				}
				checkArray(err);
			} else if( getType().isRecord() ) {
//				IRTypeRecord rec = (IRTypeRecord) getType();
//				members = new Vector<IROper>();//new IROper[rec.fields.size()];
//				membersSize = rec.fields.size();
				checkRecord(err);
			} else {
				err.invalidAggregateLength(this, -1);
			}
//			for( int i = 0; i < getChildNum(); i++ ) {
//				getChild(i).semanticCheck(err);
//			}
		}
	}
	
	enum AGG_TYPE {
		UNDEFINED,
		NAMED,
		ORDER
	};
	
	protected void checkRecord(IRErrorFactory err) throws CompilerError {
		
	IRTypeRecord type = (IRTypeRecord) getType();
	AGG_TYPE aggType = AGG_TYPE.UNDEFINED;
	boolean mixingErrorGenerated = false;
	int index = 0;
	
	membersSize = type.getNumFields();
	
	for( int ai = 0; ai < getChildNum(); ai++ ) {
		IROper op = getChild(ai);
		
		// именованный агрегат
		if( op instanceof IROperAssoc ) {
			IRChoices choices = (IRChoices) op.getChild(0);
//			if( aggType == AGG_TYPE.UNDEFINED || aggType == AGG_TYPE.NAMED ) {
				aggType = AGG_TYPE.NAMED;
//			} else if( !choices.isJustOthers() ){
//				if( !mixingErrorGenerated ) err.mixingNamedAndOrderAggreg(this);
//				mixingErrorGenerated = true;
//			}
			for( int ci = 0; ci < choices.getChildNum(); ci++ ) {
				IROper ch = choices.getChild(ci);
				if( ch instanceof IROperOthers ) {
					IROper expr = op.getChild(1);
					if( ci + 1 != choices.getChildNum() ) {
						err.othersShouldBeLast((IROperOthers) expr);
					}
					int othersMet = 0;
					for( int mi = 0; mi < membersSize; mi++ ) {
						ensureSize(mi+1);
						if( memberValues.get(mi) == null ) {
							othersMet++;
							IRRecordField f = type.fields.get(mi);
							expr.setType( f.getType() );
							expr.semanticCheck(err);
							if( !f.getType().isAssignableFrom(expr.getType()) ) {
								err.incompatibleTypes(f.getType(), expr.getType(), this);
							}
							ensureSize(mi+1);
							memberValues.set(mi, expr);
						}
					}
					if( othersMet == 0 ) {
						err.othersShouldBeAtLeastOne(this);
					}
					
					// возможно совпадение имени поля и имени константы или имени сигнала или имени переменной.
				} else if( ch instanceof IRName || ch instanceof IRConstRead || ch instanceof IRSignalOper || ch instanceof IRVarOper ) {
					String fName;
					switch( ch.getKind() ) {
					case NAME:
						fName = ((IRName)ch).name; break;
					case CONST_READ:
						fName = ((IRConstRead)ch).getConstant().getName(); break;
					case SGNL:
						fName = ((IRSignalOper)ch).getSignal().getName(); break;
					case VAR:
						fName = ((IRVarOper)ch).getVariable().getName(); break;
					default: throw new RuntimeException();
					}
					IRRecordField f = type.getField( fName );
					if( f == null ) {
						err.fieldNameExpected(ch);
						continue;
					}
					IROper expr = op.getChild(1);
					expr.setType( f.getType() );
					expr.semanticCheck(err);
					if( !f.getType().isAssignableFrom(expr.getType()) ) {
						err.incompatibleTypes(f.getType(), expr.getType(), this);
					}
					if( memberValues.size() > f.getIndex() && memberValues.get(f.getIndex()) != null ) {
						err.multipleAssociationInAggregate((IROperAssoc) op);
					} else {
						ensureSize(f.getIndex()+1);
						memberValues.set( f.getIndex(), expr );
					}
				} else {
					err.fieldNameExpected(ch);
				}
			}
		} else {
			// ordered aggregate
			if( aggType == AGG_TYPE.UNDEFINED || aggType == AGG_TYPE.ORDER ) {
				aggType = AGG_TYPE.ORDER;
			} else {
				if( !mixingErrorGenerated ) err.mixingNamedAndOrderAggreg(this);
				mixingErrorGenerated = true;
			}
			if( index >= type.fields.size() ) {
				err.invalidAggregateLength(this, type.fields.size());
			}
			IRType fieldType = type.fields.get(index).getType();
			op.setType( fieldType );
			op.semanticCheck(err);
			if( !fieldType.isAssignableFrom(op.getType()) ) {
				err.incompatibleTypes(fieldType, op.getType(), this);
			}
			ensureSize(index+1);
			memberValues.set( index, op );
			index++;
		}
	}
//	checkAggregateComplete(err);
}

	
	protected void checkArray(IRErrorFactory err) throws CompilerError {

		IRArrayIndex arrayIndex = getArrayIndex();

		IRType elType;
		if (arrayIndex.indexInArray + 1 == arrayIndex.arrayType.indexes.size()) {
			elType = arrayIndex.getArrayType().elementType;// type.getElementType();
		} else {
			elType = arrayIndex.arrayType.indexes
					.get(arrayIndex.indexInArray + 1);
		}

		AGG_TYPE aggType = AGG_TYPE.UNDEFINED;
		boolean errorGenerated = false;
		boolean mixingErrorGenerated = false;
		// int high, low;
		if (arrayIndex.getIndexType().isInt()
				|| arrayIndex.getIndexType().isEnum()) {
			// if( arrayIndex.getRangeHigh().isConst() &&
			// arrayIndex.getRangeLow().isConst() ) {
			// high = arrayIndex.getRangeHighAsInt(err);
			// low = arrayIndex.getRangeLowAsInt(err);
			// } else {
			// if( arrayIndex.getIndexType().isInt() ) {
			// low =
			// ((IRTypeInteger)arrayIndex.getIndexType()).getActualRangeLow().getConstant().getIntValue();
			// high =
			// ((IRTypeInteger)arrayIndex.getIndexType()).getActualRangeHigh().getConstant().getIntValue();
			// } else {
			// // TODO ---
			// throw new RuntimeException("TODO");
			// }
			// }
		} else {
			throw new RuntimeException();
		}

		// int index;;
		// int firstIndex;;
		// int lastIndex;

		// if( arrayIndex.isConst() ) {
		// index = arrayIndex.isDownTo().getBooleanValue() ? high : low;
		// firstIndex = index;
		// lastIndex = !arrayIndex.isDownTo().getBooleanValue() ? high : low;
		// } else {
		// index = 0; firstIndex = 0; lastIndex = 0;
		// }

		if (getBegin() != null
				&& getBegin().toString()
						.startsWith(".\\msp430_pkg.vhd:563:17:")) {
			int a = 0;
			a++;
		}

		for (int ai = 0; ai < getChildNum(); ai++) {
			IROper op = getChild(ai);

			// именованный агрегат
			if (op instanceof IROperAssoc) {
				IROperAssoc assoc = (IROperAssoc) op;
				IRChoices choices = (IRChoices) assoc.getChild(0);
				if (op instanceof IROperAssoc) {
					if (aggType == AGG_TYPE.UNDEFINED
							|| aggType == AGG_TYPE.NAMED) {
						aggType = AGG_TYPE.NAMED;
					} else if (!choices.isJustOthers()) {
						if (!mixingErrorGenerated)
							err.mixingNamedAndOrderAggreg(this);
						mixingErrorGenerated = true;
					}
				}
				assoc.setType(elType);
				IROper expr = assoc.getChild(1);
				expr.setType(elType);
				expr.semanticCheck(err);
				if (!elType.isAssignableFrom(expr.getType()) && !errorGenerated) {
					err.incompatibleTypes(elType, expr.getType(), this);
					errorGenerated = true;
				}
				for (int ci = 0; ci < choices.getChildNum(); ci++) {
					IROper choice = choices.getChild(ci);
					// if( arrayIndex.getIndexType().isEnum() /*||
					// arrayIndex.getIndexType().isInt()*/ ) {
					if (choice instanceof IRName) {
						IRName name = (IRName) choice;
						// IREnumValue v =
						// ((IRTypeEnum)arrayIndex.getIndexType()).getValue(name.getName());
						IRNamedElement v = resolve(name.getName());
						if (v == null) {
							err.undefined(choice.getBegin(), name.getName());
							return;
						} else {
							IROper newOp = create(v);
							newOp.dupChildrenAndCoordAndType(choice);
							IROper parent = choice.getParentOper();
							parent.setChild(ci, null);
							parent.setChild(ci, newOp);
							choice = newOp;
						}
					} else if (choice instanceof IRConst) {
						// it's ok
					} else {
						// reportError();
					}
					// }
					choice.semanticCheck(err);
					IRConst cnst;
					if (choice instanceof IROperOthers) {
						memberIndexes.add(choice);
						memberValues.add(expr);
						// othersInit = expr;
						// if( membersSize > 0 ) {
						// ensureSize(membersSize);
						// for( int mi = 0; mi < membersSize; mi++ ) {
						// if( memberValues.get( mi ) == null ) {
						// memberValues.set( mi, expr );
						// }
						// }
						// }
					} else if ((cnst = IRConst.getConstantValue(choice, err)) != null) {
						memberIndexes.add(choice);
						memberValues.add(expr);
						// SimValue v = cnst.getConstant();
						// int memIndex;// = cnst.getConstant().getIntValue();
						// if( v.getType().isInt() ) {
						// memIndex = v.getIntValue();
						// } else if( v.getType().isEnum() ) {
						// memIndex = v.getEnumValue().getValue();
						// } else {
						// throw new RuntimeException();
						// }
						// if( memIndex < low || memIndex > high ) {
						// err.indexOutOfRange(op);
						// }
						// if( arrayIndex.isDownTo().getBooleanValue() ) {
						// memIndex = high - memIndex;
						// } else {
						// memIndex = memIndex - low;
						// }
						// if( members.get(memIndex) != null ) {
						// err.multipleAssociationInAggregate(assoc);
						// }
						// members.set( memIndex, expr );
					} else if (choice instanceof IROperRange) {
						memberIndexes.add(choice);
						memberValues.add(expr);
					} else if (choice instanceof IROperIndex) {
						// индексом в аггрегате будет индекс из операции
						// "индекс"
						memberIndexes.add(choice.getChild(1));
						memberValues.add(expr);
					} else {
						memberIndexes.add(choice);
						memberValues.add(expr);
						// err.constantExpressionRequired(choice);
					}
				}
			} else {
				// ordered aggregate
				if (aggType == AGG_TYPE.UNDEFINED || aggType == AGG_TYPE.ORDER) {
					aggType = AGG_TYPE.ORDER;
				} else {
					if (!mixingErrorGenerated)
						err.mixingNamedAndOrderAggreg(this);
					mixingErrorGenerated = true;
				}
				// if( arrayIndex.isDownTo().getBooleanValue() ? index <
				// lastIndex : index > lastIndex ) {
				// err.invalidAggregateLength(this, Math.abs(lastIndex -
				// firstIndex) + 1);
				// }
				op.setType(elType);
				op.semanticCheck(err);
				if (!elType.isAssignableFrom(op.getType())) {
					err.incompatibleTypes(elType, op.getType(), this);
				}
				// ensureSize( index + 1 );
				// members.set( index, op );
				// index += arrayIndex.isDownTo().getBooleanValue() ? -1 : +1;
				memberValues.add(op);
				memberIndexes.add(IRTypeInteger.createConstant(ai));
			}
		}
		// checkAggregateComplete(err);
	}	
	
	
	protected void detectAutoArray(IRErrorFactory err) throws CompilerError {
		for( int i = 0; i < getChildNum(); i++ ) {
			getChild(i).semanticCheck(err);
		}
		boolean error = false;
		String baseTypeName = null;
		IRType elType = null;
		for( int i = 0; i < getChildNum(); i++ ) {
			IROper ch = getChild(i);
			IRType type = ch.getType();
			if( type != null ) {
				if( baseTypeName == null ) {
					baseTypeName = type.getBaseTypeName();
					elType = type;
				} else {
					String thisName = type.getBaseTypeName();
					if( !baseTypeName.equalsIgnoreCase(thisName) ) {
						error = true;
					}
				}
			}
		}
		if( baseTypeName != null && !error ) {
			IRTypeArray arr = new IRTypeArray(null, null, elType);
			IRArrayIndex index = new IRArrayIndex(null, null);
			index.setIndexType(IRTypeInteger.TYPE);
			index.getRange().setDownTo(err.parser.getBooleanConst(false));
			index.getRange().setRangeLow(IRTypeInteger.createConstant(0));
			index.getRange().setRangeHigh(IRTypeInteger.createConstant(getChildNum()-1));
			arr.add(index);
			setType(arr);
		}
	}
	
//	protected void checkArray(IRErrorFactory err) throws CompilerError {
//		//IRTypeArray type = (IRTypeArray) this.type;
//		
//		IRArrayIndex arrayIndex = getArrayIndex();
//		
//		IRType elType;
//		if( arrayIndex.indexInArray + 1 == arrayIndex.arrayType.indexes.size() ) {
//			elType = arrayIndex.getArrayType().elementType;//type.getElementType();
//		} else {
//			elType = arrayIndex.arrayType.indexes.get(arrayIndex.indexInArray+1);
//		}
//		
//		AGG_TYPE aggType = AGG_TYPE.UNDEFINED;
//		boolean errorGenerated = false;
//		boolean mixingErrorGenerated = false;
//		int high, low;
//		if( arrayIndex.getIndexType().isInt() || arrayIndex.getIndexType().isEnum() ) {
//			if( arrayIndex.getRangeHigh().isConst() && arrayIndex.getRangeLow().isConst() ) {
//				high = arrayIndex.getRangeHighAsInt(err);
//				low = arrayIndex.getRangeLowAsInt(err);
//			} else {
//				if( arrayIndex.getIndexType().isInt() ) {
//					low = ((IRTypeInteger)arrayIndex.getIndexType()).getActualRangeLow().getConstant().getIntValue();
//					high = ((IRTypeInteger)arrayIndex.getIndexType()).getActualRangeHigh().getConstant().getIntValue();
//				} else {
//					// TODO ---
//					throw new RuntimeException("TODO");
//				}
//			}
//		} else {
//			throw new RuntimeException();
//		}
//		
//		int index;;
//		int firstIndex;;
//		int lastIndex;
//		
//		if( arrayIndex.isConst() ) {
//			index = arrayIndex.isDownTo().getBooleanValue() ? high : low;
//			firstIndex = index;
//			lastIndex = !arrayIndex.isDownTo().getBooleanValue() ? high : low;
//		} else {
//			index = 0; firstIndex = 0; lastIndex = 0;
//		}
//		
//		for( int ai = 0; ai < getChildNum(); ai++ ) {
//			IROper op = getChild(ai);
//			
//			// именованный агрегат
//			if( op instanceof IROperAssoc ) {
//				IROperAssoc assoc = (IROperAssoc) op;
//				IRChoices choices = (IRChoices) assoc.getChild(0);
//				if( op instanceof IROperAssoc ) {
//					if( aggType == AGG_TYPE.UNDEFINED || aggType == AGG_TYPE.NAMED ) {
//						aggType = AGG_TYPE.NAMED;
//					} else if( !choices.isJustOthers() ){
//						if( !mixingErrorGenerated ) err.mixingNamedAndOrderAggreg();
//						mixingErrorGenerated = true;
//					}
//				}
//				assoc.setType( elType );
//				IROper expr = assoc.getChild(1);
//				expr.setType(elType);
//				expr.semanticCheck(err);
//				if( !elType.isAssignableFrom( expr.getType() ) && !errorGenerated ) {
//					err.incompatibleTypes(elType, expr.getType(), this);
//					errorGenerated = true;
//				}
//				for( int ci = 0; ci < choices.getChildNum(); ci++ ) {
//					IROper choice = choices.getChild(ci);
//					IRConst cnst;
//					if( choice instanceof IROperOthers ) {
//						memberIndexes.add(choice);
//						memberValues.add(expr);
////						othersInit = expr;
////						if( membersSize > 0 ) {
////							ensureSize(membersSize);
////							for( int mi = 0; mi < membersSize; mi++ ) {
////								if( memberValues.get( mi ) == null )  {
////									memberValues.set( mi, expr );
////								}
////							}
////						}
//					} else if( (cnst = IRConst.getConstantValue(choice, err)) != null ) {
//						memberIndexes.add(choice);
//						memberValues.add(expr);
////						SimValue v = cnst.getConstant();
////						int memIndex;// = cnst.getConstant().getIntValue();
////						if( v.getType().isInt() ) {
////							memIndex = v.getIntValue();
////						} else if( v.getType().isEnum() ) {
////							memIndex = v.getEnumValue().getValue();
////						} else {
////							throw new RuntimeException();
////						}
////						if( memIndex < low || memIndex > high ) {
////							err.indexOutOfRange(op);
////						}
////						if( arrayIndex.isDownTo().getBooleanValue() ) {
////							memIndex = high - memIndex;
////						} else {
////							memIndex = memIndex - low;
////						}
////						if( members.get(memIndex) != null ) {
////							err.multipleAssociationInAggregate(assoc);
////						}
////						members.set( memIndex, expr );
//					} else {
//						err.constantExpressionRequired(choice);
//					}
//				}
//			} else {
//				// ordered aggregate
//				if( aggType == AGG_TYPE.UNDEFINED || aggType == AGG_TYPE.ORDER ) {
//					aggType = AGG_TYPE.ORDER;
//				} else {
//					if( !mixingErrorGenerated ) err.mixingNamedAndOrderAggreg();
//					mixingErrorGenerated = true;
//				}
//				if( arrayIndex.isDownTo().getBooleanValue() ? index < lastIndex : index > lastIndex ) {
//					err.invalidAggregateLength(this, Math.abs(lastIndex - firstIndex) + 1);
//				}
//				op.setType( elType );
//				op.semanticCheck(err);
//				if( !elType.isAssignableFrom(op.getType()) ) {
//					err.incompatibleTypes(elType, op.getType(), this);
//				}
//				ensureSize( index + 1 );
//				members.set( index, op );
//				index += arrayIndex.isDownTo().getBooleanValue() ? -1 : +1;
//			}
//		}
//		checkAggregateComplete(err);
//	}
	
//	protected void checkRecord(IRErrorFactory err) throws CompilerError {
//		IRTypeRecord type = (IRTypeRecord) getType();
//		AGG_TYPE aggType = AGG_TYPE.UNDEFINED;
//		boolean mixingErrorGenerated = false;
//		int index = 0;
//		for( int ai = 0; ai < getChildNum(); ai++ ) {
//			IROper op = getChild(ai);
//			
//			// именованный агрегат
//			if( op instanceof IROperAssoc ) {
//				IRChoices choices = (IRChoices) op.getChild(0);
//				if( aggType == AGG_TYPE.UNDEFINED || aggType == AGG_TYPE.NAMED ) {
//					aggType = AGG_TYPE.NAMED;
//				} else if( !choices.isJustOthers() ){
//					if( !mixingErrorGenerated ) err.mixingNamedAndOrderAggreg();
//					mixingErrorGenerated = true;
//				}
//				for( int ci = 0; ci < choices.getChildNum(); ci++ ) {
//					IROper ch = choices.getChild(ci);
//					if( ch instanceof IROperOthers ) {
//						IROper expr = op.getChild(1);
//						if( ci + 1 != choices.getChildNum() ) {
//							err.othersShouldBeLast();
//						}
//						int othersMet = 0;
//						for( int mi = 0; mi < membersSize; mi++ ) {
//							ensureSize(mi+1);
//							if( members.get(mi) == null ) {
//								othersMet++;
//								IRRecordField f = type.fields.get(mi);
//								expr.setType( f.getType() );
//								expr.semanticCheck(err);
//								if( !f.getType().isAssignableFrom(expr.getType()) ) {
//									err.incompatibleTypes(f.getType(), expr.getType(), this);
//								}
//								ensureSize(mi+1);
//								members.set(mi, expr);
//							}
//						}
//						if( othersMet == 0 ) {
//							err.othersShouldBeAtLeastOne(this);
//						}
//						
//						// возможно совпадение имени поля и имени константы. в этом случае будет IRConstRead
//					} else if( ch instanceof IRName || ch instanceof IRConstRead ) {
//						String fName;
//						if( ch instanceof IRName ) {
//							fName = ((IRName)ch).name;
//						} else {
//							fName = ((IRConstRead)ch).getConstant().getName();
//						}
//						IRRecordField f = type.getField( fName );
//						if( f == null ) {
//							err.fieldNameExpected(ch);
//							continue;
//						}
//						IROper expr = op.getChild(1);
//						expr.setType( f.getType() );
//						expr.semanticCheck(err);
//						if( !f.getType().isAssignableFrom(expr.getType()) ) {
//							err.incompatibleTypes(f.getType(), expr.getType(), this);
//						}
//						if( members.size() > f.getIndex() && members.get(f.getIndex()) != null ) {
//							err.multipleAssociationInAggregate((IROperAssoc) op);
//						} else {
//							ensureSize(f.getIndex()+1);
//							members.set( f.getIndex(), expr );
//						}
//					} else {
//						err.fieldNameExpected(ch);
//					}
//				}
//			} else {
//				// ordered aggregate
//				if( aggType == AGG_TYPE.UNDEFINED || aggType == AGG_TYPE.ORDER ) {
//					aggType = AGG_TYPE.ORDER;
//				} else {
//					if( !mixingErrorGenerated ) err.mixingNamedAndOrderAggreg();
//					mixingErrorGenerated = true;
//				}
//				if( index >= type.fields.size() ) {
//					err.invalidAggregateLength(this, type.fields.size());
//				}
//				IRType fieldType = type.fields.get(index).getType();
//				op.setType( fieldType );
//				op.semanticCheck(err);
//				if( !fieldType.isAssignableFrom(op.getType()) ) {
//					err.incompatibleTypes(fieldType, op.getType(), this);
//				}
//				ensureSize(index+1);
//				members.set( index, op );
//				index++;
//			}
//		}
//		checkAggregateComplete(err);
//	}
	
//	protected void checkAggregateComplete( IRErrorFactory err ) {
//		for( int i = 0; i < membersSize; i++ ) {
//			if( members.get(i) == null ) {
//				err.invalidAggregateLength(this, membersSize);
//				return;
//			}
//		}
//	}
	
//	void setMember( int index, IROper expr ) {
//		members.set(index, expr);
//	}
	
	public IROper getMemberValue( int index ) {
		return memberValues.get(index);
	}
	
	public IROper getMemberIndex( int index ) {
		return memberIndexes.get(index);
	}
	
	public int getNumMembers() {
		if( memberValues == null ) {
			int a = 0;
			a++;
		}
		return memberValues.size();//membersSize;
	}

//	public IROper getOthersInit() {
//		return othersInit;
//	}

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
