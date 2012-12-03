package com.prosoft.vhdl.ir.cfg;

import com.prosoft.vhdl.ir.IROper;

public class IfNode extends CFGNode {
	
	IROper condition;
	CFGNode trueNode;
	CFGNode falseNode;
	
	@Override
	public CFGNode[] getOutgoing() {
		int count = (trueNode != null ? 1:0) + (falseNode != null ? 1:0);
		CFGNode[] res = new CFGNode[count];
		int i = 0;
		if( trueNode != null ) {
			res[i++] = trueNode;
		}
		if( falseNode != null ) {
			res[i++] = falseNode;
		}
		return res;
	}

	@Override
	public CFGNodeKind getKind() {
		return CFGNodeKind.IF;
	}

}
