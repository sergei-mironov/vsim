package com.prosoft.vhdl.ir;

public interface IRTypeHolder extends IREnumHolder {

	void addType( IRType type );
	IRType getType( String name );
	boolean containsType( IRType type );
}
