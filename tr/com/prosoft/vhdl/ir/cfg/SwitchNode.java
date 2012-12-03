package com.prosoft.vhdl.ir.cfg;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.IROper;

public class SwitchNode extends CFGNode {
	
	class Case {
		IROper value;
		CFGNode target;
		
		public Case(IROper value, CFGNode target) {
			this.value = value;
			this.target = target;
		}
	}
	
	ArrayList<Case> cases = new ArrayList<Case>();
	
	IROper switchValue;
	
	public IROper getSwitchValue() {
		return switchValue;
	}

	public void setSwitchValue(IROper switchValue) {
		this.switchValue = switchValue;
	}

	public CFGNode getOthersTarget() {
		return othersTarget;
	}

	public void setOthersTarget(CFGNode othersTarget) {
		this.othersTarget = othersTarget;
	}

	CFGNode othersTarget;

	@Override
	public CFGNode[] getOutgoing() {
		CFGNode[] res = new CFGNode[cases.size()+1];
		res[0] = othersTarget;
		for( int i = 1; i < res.length; i++ ) {
			res[i] = cases.get(i).target;
		}
		return res;
	}
	
	public void addCase( IROper value, CFGNode target ) {
		cases.add( new Case(value, target) );
	}

	@Override
	public CFGNodeKind getKind() {
		return CFGNodeKind.SWITCH;
	}

}
