package com.prosoft.vhdl.ir;

public interface IRErrorHandler {

	void handleError(String str);
	public int getErrorCount();
	boolean isOkToThrowException();
}
