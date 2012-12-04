package com.prosoft.vhdl.ir.cfg;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.IRElement;


public class SequentalNodes extends IRElement {

	public SequentalNodes(IRElement parent) {
		super(parent);
	}

	ArrayList<CFGNode> nodes = new ArrayList<CFGNode>();
	
	public void add( CFGNode node ) {
		nodes.add(node);
	}
}
