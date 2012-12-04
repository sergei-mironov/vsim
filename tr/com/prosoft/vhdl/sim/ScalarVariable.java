package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRVariable;


public class ScalarVariable extends ScalarData implements Variable {
	
	protected ScalarVariable(Simulator sim, AggregateData parent, String name, IRVariable desc, IRType type) {
		super(sim, parent, desc, name, type);
	}

	SimValue value;
	
	void assign( SimValue newValue ) {
		if( value == null || !value.isEqualTo(newValue) ) {
			//value.assignFrom( newValue );
			value = newValue;
		}
	}
	
	public String getName() {
		return name;//((IRVariable)description).getName();
	}
	
}
