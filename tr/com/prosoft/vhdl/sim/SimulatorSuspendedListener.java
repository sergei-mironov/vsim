package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRStatement;

public interface SimulatorSuspendedListener {

	void suspended( Simulator sim, IRStatement stat );
	void resumed(Simulator sim);
}
