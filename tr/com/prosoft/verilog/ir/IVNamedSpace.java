package com.prosoft.verilog.ir;

public interface IVNamedSpace {

	VNameSpaceKind getKind();
	void put( VNamedElement el );
	VNamedElement get( String name );
}
