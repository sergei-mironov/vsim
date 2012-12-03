package com.prosoft.vhdl.sim;

public class ExitException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	LoopEnvironment loop;
	
	public ExitException(LoopEnvironment loop) {
		this.loop = loop;
	}
	
	
}
