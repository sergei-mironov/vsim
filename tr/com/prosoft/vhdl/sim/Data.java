package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRArrayIndex;
import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeArray;
import com.prosoft.vhdl.ir.IRTypeRecord;
import com.prosoft.vhdl.ir.IRangedElement;

public abstract class Data extends /*ProcessActivator*/ SimulationObject {
	
	String name;
	AggregateData parent;
	IRType type;
	
	protected Data(Simulator sim, AggregateData parent, IRElement desc, String name, IRType type) {
		super(sim, desc);
		this.parent = parent;
		this.name = name;
		this.type = type;
	}
	
	public abstract boolean isRecord();
	public abstract boolean isArray();
	public abstract boolean isScalar();
	
	public String getName() {
		return name;
	}
	
	public String toString() {
		return name;
	}
	
	public IRType getType() {
		return type;
	}
	
	public void assignValue( SimValue value, boolean drive ) {
		if( this instanceof ScalarSignal ) {
			ScalarSignal sc = (ScalarSignal) this;
			if( drive ) {
				sc.drivenValue = value;
			} /*else {*/
				sc.effectiveValue = value;
			//}
		} else if( this instanceof ScalarVariable ) {
			ScalarVariable var = (ScalarVariable) this;
			var.value = value;
		} else {
			AggregateData agg = (AggregateData) this;
			if( value.getType().isRecord() ) {
				IRTypeRecord type = (IRTypeRecord) value.getType();
				RecordValue rc = (RecordValue) value;
				for( int i = 0; i < type.getNumFields(); i++ ) {
					agg.fields[i].assignValue( rc.getFieldValue(i), drive);
				}
			} else {
				ArrayValue arr = (ArrayValue) value;
				for( int i = 0; i < agg.fields.length; i++ ) {
					agg.fields[i].assignValue(arr.getComponent(i) , drive);
				}
//				IRArrayIndex ind;
//				ArrayValue arr = (ArrayValue) value;
//				if( value.getType() instanceof IRTypeArray ) {
//					ind = ((IRTypeArray)value.getType()).getFirstIndex();
//				} else {
//					ind = (IRArrayIndex) value.getType();
//				}
//				int low = sim.getIntFromDescreteValue(ind.getRangeLow(), null);
//				int high = sim.getIntFromDescreteValue(ind.getRangeHigh(), null);
//				int size = high - low + 1;
//				for( int i = 0; i < size; i++ ) {
//					SimValue v = ind.isDownTo() ? arr.value[size-i-1] : arr.value[i];
//					agg.fields[i].assignValue(v, drive);
//				}
			}
		}
	}
	
	public SimValue getValue() {
		if( this instanceof ScalarSignal ) {
			ScalarSignal sc = (ScalarSignal) this;
			return sc.effectiveValue;
		} else if( this instanceof ScalarVariable ) {
			ScalarVariable var = (ScalarVariable) this;
			return var.value;
		} else {
			AggregateData agg = (AggregateData) this;
			if( getType().isRecord() ) {
				IRTypeRecord type = (IRTypeRecord) getType();
				RecordValue rc = new RecordValue( new SimValue[type.getNumFields()], type );
				for( int i = 0; i < type.getNumFields(); i++ ) {
					rc.values[i] = agg.fields[i].getValue();
				}
				return rc;
			} else {
				SimValue[] res = new SimValue[agg.fields.length];
				IRArrayIndex ind = IRTypeArray.getIndex(type, sim.err, null);
				for( int i = 0; i < res.length; i++ ) {
					SimValue v = agg.fields[i].getValue();
					res[i] = v;;
				}
				return new ArrayValue(type, res, ind.getArrayType().getElementType());
//				IRArrayIndex ind;
//				if( getType() instanceof IRTypeArray ) {
//					ind = ((IRTypeArray)getType()).getFirstIndex();
//				} else {
//					ind = (IRArrayIndex) getType();
//				}
//				
//				int low = sim.getIntFromDescreteValue(ind.getRangeLow(), null);
//				int high = sim.getIntFromDescreteValue(ind.getRangeHigh(), null);
//				int size = high - low + 1;
//				
//				ArrayValue arr = new ArrayValue(getType(), new SimValue[size], ind.getArrayType().getElementType());
//				
//				for( int i = 0; i < size; i++ ) {
//					SimValue v = agg.fields[i].getValue();
//					if( ind.isDownTo() ) {
//						arr.value[size-i-1] = v;
//					} else {
//						arr.value[i] = v;
//					}
//				}
//				return arr;
			}
		}
	}
	private String fullName;
	public String getFullName() {
		if( fullName == null ) {
			if( parent != null ) {
				String parentName = parent.getFullName();
				if( parent instanceof AggregateData && !((AggregateData)parent).isRecord ) {
					fullName = parentName + "(" + name + ")";
				} else {
					fullName = parentName + "." + name;
				}
			} else {
				fullName = name;
			}
		}
		return fullName;
	}
}
