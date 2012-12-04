package com.prosoft.vhdl.ir;

public interface ILocalResolver {

	IRNamedElement localResolve( String name );
	void localResolve( IRSubprogramSearchContext context );
	boolean contains( IRNamedElement el );
}
