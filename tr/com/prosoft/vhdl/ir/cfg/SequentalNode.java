package com.prosoft.vhdl.ir.cfg;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.IRStatement;

public class SequentalNode extends CFGNode {
	
	CFGNode nextNode;
	ArrayList<IRStatement> statements = new ArrayList<IRStatement>();

	@Override
	public CFGNode[] getOutgoing() {
		return nextNode != null ? new CFGNode[] {nextNode} : new CFGNode[0];
	}

	@Override
	public CFGNodeKind getKind() {
		return CFGNodeKind.SEQ;
	}

	public void add( IRStatement stat ) {
		this.statements.add(stat);
	}
}
