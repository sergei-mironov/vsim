package com.prosoft.vhdl.ir.cfg;

public class ExitNode extends CFGNode {

	@Override
	public CFGNodeKind getKind() {
		return CFGNodeKind.EXIT;
	}

	@Override
	public CFGNode[] getOutgoing() {
		return new CFGNode[0];
	}

}
