package com.prosoft.vhdl.ir.cfg;

public class EnterNode extends CFGNode {
	
	CFGNode next;

	@Override
	public CFGNodeKind getKind() {
		return CFGNodeKind.ENTER;
	}

	@Override
	public CFGNode[] getOutgoing() {
		return next != null ? new CFGNode[]{next} : new CFGNode[0];
	}

}
