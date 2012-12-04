package com.prosoft.vhdl.sim;

public class ReturnException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	SimValue returnValue;

	public ReturnException(SimValue returnValue) {
		this.returnValue = returnValue;
	}

}
