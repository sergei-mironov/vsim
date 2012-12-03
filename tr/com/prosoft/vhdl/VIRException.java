// Simple exception for VIR errors.
package com.prosoft.vhdl;

class VIRException extends Exception {
	public String msg;
	public VIRException(String msg) {
		this.msg = msg;
	}
}
