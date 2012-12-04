package com.prosoft.vhdl.ir.cfg;

import java.util.ArrayList;

public abstract class CFGNode {
	
	ArrayList<CFGNode> incoming = new ArrayList<CFGNode>();
	
	public CFGNode[] getIncoming() {
		return incoming.toArray( new CFGNode[incoming.size()] );
	}

	public abstract CFGNode[] getOutgoing();
	public abstract CFGNodeKind getKind();
}
