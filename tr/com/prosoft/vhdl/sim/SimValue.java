package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRType;

public abstract class SimValue /*extends ProcessActivator*/ {
	
	protected SimValue(IRType type) {
//		super(null, null);
		this.type = type;
	}

	IRType type;

	public IRType getType() { return type; }
	public abstract StdLogic getStdLogicValue();
	public abstract int getIntValue();
	public abstract double getDoubleValue();
	public boolean getBoolean() {throw new RuntimeException();};
	public PhysicalValue getPhysicalValue() {throw new RuntimeException();};
	public abstract IREnumValue getEnumValue();
	public abstract boolean isEqualTo( SimValue otherValue );
	public abstract void assignFrom( SimValue otherValue );
	
	public int getNumComponents() {throw new RuntimeException();};
	public SimValue getComponent(int index) {throw new RuntimeException();};
	
	public int getIntOrEnumIndex(){throw new RuntimeException();};
	
	public boolean equals( Object obj ) {
		if( obj instanceof SimValue ) {
			return ((SimValue)obj).isEqualTo(this);
		}
		return false;
	}
}
