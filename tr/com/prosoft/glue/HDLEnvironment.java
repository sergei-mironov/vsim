package com.prosoft.glue;

import com.prosoft.verilog.ir.VEnvironment;
import com.prosoft.vhdl.ir.IRErrorFactory;

public class HDLEnvironment {

	public final IRErrorFactory vhdlErr;
	public final VEnvironment verilogEnv;
	
	public HDLEnvironment(IRErrorFactory vhdlErr, VEnvironment verilogEnv) {
		this.vhdlErr = vhdlErr;
		this.verilogEnv = verilogEnv;
	}
	
}
