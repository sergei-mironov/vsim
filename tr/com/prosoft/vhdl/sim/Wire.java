package com.prosoft.vhdl.sim;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.IRArrayIndex;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeArray;
import com.prosoft.vhdl.ir.IRTypeInteger;
import com.prosoft.vhdl.sim.Simulator.SIM_MODE;

//import com.prosoft.vhdl.ir.IRType;
//import com.prosoft.vhdl.ir.IRTypeEnum;
//import com.prosoft.vhdl.ir.IRTypeInteger;
//import com.prosoft.vhdl.ir.IRTypeReal;

public class Wire {
	
	IRType type;
	Simulator sim;

	ArrayList<ScalarSignal> drivers = new ArrayList<ScalarSignal>();
	ArrayList<ScalarSignal> listeners = new ArrayList<ScalarSignal>();
	
//	final SimValue value;
	
//	public Wire( IRType type ) {
//		if( type.isInt() ) {
//			value = new IntValue((IRTypeInteger) type, 0);
//		} else if( type.isReal() ) {
//			value = new RealValue((IRTypeReal) type, 0);
//		} else if( type.isEnum() ) {
//			value = new EnumSimValue(((IRTypeEnum)type).getValue(0));
//		} else {
//			throw new RuntimeException();
//		}
//	}
	
	public Wire(Simulator sim, IRType type) {
		this.sim = sim;
		this.type = type;
	}
	
	void updateDriver( ScalarSignal driver ) {
		if( !drivers.contains(driver) ) {
			drivers.add(driver);
		}
		IRFunction func = type.getResolutionFunction(sim.err);
		IRTypeArray arrType = new IRTypeArray(type.getPackage(), "array_of_" + type.getName(), type);
		arrType.add( new IRArrayIndex(type.getPackage(), arrType.getName(),
				IRTypeInteger.createConstant(drivers.size()),
				IRTypeInteger.createConstant(1), sim.getTypeBoolean().getValue(0).getSimValue(), IRTypeInteger.TYPE) );
		
		SimValue[] values = new SimValue[drivers.size()];
		for( int i = 0; i < values.length; i++ ) {
			values[i] = drivers.get(i).getDrivenValue();
		}
		ArrayValue value = new ArrayValue(arrType, values, type);
		
		sim.ignoreBreakPoints = true;
		SimValue resolved = sim.executeFunction( func, new SimValue[] {value}, null );
		sim.ignoreBreakPoints = false;
		
		for( int i = 0; i < listeners.size(); i++ ) {
			listeners.get(i).updateEffectiveValue(resolved);
		}
	}

	public void add( ScalarSignal sig, boolean addDriver, boolean addListener ) {
		sig.setWire(this);
		if( addDriver && !drivers.contains(sig) )
			drivers.add(sig);
		if( addListener && !listeners.contains(sig) )
			listeners.add(sig);
		sim.putWire(sig, this);
	}

}
